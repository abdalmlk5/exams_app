import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/di/di.dart';
import '../../data/models/subject_model.dart';
import '../cubit/explore_cubit.dart';
import '../cubit/explore_state.dart';
import '../widgets/subject_item.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ExploreCubit>(),
      child: BlocBuilder<ExploreCubit, ExploreState>(
        builder: (context, state) {
          if (state.exploreState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.exploreState.errorMessage != null) {
            CustomSnackBar.error(
              context,
              state.exploreState.errorMessage ?? AppStrings.someThingWentWrong,
            );
            return SizedBox();
          } else {
            List<SubjectModel> subjects = state.exploreState.data ?? [];
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemCount: subjects.length,
              itemBuilder: (context, index) =>
                  SubjectItem(subject: subjects[index]),
            );
          }
        },
      ),
    );
  }
}
