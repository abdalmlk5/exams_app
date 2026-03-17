import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/app_text_styles.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:exams_app/features/authentication/presentation/auth/widgets/widgets/auth_app_bar.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import '../cubit/forget_password_event.dart';
import '../cubit/forget_password_state.dart';
import '../cubit/forget_password_cubit.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          CustomSnackBar.error(context, state.forgetPasswordState.errorMessage!);
          return;
        }
        if (state.forgetPasswordState.data != null) {
          CustomSnackBar.success(context, "Password reset successfully");
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
                  Text(AppStrings.resetPassword, style: AppTextStyles.black18500),
                  SizedBox(height: 16.h),
                  Text(
                    AppStrings.resetPasswordSubtitle,
                    style: AppTextStyles.gray14400,
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
