import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionPage extends StatelessWidget {
  final String examId;
  const QuestionPage({super.key, required this.examId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<QuestionsCubit, BaseState<ExamData>>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.data?.isTimeOut != current.data?.isTimeOut ||
          previous.data?.result != current.data?.result,
      listener: (context, state) {
        // If result is present, navigate to ScorePage and replace current page
        if (state.data?.result != null && state.isLoading == false) {
          // Dismiss timeout dialog if it's open
          if (state.data?.isTimeOut == true) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          
          CustomSnackBar.success(context, "Finish");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ExamScorePage(score: state.data!.result!),
            ),
          );
          return;
        }

        // If we have data and an error, it's a validation warning (skip/submit check)
        if (state.errorMessage != null && state.data != null) {
          CustomSnackBar.error(context, state.errorMessage!);
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
          return Scaffold(
            body: Center(
              child: Text(
                state.errorMessage!,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          );
        }
        if (state.data == null) {
          return Scaffold(
            body: Center(
              child: Text(
                "No data available",
                style: theme.textTheme.bodyLarge,
              ),
            ),
          );
        }
        final question = state.data!.currentQuestion;
        return Scaffold(
          // exam title and timer
          appBar: QuestionsAppBar(
            title: question!.exam!.title,
            time: state.data!.formattedRemainingTime,
            remainingSeconds: state.data!.remainingTimeInSeconds,
            totalSeconds: state.data!.totalTimeInMinutes * 60,
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15),
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
                  SizedBox(
                    height: 80.h,
                    width: double.infinity,
                    child: Text(
                      question.question,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),

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
                        onPressed: () {
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
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
