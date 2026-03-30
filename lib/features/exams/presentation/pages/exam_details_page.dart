import 'package:exams_app/features/questions/presentation/pages/question_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/widgets/custom_elevated_button.dart';
import '../../data/models/exam_model.dart';
import '../widgets/instruction_item.dart';

class ExamDetailsPage extends StatelessWidget {
  final ExamModel exam;

  const ExamDetailsPage({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                          Text(exam.title ?? "", style: AppStyles.black18500),
                          Text(
                            "${exam.duration} ${AppStrings.minutes}",
                            style: AppStyles.primary12500,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Text(
                            AppStrings.highLevel,
                            style: AppStyles.black16400,
                          ),
                          Container(
                            height: 15.h,
                            width: 1.w,
                            color: AppColors.blue10,
                            margin: EdgeInsets.symmetric(horizontal: 8.w),
                          ),
                          Text(
                            "${exam.numberOfQuestions} ${AppStrings.question}",
                            style: AppStyles.gray14400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            const Divider(color: AppColors.blue10),
            SizedBox(height: 16.h),
            Text(AppStrings.instructions, style: AppStyles.black18500),
            SizedBox(height: 16.h),
            Expanded(
              child: ListView(
                children: [
                  const InstructionItem(
                    text: "Lorem ipsum dolor sit amet consectetur.",
                  ),
                  const InstructionItem(
                    text: "Lorem ipsum dolor sit amet consectetur.",
                  ),
                  const InstructionItem(
                    text: "Lorem ipsum dolor sit amet consectetur.",
                  ),
                  const InstructionItem(
                    text: "Lorem ipsum dolor sit amet consectetur.",
                  ),
                ],
              ),
            ),
            CustomButton(
              text: AppStrings.start,
              onPressed: () {
                Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    QuestionPage(examId: exam.id!),
              ),
            );
              },
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
