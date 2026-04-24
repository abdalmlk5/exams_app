import 'package:exams_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionButton extends StatelessWidget {
  final QuestionButtonType questionButtonType;
  final void Function()? onPressed;
  final bool isLoading;
  final bool isDisabled;

  const QuestionButton({
    super.key,
    required this.questionButtonType,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool effectivelyDisabled = isLoading || isDisabled;

    final Color borderColor = theme.colorScheme.primary;

    final Color bgColor = questionButtonType == QuestionButtonType.back
        ? (effectivelyDisabled ? AppColors.black10 : AppColors.white)
        : (effectivelyDisabled ? AppColors.black20 : theme.colorScheme.primary);

    final Color fgColor = questionButtonType == QuestionButtonType.back
        ? (effectivelyDisabled ? AppColors.black20 : theme.colorScheme.primary)
        : AppColors.white;

    return Opacity(
      opacity: isDisabled && !isLoading ? 0.5 : 1.0,
      child: SizedBox(
        height: 48.h,
        width: 163.w,
        child: ElevatedButton(
          onPressed: effectivelyDisabled ? null : onPressed,
          style: ElevatedButton.styleFrom(
            side: BorderSide(color: borderColor),
            backgroundColor: bgColor,
            foregroundColor: fgColor,
            disabledBackgroundColor: bgColor,
            disabledForegroundColor: fgColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
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
                  style: const TextStyle(fontSize: 15),
                ),
        ),
      ),
    );
  }
}

enum QuestionButtonType { back, next, finish }
