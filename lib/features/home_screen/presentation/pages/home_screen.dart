import 'package:exams_app/features/explore/presentation/pages/home_tab.dart';
import 'package:exams_app/features/home_screen/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_bottom_nav_bar.dart';
import '../widgets/profile_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: state.selectedTab,
              children: [
                HomeTab(),
                const Scaffold(body: Center(child: Text("Result"))),
                const ProfileTab(),
              ],
            ),
          ),
          bottomNavigationBar: HomeBottomNavBar(selectedTab: state.selectedTab),
        );
      },
    );
  }
}
