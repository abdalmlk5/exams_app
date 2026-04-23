import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppTextStyles {
  // Black Styles
  static TextStyle black20500 = GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  static TextStyle black13400 = GoogleFonts.inter(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle black16400 = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle black12400 = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black,
  );

  static TextStyle black18500 = GoogleFonts.inter(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.black,
  );

  // Gray Styles
  static TextStyle gray14400 = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black30,
  );

  // error Styles
  static TextStyle error14400 = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.black30,
  );

  static TextStyle gray12400 = GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.gray,
  );

  // White Styles
  static TextStyle white16500 = GoogleFonts.inter(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  // Place holder Styles
  static TextStyle placeholder13400 = GoogleFonts.inter(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.placeholder,
  );
  // Blue Styles
  static TextStyle blue14700 = GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
    decoration: TextDecoration.underline,
  );
}
