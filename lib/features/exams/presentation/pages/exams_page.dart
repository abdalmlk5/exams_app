import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/features/exams/presentation/widgets/exam_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/di/di.dart';
import '../../../../core/utils/app_colors.dart';
import '../../data/models/exam_model.dart';
import '../cubit/exams_cubit.dart';
import '../cubit/exams_state.dart';

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExamsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.black),
          ),
        ),
        body: BlocBuilder<ExamsCubit, ExamsState>(
          builder: (context, state) {
            if (state.examsState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.examsState.errorMessage != null) {
              CustomSnackBar.error(
                context,
                state.examsState.errorMessage ?? AppStrings.someThingWentWrong,
              );
              return SizedBox();
            } else {
              List<ExamModel> exams = state.examsState.data ?? [];
              return ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemCount: exams.length,
                itemBuilder: (context, index) => ExamItem(exam: exams[index]),
              );
            }
          },
        ),
      ),
    );
  }
}
