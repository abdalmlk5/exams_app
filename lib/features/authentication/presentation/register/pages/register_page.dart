import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/authentication/presentation/register/widgets/register_view_body.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/widgets/widgets/auth_app_bar.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, this.togglePages});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AuthAppBar(title: AppStrings.signup),
      body: SafeArea(child: RegisterViewBody(togglePages: togglePages)),
    );
  }
}
