import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:exams_app/core/utils/app_styles.dart';

class ScoreMetricRow extends StatelessWidget {
  final String label;
  final int count;
  final Color color;

  const ScoreMetricRow({
    super.key,
    required this.label,
    required this.count,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: AppStyles.black16400.copyWith(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 70),
        Container(
          width: 25.w,
          height: 25.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 1.5),
          ),
          child: Text(
            count.toString(),
            style: AppStyles.black12400.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
