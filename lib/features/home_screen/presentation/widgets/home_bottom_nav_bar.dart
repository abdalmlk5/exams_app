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
    final theme = Theme.of(context);
    return BottomNavigationBar(
      backgroundColor: AppColors.lightBlue,
      currentIndex: selectedTab,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: theme.colorScheme.primary,
      unselectedItemColor: theme.colorScheme.primary,
      selectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
      unselectedLabelStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w500,
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
