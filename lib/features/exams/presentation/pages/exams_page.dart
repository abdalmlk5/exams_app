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
import '../cubit/exams_event.dart';
import '../cubit/exams_state.dart';

class ExamsPage extends StatelessWidget {
  final String? subject;
  const ExamsPage({super.key, this.subject});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => getIt<ExamsCubit>()
        ..doEvent(
          GetAllExamsEvent(
            //todo: send subject id here to get subjet exams
            /*subject: subject*/
          ),
        ),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.iconTheme.color,
            ),
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
              return const SizedBox();
            }
            if (state.examsState.data == null) {
              return Center(
                child: Text(
                  'No exams found',
                  style: theme.textTheme.bodyLarge,
                ),
              );
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
