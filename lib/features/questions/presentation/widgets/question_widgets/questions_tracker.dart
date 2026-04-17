import 'package:exams_app/core/utils/app_colors.dart';
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
    final theme = Theme.of(context);
    return SizedBox(
      height: 40.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Question $currentQuestion of $totalQuestions",
            style: theme.textTheme.bodyLarge,
          ),
          LinearProgressIndicator(
            value: currentQuestion / totalQuestions,
            minHeight: 6,
            color: theme.colorScheme.primary,
            backgroundColor: AppColors.black10,
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
