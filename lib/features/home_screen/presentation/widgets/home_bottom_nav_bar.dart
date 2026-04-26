import 'package:exams_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../cubit/home_cubit.dart';
import 'nav_item.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int selectedTab;
  const HomeBottomNavBar({super.key, required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.lightBlue,
      currentIndex: selectedTab,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.primary,
      selectedLabelStyle: AppTextStyles.blue14700.copyWith(
        fontSize: 12,
        decoration: TextDecoration.none,
      ),
      unselectedLabelStyle: AppTextStyles.gray12400.copyWith(
        color: AppColors.primary,
      ),
      onTap: (index) => context.read<HomeCubit>().changeTab(index),
      items: [
        navItem(
          icon: AppIcons.home,
          label: 'Home',
          index: 0,
          selectedIndex: selectedTab,
        ),
        navItem(
          icon: AppIcons.resultDraft,
          label: 'Result',
          index: 1,
          selectedIndex: selectedTab,
        ),
        navItem(
          icon: AppIcons.person,
          label: 'Profile',
          index: 2,
          selectedIndex: selectedTab,
        ),
      ],
    );
  }
}
