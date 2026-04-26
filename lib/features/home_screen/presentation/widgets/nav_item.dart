import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';

BottomNavigationBarItem navItem({
  required String icon,
  required String label,
  required int index,
  required int selectedIndex,
}) {
  bool isSelected = selectedIndex == index;
  return BottomNavigationBarItem(
    icon: isSelected
        ? Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.blue10,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.symmetric(vertical: 4.h),
            child: SvgPicture.asset(
              icon,
              width: 24.w,
              height: 24.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
          ),
    label: label,
  );
}
