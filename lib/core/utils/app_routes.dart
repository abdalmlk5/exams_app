import 'package:exams_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/presentation/forget_password/screens/email_verification_view.dart';
import '../../features/authentication/presentation/forget_password/screens/forget_password_view.dart';
import '../../features/authentication/presentation/forget_password/screens/reset_password_view.dart';
import '../../features/authentication/presentation/forget_password/view_models/forget_password_cubit.dart';

class AppRoutes {
  static const String forgetPassword = '/forgetPassword';
  static const String emailVerification = '/emailVerification';
  static const String resetPassword = '/resetPassword';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgetPasswordCubit>(),
            child: const ForgetPasswordView(),
          ),
        );
      case emailVerification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as ForgetPasswordCubit,
            child: const EmailVerificationView(),
          ),
        );
      case resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as ForgetPasswordCubit,
            child: const ResetPasswordView(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
