import 'package:exams_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:exams_app/features/authentication/presentation/login/pages/login_page.dart';
import 'package:exams_app/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:exams_app/features/authentication/presentation/register/pages/register_page.dart';
import 'package:exams_app/main_page_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  void _navigateToHome() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const MainPageTest()));
  }

  void _showError(String message) {
    if (message.isNotEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          // Show error if exists
          _showError(state.loginState.errorMessage ?? '');

          // Navigate on success
          if (state.loginState.data != null) {
            _navigateToHome();
          }
        },
        builder: (context, state) => LoginPage(togglePages: togglePages),
      );
    } else {
      return BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          // Show error if exists
          _showError(state.registerState.errorMessage ?? '');

          // Navigate on success
          if (state.registerState.data != null) {
            _navigateToHome();
          }
        },
        builder: (context, state) => RegisterPage(togglePages: togglePages),
      );
    }
  }
}
