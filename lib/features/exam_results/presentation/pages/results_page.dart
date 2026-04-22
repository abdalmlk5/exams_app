import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/exam_results/domain/entities/exam_result_entity.dart';
import 'package:exams_app/features/exam_results/presentation/cubit/exam_results_cubit.dart';
import 'package:exams_app/features/exam_results/presentation/cubit/exam_results_event.dart';
import 'package:exams_app/features/exam_results/presentation/cubit/exam_results_state.dart';
import 'package:exams_app/features/exam_results/presentation/widgets/result_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Initial fetch
    context.read<ExamResultsCubit>().doIntent(GetExamResultsEvent());

    return BlocBuilder<ExamResultsCubit, ExamResultsState>(
      builder: (context, state) {
        if (state.isLoading && state.allResults.isEmpty) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null && state.allResults.isEmpty) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 60.sp, color: theme.colorScheme.error),
                  SizedBox(height: 16.h),
                  Text(state.errorMessage!),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () => context.read<ExamResultsCubit>().doIntent(GetExamResultsEvent()),
                    child: const Text(AppStrings.retryLabel),
                  ),
                ],
              ),
            ),
          );
        }

        final results = state.allResults;

        return Scaffold(
          body: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.results,
                        style: theme.textTheme.displayLarge?.copyWith(
                          fontSize: 20.sp,
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
                Expanded(
                  child: results.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.assignment_turned_in_outlined, 
                                   size: 80.sp, color: theme.disabledColor.withOpacity(0.3)),
                              SizedBox(height: 16.h),
                              Text(
                                AppStrings.noResultsYet,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.disabledColor,
                                ),
                              ),
                            ],
                          ),
                        )
                      : _buildGroupedList(results),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGroupedList(List<ExamResultEntity> results) {
    // Group by subject
    final Map<String, List<ExamResultEntity>> groupedResults = {};
    for (var result in results) {
      groupedResults.putIfAbsent(result.subject, () => []).add(result);
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: groupedResults.length,
      itemBuilder: (context, index) {
        final subject = groupedResults.keys.elementAt(index);
        final subjectResults = groupedResults[subject]!;
        final theme = Theme.of(context);
        
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
              child: Text(
                subject,
                style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.textTheme.titleLarge?.color,
                      fontSize: 18.sp,
                    ),
              ),
            ),
            ...subjectResults.map((r) => ResultItemWidget(result: r)).toList(),
            SizedBox(height: 8.h),
          ],
        );
      },
    );
  }
}
