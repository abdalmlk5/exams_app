import 'package:exams_app/config/di/di.dart';
import 'package:exams_app/features/forget_password/presentation/screens/email_verification_view.dart';
import 'package:exams_app/features/forget_password/presentation/screens/forget_password_view.dart';
import 'package:exams_app/features/forget_password/presentation/screens/reset_password_view.dart';
import 'package:exams_app/features/forget_password/presentation/view_models/forget_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AppRoutes {
  static const String forgetPassword = '/forgetPassword';
  static const String emailVerification = '/emailVerification';
  static const String resetPassword = '/resetPassword';
}

abstract class AppRouter {
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
        final cubit = settings.arguments is ForgetPasswordCubit
            ? settings.arguments as ForgetPasswordCubit
            : getIt<ForgetPasswordCubit>();
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
            child: const EmailVerificationView(),
          ),
        );
      case resetPassword:
        final cubit = settings.arguments is ForgetPasswordCubit
            ? settings.arguments as ForgetPasswordCubit
            : getIt<ForgetPasswordCubit>();
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: cubit,
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
