import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';
import 'package:exams_app/features/exams/presentation/widgets/exam_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/di/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/exams_cubit.dart';
import '../cubit/exams_event.dart';
import '../cubit/exams_state.dart';

class ExamsPage extends StatelessWidget {
  final String? subject;
  const ExamsPage({super.key, this.subject});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ExamsCubit>()..doEvent(GetAllExamsEvent(subject: subject)),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          ),
          title: const Text(AppStrings.exams),
        ),
        body: BlocConsumer<ExamsCubit, ExamsState>(
          listenWhen: (prev, curr) =>
              prev.examsState.errorMessage != curr.examsState.errorMessage,
          listener: (context, state) {
            if (state.examsState.errorMessage != null) {
              CustomSnackBar.error(
                context,
                state.examsState.errorMessage ?? AppStrings.someThingWentWrong,
              );
            }
          },
          builder: (context, state) {
            if (state.examsState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            List<ExamEntity> exams = state.examsState.data ?? [];
            if (exams.isEmpty && state.examsState.errorMessage == null) {
              return const Center(child: Text(AppStrings.noExamsFound));
            }
            return ListView.separated(
              padding: EdgeInsets.all(16.w),
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: exams.length,
              itemBuilder: (context, index) => ExamItem(exam: exams[index]),
            );
          },
        ),
      ),
    );
  }
}
