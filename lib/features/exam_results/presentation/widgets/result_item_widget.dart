import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/exam_results/domain/entities/exam_result_entity.dart';
import 'package:exams_app/features/exam_results/presentation/pages/exam_answers_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultItemWidget extends StatelessWidget {
  final ExamResultEntity result;

  const ResultItemWidget({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ExamAnswersPage(detailedAnswers: result.detailedAnswers),
            ),
          );
        },
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: theme.cardColor,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black10,
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              // Icon Container
              Container(
                width: 64.w,
                height: 64.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/3DIcons/Profit.png',
                    width: 48.w,
                    height: 48.h,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.assignment,
                      size: 32.sp,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          result.title,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.titleMedium?.color,
                          ),
                        ),
                        Text(
                          "${result.duration} ${AppStrings.minutes}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.textTheme.bodyLarge?.color,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "${result.numberOfQuestions} ${AppStrings.question}",
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.placeholder,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "${result.correctAnswers} ${AppStrings.correctedAnswersIn} ${result.timeTakenMinutes} ${AppStrings.minLabel}.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
