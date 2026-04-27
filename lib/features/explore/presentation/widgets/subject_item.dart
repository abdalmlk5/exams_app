import 'package:cached_network_image/cached_network_image.dart';
import 'package:exams_app/core/utils/app_routes.dart';
import 'package:exams_app/features/explore/domain/entities/subject_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SubjectItem extends StatelessWidget {
  final SubjectEntity subject;

  const SubjectItem({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.examsPage,
          arguments: subject.id,
        );
      },
      child: Container(
        height: 80.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: subject.icon ?? "",
              width: 48.w,
              height: 48.h,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            SizedBox(width: 16.w),
            Text(subject.name ?? "", style: AppTextStyles.black16400),
          ],
        ),
      ),
    );
  }
}
