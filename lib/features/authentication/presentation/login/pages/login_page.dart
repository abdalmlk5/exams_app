import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/features/authentication/presentation/auth_manager/widgets/widgets/auth_app_bar.dart';
import 'package:exams_app/features/authentication/presentation/login/widgets/login_view_body.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;

  const LoginPage({super.key, this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ThemeData theme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    theme = Theme.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AuthAppBar(title: AppStrings.login),
      body: SafeArea(child: LoginViewBody(togglePages: widget.togglePages)),
    );
  }
}
