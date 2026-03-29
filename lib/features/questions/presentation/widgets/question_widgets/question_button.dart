import 'package:exams_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionButton extends StatelessWidget {
  final QuestionButtonType questionButtonType;
  final void Function()? onPressed;
  final bool isLoading;

  const QuestionButton({
    super.key,
    required this.questionButtonType,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: 163.w,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: isLoading ? Colors.grey : AppColors.primary),
          backgroundColor: questionButtonType == QuestionButtonType.back
              ? AppColors.white
              : (isLoading ? Colors.grey[300] : AppColors.primary),
          foregroundColor: questionButtonType == QuestionButtonType.back
              ? AppColors.primary
              : AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.white,
                ),
              )
            : Text(
                questionButtonType == QuestionButtonType.back
                    ? "Back"
                    : questionButtonType == QuestionButtonType.next
                    ? "Next"
                    : questionButtonType == QuestionButtonType.finish
                    ? "Finish"
                    : '',
              ),
      ),
    );
  }
}

enum QuestionButtonType { back, next, finish }
