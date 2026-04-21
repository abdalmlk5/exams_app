import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        primaryColor: AppColors.primary,
        
        // App Bar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: AppStyles.black20500,
          iconTheme: const IconThemeData(color: AppColors.black),
        ),

        // Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            disabledBackgroundColor: AppColors.black30,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
        ),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: const TextStyle(color: AppColors.black30),
          hintStyle: AppStyles.placeholder14400,
          errorStyle: const TextStyle(color: AppColors.error),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          border: _border(AppColors.black30),
          enabledBorder: _border(AppColors.black30),
          focusedBorder: _border(AppColors.primary, 2),
          errorBorder: _border(AppColors.error),
          focusedErrorBorder: _border(AppColors.error, 2),
        ),
      );

  static OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: color, width: width),
      );
}
