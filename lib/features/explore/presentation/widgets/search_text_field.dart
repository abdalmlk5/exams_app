import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/explore/presentation/cubit/explore_cubit.dart';
import 'package:exams_app/features/explore/presentation/cubit/explore_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  const SearchTextField({required this.controller, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppStyles.black16400,
      onChanged: (value) => context.read<ExploreCubit>().doEvent(
        GetFilteredSubjectsListEvent(value),
      ),
      decoration: InputDecoration(
        hintText: AppStrings.search,
        hintStyle: AppStyles.placeholder14400,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 12, right: 8),
          child: SvgPicture.asset(
            'assets/icons/search.svg',
            colorFilter: const ColorFilter.mode(
              AppColors.black30,
              BlendMode.srcIn,
            ),
            width: 16,
            height: 16,
          ),
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 40,
          minHeight: 40,
        ),
        filled: true,
        fillColor: AppColors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.gray, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.gray, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.gray,
            width: 2,
          ),
        ),
      ),
    );
  }
}
