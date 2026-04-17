import 'package:exams_app/config/di/di.dart';
import 'package:exams_app/core/utils/app_routes.dart';
import 'package:exams_app/core/utils/app_theme.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/features/home_screen/presentation/pages/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/authentication/presentation/auth/cubit/auth_cubit.dart';
import 'features/authentication/presentation/auth/pages/auth_page.dart';
import 'features/authentication/presentation/forget_password/cubit/forget_password_cubit.dart';
import 'features/authentication/presentation/login/cubit/login_cubit.dart';
import 'features/authentication/presentation/register/cubit/register_cubit.dart';
import 'features/explore/presentation/cubit/explore_cubit.dart';
import 'features/home_screen/presentation/cubit/home_cubit.dart';

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
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => getIt<LoginCubit>()),
            BlocProvider(create: (_) => getIt<RegisterCubit>()),
            BlocProvider(create: (_) => getIt<AuthCubit>()..checkAuth()),
            BlocProvider(create: (_) => getIt<ForgetPasswordCubit>()),
            BlocProvider(create: (_) => getIt<HomeCubit>()),
            BlocProvider(create: (_) => getIt<ExploreCubit>()),
          ],
          child: MaterialApp(
            theme: AppTheme.mainTheme,
            debugShowCheckedModeBanner: false,
            title: 'Exams App',
            onGenerateRoute: AppRoutes.onGenerateRoute,
            home: const AuthWrapper(),
          ),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          previous.authState.errorMessage != current.authState.errorMessage,
      listener: (context, state) {
        final error = state.authState.errorMessage;
        if (error != null && error.isNotEmpty) {
          CustomSnackBar.error(context, error);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state.authState.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (state.authState.data != null) {
            return const HomeScreen();
          }
          return const AuthPage();
        },
      ),
    );
  }
}
