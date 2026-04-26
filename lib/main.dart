import 'package:exams_app/config/di/di.dart';
import 'package:exams_app/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/utils/app_theme.dart';
import 'features/authentication/presentation/auth/cubit/auth_cubit.dart';

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
        return BlocProvider(
          create: (_) => getIt<AuthCubit>()..checkAuth(),
          child: BlocListener<AuthCubit, AuthState>(
            listenWhen: (previous, current) =>
                previous.authState.data != current.authState.data ||
                previous.authState.isLoading != current.authState.isLoading,
            listener: (context, state) {
              if (!state.authState.isLoading) {
                if (state.authState.data != null) {
                  AppRoutes.navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    AppRoutes.home,
                    (route) => false,
                  );
                } else {
                  AppRoutes.navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    AppRoutes.auth,
                    (route) => false,
                  );
                }
              }
            },
            child: MaterialApp(
              navigatorKey: AppRoutes.navigatorKey,
              theme: AppTheme.mainTheme,
              debugShowCheckedModeBanner: false,
              title: 'Exams App',
              onGenerateRoute: AppRoutes.onGenerateRoute,
              home: const AuthWrapper(),
            ),
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
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
