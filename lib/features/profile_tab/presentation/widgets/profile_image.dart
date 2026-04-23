import 'package:exams_app/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/utils/app_colors.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100.w,
          height: 100.h,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue10,
          ),
          child: Center(
            child: SvgPicture.asset(
              AppIcons.person,
              width: 60.w,
              height: 60.h,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.blue40,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: SvgPicture.asset(
              AppIcons.photoCamera,
              width: 16.w,
              height: 16.h,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
