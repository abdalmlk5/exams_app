import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionsTracker extends StatelessWidget {
  final int totalQuestions;
  final int currentQuestion;
  const QuestionsTracker({
    super.key,
    required this.totalQuestions,
    required this.currentQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Question $currentQuestion of $totalQuestions",
            style: AppStyles.black18500,
          ),
          LinearProgressIndicator(
            value: currentQuestion / totalQuestions,
            minHeight: 6,
            color: AppColors.primary,
            backgroundColor: AppColors.black10,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
