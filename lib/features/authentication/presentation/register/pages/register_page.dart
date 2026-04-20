import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/authentication/presentation/register/widgets/register_view_body.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/widgets/widgets/auth_app_bar.dart';

import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;

  const RegisterPage({super.key, this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AuthAppBar(title: AppStrings.signup),
      body: SafeArea(child: RegisterViewBody(togglePages: widget.togglePages)),
    );
  }
}
