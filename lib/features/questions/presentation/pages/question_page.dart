import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:exams_app/features/questions/presentation/cubit/question_event.dart';
import 'package:exams_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:exams_app/features/questions/presentation/pages/exam_score_page.dart';
import 'package:exams_app/features/questions/presentation/widgets/question_widgets/answer_widget.dart';
import 'package:exams_app/features/questions/presentation/widgets/question_widgets/question_button.dart';
import 'package:exams_app/features/questions/presentation/widgets/question_widgets/questions_app_bar.dart';
import 'package:exams_app/features/questions/presentation/widgets/question_widgets/questions_tracker.dart';
import 'package:exams_app/features/questions/presentation/widgets/question_widgets/show_time_out_alert_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuestionPage extends StatelessWidget {
  final String examId;
  const QuestionPage({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuestionsCubit, BaseState<ExamData>>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.data?.isTimeOut != current.data?.isTimeOut ||
          previous.data?.result != current.data?.result,
      listener: (context, state) {
        // If result is present, navigate to ScorePage and replace current page
        if (state.data?.result != null && state.isLoading == false) {
          // If the timeout dialog is open when results arrive, we need to ensure the dialog context is dismissed or the new page is pushed on top appropriately
          // Navigator.pop(context) might be dangerous if no dialog is open, so we use pushReplacement for the scaffold
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ExamScorePage(result: state.data!.result!),
            ),
          );
          return;
        }

        // If we have data and an error, it's a validation warning (skip/submit check)
        if (state.errorMessage != null && state.data != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage!,
                style: const TextStyle(color: AppColors.white),
              ),
              backgroundColor: AppColors.error,
              duration: const Duration(seconds: 2),
            ),
          );
        }

        // Trigger the 'Time out !!' Dialog
        if (state.data?.isTimeOut == true) {
          ShowTimeOutAlert.show(context);
        }
      },
      builder: (context, state) {
        if (state.isLoading && state.data == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state.errorMessage != null && state.data == null) {
          return Scaffold(body: Center(child: Text(state.errorMessage!)));
        }
        if (state.data == null) {
          return const Scaffold(body: Center(child: Text("No data available")));
        }
        final question = state.data!.currentQuestion;
        return Scaffold(
          // exam title and timer
          appBar: QuestionsAppBar(
            title: question!.exam!.title,
            time: state.data!.formattedRemainingTime,
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // exam tracker
                  QuestionsTracker(
                    totalQuestions: state.data!.questions.length,
                    currentQuestion: state.data!.currentIndex + 1,
                  ),

                  const SizedBox(height: 24),

                  // Question
                  Text(question.question, style: AppStyles.black16400),

                  const SizedBox(height: 32),

                  // answers
                  Column(
                    children: question.answers.map((answer) {
                      return AnswerWidget(
                        text: answer.answer,
                        value: answer.key,
                        groupValue: state.data!.selectedAnswers[question.id],
                        onSelect: (value) {
                          context.read<QuestionsCubit>().doEvent(
                            SelectAnswersEvent(
                              questionId: question.id,
                              answerKey: value,
                            ),
                          );
                        },
                      );
                    }).toList(),

                    // buttons
                  ),

                  const Spacer(),

                  Row(
                    mainAxisAlignment: state.data!.currentIndex == 0
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceBetween,
                    children: [
                      if (state.data!.currentIndex > 0)
                        QuestionButton(
                          questionButtonType: QuestionButtonType.back,
                          onPressed: () {
                            context.read<QuestionsCubit>().doEvent(
                              PerviousQuestionsEvent(),
                            );
                          },
                        ),
                      QuestionButton(
                        questionButtonType: state.data!.isLastQuestion
                            ? QuestionButtonType.finish
                            : QuestionButtonType.next,
                        isLoading:
                            state.isLoading && state.data!.isLastQuestion,
                        onPressed:
                            (state.data!.isLastQuestion &&
                                state.data!.selectedAnswers.length <
                                    state.data!.questions.length)
                            ? null
                            : () {
                                if (state.data!.isLastQuestion) {
                                  context.read<QuestionsCubit>().doEvent(
                                    SubmitAnswersEvent(),
                                  );
                                } else {
                                  context.read<QuestionsCubit>().doEvent(
                                    NextQuestionsEvent(),
                                  );
                                }
                              },
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
