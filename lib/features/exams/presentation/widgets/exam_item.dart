import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_routes.dart';
import '../../../../core/utils/app_text_styles.dart';

class ExamItem extends StatelessWidget {
  final ExamEntity exam;

  const ExamItem({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.examDetailsPage,
          arguments: exam,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(App3DIcons.profit, width: 60.w, height: 60.h),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(exam.title ?? "", style: AppTextStyles.black16400),
                      Text(
                        "${exam.duration} ${AppStrings.minutes}",
                        style: AppTextStyles.blue14700.copyWith(
                          fontSize: 12.sp,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "${exam.numberOfQuestions} ${AppStrings.question}",
                    style: AppTextStyles.gray12400,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "${AppStrings.from}: 1.00  ${AppStrings.to}: 6.00",
                    style: AppTextStyles.black12400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
