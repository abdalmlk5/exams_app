import 'dart:math';
import 'package:exams_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScoreDonutChart extends StatelessWidget {
  final double percentage;
  final Color backgroundColor;
  final Color progressColor;

  const ScoreDonutChart({
    super.key,
    required this.percentage,
    this.backgroundColor = AppColors.error,
    this.progressColor = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(120.w, 120.w),
      painter: _DonutCustomPainter(
        correctPercentage: percentage / 100,
        backgroundColor: backgroundColor,
        progressColor: progressColor,
      ),
    );
  }
}

class _DonutCustomPainter extends CustomPainter {
  final double correctPercentage;
  final Color backgroundColor;
  final Color progressColor;

  _DonutCustomPainter({
    required this.correctPercentage,
    required this.backgroundColor,
    required this.progressColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 10.w;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (min(size.width, size.height) - strokeWidth) / 2;
    final double gapAngle = correctPercentage == 0 ? 0 : correctPercentage == 100 ? 0 : 0.25; 

    final basePaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double totalAvailableSweep = 2 * pi - (2 * gapAngle);
    final double progressSweep = totalAvailableSweep * correctPercentage;
    final double remainingSweep = totalAvailableSweep * (1 - correctPercentage);

    final double startAngle = -pi / 2 + (gapAngle / 2);

    if (progressSweep > 0) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        progressSweep,
        false,
        progressPaint,
      );
    }

    if (remainingSweep > 0) {
      final double backgroundStartAngle = startAngle + progressSweep + gapAngle;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        backgroundStartAngle,
        remainingSweep,
        false,
        basePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
