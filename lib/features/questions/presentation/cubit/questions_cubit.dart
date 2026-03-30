import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:exams_app/config/error_handler/error_handler.dart';
import 'package:injectable/injectable.dart';
import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/features/questions/domain/usecases/get_questions_usecase.dart';
import 'package:exams_app/features/questions/domain/usecases/submit_answers_usecase.dart';
import 'package:exams_app/features/questions/domain/entities/check_questions_response_entity.dart';
import 'package:exams_app/features/questions/domain/entities/question_entity.dart';
import 'package:exams_app/features/questions/domain/entities/submit_answers_request_entity.dart';
import 'package:exams_app/features/questions/domain/entities/answer_check_item_entity.dart';
import 'package:exams_app/config/base_response/base_response.dart';

part 'questions_state.dart';

@injectable
class QuestionsCubit extends Cubit<BaseState<ExamData>> {
  final GetQuestionsUsecase getQuestionsUsecase;
  final SubmitAnswersUsecase submitAnswersUsecase;
  Timer? _timer;

  QuestionsCubit(this.getQuestionsUsecase, this.submitAnswersUsecase)
    : super(const BaseState<ExamData>());

  /// get questions
  Future<void> getQuestions(String examId) async {
    try {
      // louding
      emit(state.copyWith(isLoading: true, errorMessage: null));

      // get the questions
      final result = await getQuestionsUsecase(examId: examId);
      if (isClosed) return;

      // success result or error result
      switch (result) {
        // success
        case SuccessBaseResponse<List<QuestionEntity>>():

          // handle the data
          final questions = result.data;

          final totalTime = questions.isNotEmpty && questions.first.exam != null
              ? questions.first.exam!.duration
              : 30; // default 30 minutes

              //TODO  1 for test


          // emit the data
          emit(
            state.copyWith(
              isLoading: false,
              data: ExamData(
                questions: questions,
                totalTimeInMinutes: totalTime,
                remainingTimeInSeconds: totalTime * 60,
              ),
            ),
          );

          // once the data emited (the exam start)
          _startTimer();

        // error
        case ErrorBaseResponse<List<QuestionEntity>>():
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: ErrorHandler.handle(result.errorMessage),
            ),
          );
      }
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: ErrorHandler.handle(e)),
      );
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.data == null) return;

      final currentRemaining = state.data!.remainingTimeInSeconds;
      if (currentRemaining > 0) {
        emit(
          state.copyWith(
            data: state.data!.copyWith(
              remainingTimeInSeconds: currentRemaining - 1,
            ),
          ),
        );
      } else {
        _timer?.cancel();
        emit(state.copyWith(data: state.data!.copyWith(isTimeOut: true)));
      }
    });
  }

  void selectAnswer(String questionId, String answerKey) {
    if (state.data == null || state.data!.isTimeOut) return;

    final newAnswers = Map<String, String>.from(state.data!.selectedAnswers);
    newAnswers[questionId] = answerKey;

    emit(
      state.copyWith(data: state.data!.copyWith(selectedAnswers: newAnswers)),
    );
  }

  /// go to next question
  void nextQuestion() {
    if (state.data == null) return;

    final currentQuestionId =
        state.data!.questions[state.data!.currentIndex].id;
    final hasAnswered = state.data!.selectedAnswers.containsKey(
      currentQuestionId,
    );

    if (state.data!.currentIndex < state.data!.questions.length - 1) {
      if (!hasAnswered) {
        // Emit error to show a red note/snackbar
        emit(
          state.copyWith(
            errorMessage:
                "You skipped a question. Note that all questions must be answered.",
          ),
        );
        // Clear error message and proceed to next question
        emit(
          BaseState<ExamData>(
            data: state.data!.copyWith(
              currentIndex: state.data!.currentIndex + 1,
            ),
            isLoading: state.isLoading,
          ),
        );
      } else {
        emit(
          state.copyWith(
            data: state.data!.copyWith(
              currentIndex: state.data!.currentIndex + 1,
            ),
          ),
        );
      }
    }
  }

  /// back to previous question
  void previousQuestion() {
    if (state.data == null) return;

    if (state.data!.currentIndex > 0) {
      emit(
        state.copyWith(
          data: state.data!.copyWith(
            currentIndex: state.data!.currentIndex - 1,
          ),
        ),
      );
    }
  }

  /// submit the answers after finishing the exam
  Future<void> submitAnswers({bool fromTimeOut = false}) async {
    try {
      // once the data from the response not null
      if (state.data == null) return;

      if (state.data!.selectedAnswers.length < state.data!.questions.length) {
          emit(
            state.copyWith(
              errorMessage: "Please answer all questions before submitting.",
            ),
          );
          // Clear the error message so it doesn't linger
          emit(
            BaseState<ExamData>(data: state.data, isLoading: state.isLoading),
          );
          emit(
            state.copyWith(
              errorMessage: "You submitted the exam with unanswered questions.",
            ),
          );
          // Clear the error message so it doesn't linger
          emit(
            BaseState<ExamData>(data: state.data, isLoading: state.isLoading),
          );
        
      }

      // cancel the timer
      _timer?.cancel();
      emit(state.copyWith(isLoading: true, errorMessage: null));

      final timeTaken =
          state.data!.totalTimeInMinutes - (state.data!.remainingTimeInSeconds ~/ 60);

      final answersPayload = state.data!.questions.map((q) {
        final answerKey = state.data!.selectedAnswers[q.id];
        return AnswerCheckItemEntity(
          questionId: q.id,
          correct: answerKey ?? "false",
        );
      }).toList();

      final result = await submitAnswersUsecase(
        body: SubmitAnswersRequestEntity(
          answers: answersPayload,
          time: timeTaken,
        ),
      );

      if (isClosed) return;

      switch (result) {
        case SuccessBaseResponse<CheckQuestionsResponseEntity>():
          emit(
            state.copyWith(
              isLoading: false,
              data: state.data!.copyWith(result: result.data),
            ),
          );
        case ErrorBaseResponse<CheckQuestionsResponseEntity>():
          emit(state.copyWith(isLoading: false, errorMessage: result.errorMessage));
      }
    } catch (e) {
      emit(
        state.copyWith(isLoading: false, errorMessage: ErrorHandler.handle(e)),
      );
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
