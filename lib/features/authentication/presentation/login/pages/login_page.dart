import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/widgets/widgets/auth_app_bar.dart';
import 'package:exams_app/features/authentication/presentation/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, this.togglePages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AuthAppBar(title: AppStrings.login),
      body: SafeArea(child: LoginViewBody(togglePages: togglePages)),
    );
  }
}
