import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static ThemeData get mainTheme {
    return ThemeData(
      scaffoldBackgroundColor: AppColors.white,
      useMaterial3: true,

      // app bar  theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.black18500,
        iconTheme: const IconThemeData(color: AppColors.black),
      ),

      // text theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.black20500,
        titleLarge: AppTextStyles.black18500,
        bodyLarge: AppTextStyles.black16400,
        bodyMedium: AppTextStyles.black13400,
        bodySmall: AppTextStyles.black12400,
        labelLarge: AppTextStyles.blue14700,
      ),

      // divider
      dividerTheme: DividerThemeData(color: AppColors.black30, thickness: 1),

      // color scheme
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.white,
        secondary: AppColors.black,
        onSecondary: AppColors.white,
        tertiary: AppColors.black30,
        error: AppColors.error,
        onError: AppColors.white,
        surface: AppColors.white,
        onSurface: AppColors.black,
      ),

      // checkbox theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.primary;
          }
          return Colors.white;
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      // elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.black30,
          elevation: 0,
          minimumSize: Size(double.infinity, 48.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.r),
          ),
          textStyle: AppTextStyles.white16500,
        ),
      ),

      // text button theme
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTextStyles.blue14700,
        ),
      ),

      // text field
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        hintStyle: AppTextStyles.gray14400,
        labelStyle: AppTextStyles.black12400,
        errorStyle: TextStyle(color: AppColors.error, fontSize: 12.sp),
        border: _border(AppColors.black30),
        enabledBorder: _border(AppColors.black30),
        focusedBorder: _border(AppColors.primary, 1.5),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, 1.5),
      ),
    );
  }
}

OutlineInputBorder _border(Color color, [double width = 1]) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(4.r),
      borderSide: BorderSide(color: color, width: width),
    );
