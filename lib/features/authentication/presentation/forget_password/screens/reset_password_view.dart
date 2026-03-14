import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:exams_app/core/widgets/custom_elevated_button.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../view_models/forget_password_cubit.dart';
import '../view_models/forget_password_intent.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocListener<ForgetPasswordCubit, BaseState<String?>>(
      listenWhen: (previous, current) => previous.data != current.data,
      listener: (context, state) {
        if (state.data == "PASSWORD_RESET") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password reset successfully")),
          );
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.password, style: AppStyles.black20500),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Text(AppStrings.resetPassword, style: AppStyles.black18500),
                SizedBox(height: 16.h),
                Text(
                  AppStrings.resetPasswordSubtitle,
                  style: AppStyles.gray14400,
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
                const Spacer(),
                BlocBuilder<ForgetPasswordCubit, BaseState<String?>>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButton(
                      text: AppStrings.continueText,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgetPasswordCubit>().handleIntent(
                            ForgetPasswordResetPasswordIntent(
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
    );
  }
}
