import 'package:exams_app/config/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/authentication/presentation/forget_password/pages/email_verification_page.dart';
import '../../features/authentication/presentation/forget_password/pages/forget_password_page.dart';
import '../../features/authentication/presentation/forget_password/pages/reset_password_page.dart';
import '../../features/authentication/presentation/forget_password/view_models/forget_password_view_model.dart';

class AppRoutes {
  static const String forgetPassword = '/forgetPassword';
  static const String emailVerification = '/emailVerification';
  static const String resetPassword = '/resetPassword';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case forgetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<ForgetPasswordViewModel>(),
            child: const ForgetPasswordPage(),
          ),
        );
      case emailVerification:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as ForgetPasswordViewModel,
            child: const EmailVerificationPage(),
          ),
        );
      case resetPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: settings.arguments as ForgetPasswordViewModel,
            child: const ResetPasswordPage(),
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
