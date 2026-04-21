import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:exams_app/config/di/di.dart';
import 'package:exams_app/core/theme/app_theme.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/cubit/auth_manager_cubit.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/cubit/auth_manager_event.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/pages/auth_manager_page.dart';
import 'package:exams_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:exams_app/features/authentication/presentation/register/cubit/register_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => getIt<LoginCubit>()),
              BlocProvider(create: (_) => getIt<RegisterCubit>()),
              BlocProvider(create: (_) => getIt<AuthManagerCubit>()..doEvent(CheckAuth())),
            ],
            child: const AuthWrapper(),
          ),
        );
      },
    );
  }
}

/// Widget to handle authentication state and navigation
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthManagerCubit, AuthManagerState>(
      listener: (context, state) {
        final error = state.authState.errorMessage;
        if (error != null && error.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error)));
        }
      },
      child: BlocBuilder<AuthManagerCubit, AuthManagerState>(
        builder: (context, state) {
          if (state.authState.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.authState.data != null) {
            // nav to home page

          }
          return const AuthenticationManagerPage();
        },
      ),
    );
  }
}
