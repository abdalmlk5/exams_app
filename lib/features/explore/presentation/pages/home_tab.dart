import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/app_text_styles.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/features/explore/domain/entities/subject_entity.dart';
import 'package:exams_app/features/explore/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/explore_cubit.dart';
import '../cubit/explore_event.dart';
import '../cubit/explore_state.dart';
import '../widgets/subject_item.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<ExploreCubit>().doEvent(const GetAllSubjectsEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreCubit, ExploreState>(
      listenWhen: (previous, current) =>
          previous.exploreState.errorMessage !=
          current.exploreState.errorMessage,
      listener: (context, state) {
        if (state.exploreState.errorMessage != null) {
          CustomSnackBar.error(
            context,
            state.exploreState.errorMessage ?? AppStrings.someThingWentWrong,
          );
        }
      },
      builder: (context, state) {
        if (state.exploreState.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.exploreState.errorMessage != null) {
          return const SizedBox();
        } else {
          List<SubjectEntity> subjects = state.exploreState.data ?? [];
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.h),
                    Text(AppStrings.survey, style: AppTextStyles.black20500),
                    SizedBox(height: 16.h),
                    SearchTextField(controller: searchController),
                    SizedBox(height: 20.h),
                    Text(
                      AppStrings.browseBySubject,
                      style: AppTextStyles.black18500,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: subjects.isEmpty
                    ? Center(
                        child: Text(
                          searchController.text.isEmpty
                              ? AppStrings.noSubjectsFound
                              : AppStrings.noSearchResultsFound,
                          style: AppTextStyles.gray14400,
                        ),
                      )
                    : ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemCount: subjects.length,
                        itemBuilder: (context, index) =>
                            SubjectItem(subject: subjects[index]),
                      ),
              ),
            ],
          );
        }
      },
    );
  }
}
