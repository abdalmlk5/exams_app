import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:exams_app/features/authentication/presentation/auth/widgets/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_button.dart';
import '../cubit/forget_password_cubit.dart';
import '../cubit/forget_password_event.dart';
import '../cubit/forget_password_state.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  late final TextEditingController oldPasswordController;
  late final TextEditingController newPasswordController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listenWhen: (prev, curr) =>
          prev.forgetPasswordState.data != curr.forgetPasswordState.data ||
          prev.forgetPasswordState.errorMessage !=
              curr.forgetPasswordState.errorMessage,
      listener: (context, state) {
        if (state.forgetPasswordState.errorMessage != null) {
          CustomSnackBar.error(
            context,
            state.forgetPasswordState.errorMessage!,
          );
          return;
        }
        if (state.forgetPasswordState.data != null) {
          CustomSnackBar.success(context, AppStrings.passwordChangedSuccessfully);
          Navigator.of(context).popUntil((route) => route.isFirst);

        }
      },
      child: Scaffold(
        appBar: AuthAppBar(
          title: AppStrings.password,
          onBack: () => Navigator.pop(context),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 40.h),
                  Text(
                    AppStrings.resetPassword,
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    AppStrings.resetPasswordSubtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32.h),
                  AppTextField(
                    controller: passwordController,
                    fieldType: FieldType.newPassword,
                  ),
                  SizedBox(height: 24.h),
                  AppTextField(
                    controller: confirmPasswordController,
                    fieldType: FieldType.confirmPassword,
                    compareController: passwordController,
                  ),
                  SizedBox(height: 40.h),
                  BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                    builder: (context, state) {
                      return CustomButton(
                        text: AppStrings.continueText,
                        isLoading: state.forgetPasswordState.isLoading,
                        isEnabled: true,
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<ForgetPasswordCubit>().doEvent(
                              ForgetPasswordResetPasswordEvent(
                                passwordController.text,
                                confirmPasswordController.text,
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
