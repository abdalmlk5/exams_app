import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/features/home_screen/presentation/pages/home_screen.dart';
import 'package:exams_app/features/questions/domain/entities/check_questions_response_entity.dart';
import 'package:exams_app/features/questions/presentation/widgets/exam_score_widgets/score_donut_chart.dart';
import 'package:exams_app/features/questions/presentation/widgets/exam_score_widgets/score_metric_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExamScorePage extends StatelessWidget {
  final CheckQuestionsResponseEntity score;

  const ExamScorePage({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Parse percentage
    final totalPercentString = score.total.replaceAll('%', '').trim();
    final totalPercent = double.tryParse(totalPercentString) ?? 0.0;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false,
          ),
        ),
        title: Text(
          "Exam score",
          style: theme.textTheme.displayLarge,
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
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w400,
              ),
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
                      style: theme.textTheme.titleLarge?.copyWith(
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
                      count: score.correct,
                      color: theme.colorScheme.primary,
                    ),
                    SizedBox(height: 12.h),
                    ScoreMetricRow(
                      label: "Incorrect",
                      count: score.wrong,
                      color: theme.colorScheme.error,
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
                onPressed: () {
                  CustomSnackBar.error(context, "Under Developing");
                },
                child: const Text("Show results"),
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
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
                child: Text(
                  "Start again",
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.primary,
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
