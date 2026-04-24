import 'package:cached_network_image/cached_network_image.dart';
import 'package:exams_app/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/models/subject_model.dart';

class SubjectItem extends StatelessWidget {
  final SubjectModel subject;

  const SubjectItem({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
          color: theme.cardColor,
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
            Text(subject.name ?? "", style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}
