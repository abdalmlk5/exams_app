import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_strings.dart';

import '../../../../../core/utils/app_routes.dart';

class RememberMeAndForgetPassword extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const RememberMeAndForgetPassword({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
              ),
            ),
            SizedBox(width: 8.w),
            Text(AppStrings.rememberMe, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.forgetPassword);
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            foregroundColor: AppColors.primary,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            AppStrings.forgetPasswordQuestion,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  decoration: TextDecoration.underline,
                ),
          ),
        ),
      ],
    );
  }
}
