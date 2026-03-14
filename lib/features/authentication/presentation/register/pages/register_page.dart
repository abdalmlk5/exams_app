import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/authentication/presentation/register/widgets/register_view_body.dart';
import 'package:exams_app/features/authentication/presentation/auth/widgets/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, this.togglePages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AuthAppBar(title: AppStrings.signup),
      body: SafeArea(child: RegisterViewBody(togglePages: togglePages)),
    );
  }
}
