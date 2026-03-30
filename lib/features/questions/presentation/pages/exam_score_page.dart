import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/features/home_screen/presentation/pages/home_screen.dart';
import 'package:exams_app/features/questions/domain/entities/check_questions_response_entity.dart';
import 'package:exams_app/features/questions/presentation/widgets/exam_score_widgets/score_donut_chart.dart';
import 'package:exams_app/features/questions/presentation/widgets/exam_score_widgets/score_metric_row.dart';
import 'package:flutter/material.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamScorePage extends StatelessWidget {
  final CheckQuestionsResponseEntity result;

  const ExamScorePage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // Parse percentage
    final totalPercentString = result.total.replaceAll('%', '').trim();
    final totalPercent = double.tryParse(totalPercentString) ?? 0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          ),
        ),
        title: Text(
          "Exam score",
          style: AppStyles.black20500.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Text(
              "Your score",
              style: AppStyles.black18500.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                // Donut Chart
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ScoreDonutChart(percentage: totalPercent),
                    Text(
                      "${totalPercent.toInt()}%",
                      style: AppStyles.black18500.copyWith(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF32353A),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 40.w),
                // Scores details
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ScoreMetricRow(
                      label: "Correct",
                      count: result.correct,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 12.h),
                    ScoreMetricRow(
                      label: "Incorrect",
                      count: result.wrong,
                      color: AppColors.error,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 50.h),

            // Buttons
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text("Show results", style: AppStyles.white16500),
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              height: 50.h,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                child: Text(
                  "Start again",
                  style: AppStyles.black16400.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
