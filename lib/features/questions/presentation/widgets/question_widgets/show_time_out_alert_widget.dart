import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/features/questions/presentation/cubit/question_event.dart';
import 'package:flutter/material.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:exams_app/features/questions/presentation/cubit/questions_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowTimeOutAlert {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return PopScope(
          canPop: false, // Prevents Android hardware back button
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            content: BlocProvider.value(
              value: context.read<QuestionsCubit>(),
              child: BlocBuilder<QuestionsCubit, BaseState<ExamData>>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/3DIcons/sand-clock.svg"),
                          const SizedBox(width: 12),
                          Text(
                            "Time out !!",
                            style: AppStyles.black18500.copyWith(
                              color: Colors.red,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: (state.isLoading)
                              ? null
                              : () {
                                  context.read<QuestionsCubit>().doEvent(
                                    SubmitAnswersEvent(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: (state.isLoading)
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: AppColors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  "View score",
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
