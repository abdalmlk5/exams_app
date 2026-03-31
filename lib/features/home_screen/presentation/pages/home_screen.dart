import 'package:exams_app/features/home_screen/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/home_body.dart';
import '../widgets/home_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: AppBar(
          ),
          body: HomeBody(selectedTab: state.selectedTab),
          bottomNavigationBar: HomeBottomNavBar(selectedTab: state.selectedTab),
        );
      },
    );
  }
}
