import 'package:exams_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/presentation/forget_password/pages/email_verification_page.dart';
import '../../features/authentication/presentation/forget_password/pages/forget_password_page.dart';
import '../../features/authentication/presentation/forget_password/pages/reset_password_page.dart';
import '../../features/authentication/presentation/forget_password/cubit/forget_password_cubit.dart';

class AppRoutes {
  static const String forgetPassword = '/forgetPassword';
  static const String emailVerification = '/emailVerification';
  static const String resetPassword = '/resetPassword';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {

      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordPage(),
          ),
        );

      case emailVerification:
        return _withCubit(
          settings,
          const EmailVerificationPage(),
        );

      case resetPassword:
        return _withCubit(
          settings,
          const ResetPasswordPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static MaterialPageRoute _withCubit(
    RouteSettings settings,
    Widget page,
  ) {
    final cubit = settings.arguments as ForgetPasswordCubit?;

    if (cubit == null) {
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Cubit not provided'),
          ),
        ),
      );
    }

    return MaterialPageRoute(
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: page,
      ),
    );
  }
}