import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/exam_results/domain/entities/exam_result_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamAnswersPage extends StatelessWidget {
  final List<DetailedAnswerEntity> detailedAnswers;

  const ExamAnswersPage({super.key, required this.detailedAnswers});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.answers,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: detailedAnswers.length,
        itemBuilder: (context, index) {
          final answer = detailedAnswers[index];
          return _buildQuestionCard(context, answer, index + 1);
        },
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, DetailedAnswerEntity answer, int index) {
    final theme = Theme.of(context);
    
    final correctAnswerKey = answer.correctAnswerKey.trim();
    final userSelectedKey = answer.userSelectedKey.trim();
    final isUserCorrect = userSelectedKey == correctAnswerKey;

    return Container(
      margin: EdgeInsets.only(bottom: 24.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            answer.questionText,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(height: 20.h),
          ...answer.options.map((option) {
            final optionKey = option.key.trim();
            final isCorrectOption = optionKey == correctAnswerKey;
            final isUserSelected = optionKey == userSelectedKey;

            // Default Styles (Unselected)
            Color bgColor = AppColors.lightBlue; 
            Color borderColor = Colors.transparent;
            Color iconColor = AppColors.primary; 
            Widget icon;

            bool isMulti = answer.type.toLowerCase().contains('multi');

            if (isCorrectOption) {
              bgColor = AppColors.lightGreen; 
              borderColor = AppColors.success; 
              iconColor = AppColors.success;
              icon = Icon(
                isMulti ? Icons.check_box : Icons.check_circle_rounded,
                size: 24.sp,
                color: iconColor,
              );
            } else if (isUserSelected && !isUserCorrect) {
              bgColor = AppColors.lightRed; 
              borderColor = AppColors.error; 
              iconColor = AppColors.error;
              icon = Icon(
                isMulti ? Icons.disabled_by_default : Icons.cancel_rounded,
                size: 24.sp,
                color: iconColor,
              );
            } else {
              // Normal state
              if (isMulti) {
                icon = Icon(Icons.check_box_outline_blank, size: 24.sp, color: iconColor);
              } else {
                icon = Icon(Icons.radio_button_off, size: 24.sp, color: iconColor);
              }
            }

            return Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: borderColor, width: 1.5),
              ),
              child: Row(
                children: [
                  icon,
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      option.text,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.black,
                        fontWeight: (isCorrectOption || isUserSelected) ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
