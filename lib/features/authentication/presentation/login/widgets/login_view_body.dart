import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/widgets/custom_button.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:exams_app/features/authentication/presentation/auth/widgets/widgets/auth_footer.dart';
import 'package:exams_app/features/authentication/presentation/login/cubit/login_cubit.dart';
import 'package:exams_app/features/authentication/presentation/login/cubit/login_event.dart';
import 'package:exams_app/features/authentication/presentation/login/widgets/remember_me_and_forget_password.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginViewBody extends StatefulWidget {
  final void Function()? togglePages;

  const LoginViewBody({super.key, this.togglePages});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    final String email = _emailController.text;
    final String password = _passwordController.text;
    final bool rememberMe = context.read<LoginCubit>().state.rememberMe;

    context.read<LoginCubit>().doEvent(
      Login(email: email, password: password, rememberMe: rememberMe),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          previous.loginState != current.loginState,
      listener: (context, state) {
        if (state.loginState.errorMessage != null) {
          CustomSnackBar.error(context, state.loginState.errorMessage!);
        }
        if (state.loginState.data != null) {
          CustomSnackBar.success(context, 'Login Success');
        }
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppTextField(
                controller: _emailController,
                fieldType: FieldType.email,
                onChanged: (value) {
                  context.read<LoginCubit>().validateForm(
                        value,
                        _passwordController.text,
                      );
                },
              ),
              SizedBox(height: 24.h),
              AppTextField(
                controller: _passwordController,
                fieldType: FieldType.password,
                onChanged: (value) {
                  context.read<LoginCubit>().validateForm(
                        _emailController.text,
                        value,
                      );
                },
              ),
              const SizedBox(height: 12),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.rememberMe != current.rememberMe,
                builder: (context, state) {
                  return RememberMeAndForgetPassword(
                    value: state.rememberMe,
                    onChanged: (value) {
                      context
                          .read<LoginCubit>()
                          .toggleRememberMe(value ?? false);
                    },
                  );
                },
              ),
              SizedBox(height: 48.h),
              BlocBuilder<LoginCubit, LoginState>(
                buildWhen: (previous, current) =>
                    previous.isButtonEnabled != current.isButtonEnabled ||
                    previous.loginState != current.loginState,
                builder: (context, state) {
                  return CustomButton(
                    text: AppStrings.login,
                    isEnabled: state.isButtonEnabled,
                    isLoading: state.loginState.isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                  );
                },
              ),
              SizedBox(height: 24.h),
              AuthFooter(
                text: AppStrings.dontHaveAccount,
                linkText: AppStrings.signup,
                onTap: widget.togglePages ?? () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
