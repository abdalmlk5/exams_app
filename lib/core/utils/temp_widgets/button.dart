import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';
import '../app_styles.dart';

class AppButton extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final BorderSide? borderSide;
  final TextStyle? textStyle;
  final double? borderRadius;

  const AppButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderSide,
    this.textStyle,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 48.h,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? 100.r,
            ), // Capsule shape by default
            side: borderSide ?? BorderSide.none,
          ),
        ),
        child: Text(
          title,
          style:
              textStyle ??
              AppStyles.white16500.copyWith(
                color: textColor ?? AppColors.white,
              ),
        ),
      ),
    );
  }

  // Factory for the Outline Button style (like "Back" or "Start again")
  factory AppButton.outline({
    required String title,
    VoidCallback? onPressed,
    double? width,
    double? height,
  }) {
    return AppButton(
      title: title,
      onPressed: onPressed,
      backgroundColor: Colors.transparent,
      textColor: AppColors.primary,
      width: width,
      height: height,
      borderSide: const BorderSide(color: AppColors.primary, width: 1),
      textStyle: AppStyles.black16400.copyWith(color: AppColors.primary),
    );
  }
}
