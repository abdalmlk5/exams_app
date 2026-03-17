import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/features/authentication/presentation/auth/cubit/auth_cubit.dart';
import 'package:exams_app/features/authentication/presentation/auth/cubit/auth_even.dart';
import 'package:exams_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:exams_app/features/authentication/presentation/login/pages/login_page.dart';
import 'package:exams_app/features/authentication/presentation/register/cubit/register_cubit.dart';
import 'package:exams_app/features/authentication/presentation/register/pages/register_page.dart';
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

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return BlocConsumer<LoginCubit, LoginState>(
        // Only fire when errorMessage or data actually changes value
        listenWhen: (prev, curr) =>
            prev.loginState.errorMessage != curr.loginState.errorMessage ||
            prev.loginState.data != curr.loginState.data,
        listener: (context, state) {
          if (state.loginState.errorMessage != null) {
            CustomSnackBar.error(context, state.loginState.errorMessage!);
          }
          if (state.loginState.data != null) {
            context.read<AuthCubit>().doEvent(GetUserData());
          }
        },
        builder: (context, state) => LoginPage(togglePages: togglePages),
      );
    } else {
      return BlocConsumer<RegisterCubit, RegisterState>(
        listenWhen: (prev, curr) =>
            prev.registerState.errorMessage != curr.registerState.errorMessage ||
            prev.registerState.data != curr.registerState.data,
        listener: (context, state) {
          if (state.registerState.errorMessage != null) {
            CustomSnackBar.error(context, state.registerState.errorMessage!);
          }
          if (state.registerState.data != null) {
            context.read<AuthCubit>().doEvent(GetUserData());
          }
        },
        builder: (context, state) => RegisterPage(togglePages: togglePages),
      );
    }
  }
}
