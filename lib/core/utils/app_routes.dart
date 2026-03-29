import 'package:flutter/material.dart';

import '../../features/authentication/presentation/forget_password/pages/email_verification_page.dart';
import '../../features/authentication/presentation/forget_password/pages/forget_password_page.dart';
import '../../features/authentication/presentation/forget_password/pages/reset_password_page.dart';
import '../../features/exams/data/models/exam_model.dart';
import '../../features/exams/presentation/pages/exam_details_page.dart';
import '../../features/exams/presentation/pages/exams_page.dart';

class AppRoutes {
  static const String forgetPassword = '/forgetPassword';
  static const String emailVerification = '/emailVerification';
  static const String resetPassword = '/resetPassword';

  static const String examsPage = '/examsPage';
  static const String examDetailsPage = '/examDetailsPage';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case forgetPassword:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordPage());

      case emailVerification:
        return MaterialPageRoute(builder: (_) => const EmailVerificationPage());

      case resetPassword:
        return MaterialPageRoute(builder: (_) => const ResetPasswordPage());

      case examsPage:
        return MaterialPageRoute(builder: (_) => ExamsPage());
      case examDetailsPage:
        final exam = settings.arguments as ExamModel;
        return MaterialPageRoute(builder: (_) => ExamDetailsPage(exam: exam));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
