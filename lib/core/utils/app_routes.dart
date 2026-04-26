import 'package:flutter/material.dart';

import '../../features/authentication/presentation/forget_password/pages/email_verification_page.dart';
import '../../features/authentication/presentation/forget_password/pages/forget_password_page.dart';
import '../../features/authentication/presentation/forget_password/pages/reset_password_page.dart';
import '../../features/authentication/presentation/login/pages/login_page.dart';
import '../../features/authentication/presentation/register/pages/register_page.dart';
import '../../features/exams/domain/entities/exam_entity.dart';
import '../../features/exams/presentation/pages/exam_details_page.dart';
import '../../features/exams/presentation/pages/exams_page.dart';
import '../../features/home_screen/presentation/pages/home_screen.dart';

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String forgetPassword = '/forgetPassword';
  static const String emailVerification = '/emailVerification';
  static const String resetPassword = '/resetPassword';
  static const String home = '/home';
  static const String examsPage = '/examsPage';
  static const String examDetailsPage = '/examDetailsPage';
}

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case Routes.login:
          return MaterialPageRoute(builder: (_) => const LoginPage());

        case Routes.register:
          return MaterialPageRoute(builder: (_) => const RegisterPage());

        case Routes.forgetPassword:
          return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());

        case Routes.emailVerification:
          return MaterialPageRoute(
            builder: (_) => const EmailVerificationPage(),
          );

        case Routes.resetPassword:
          return MaterialPageRoute(builder: (_) => const ResetPasswordPage());

        case Routes.home:
          return MaterialPageRoute(builder: (_) => const HomeScreen());

        case Routes.examsPage:
          final subject = settings.arguments as String?;
          return MaterialPageRoute(builder: (_) => ExamsPage(subject: subject));

        case Routes.examDetailsPage:
          final exam = settings.arguments as ExamEntity;
          return MaterialPageRoute(builder: (_) => ExamDetailsPage(exam: exam));

        default:
          return _errorRoute(settings);
      }
    } catch (e) {
      return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text("Navigation Error")),
        body: Center(
          child: Text(
            'No route defined or wrong arguments for ${settings.name}',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
