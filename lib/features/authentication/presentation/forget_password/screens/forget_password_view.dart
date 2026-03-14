import 'package:exams_app/config/base_state/base_state.dart';
import 'package:exams_app/core/utils/app_routes.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/app_styles.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import '../view_models/forget_password_cubit.dart';
import '../view_models/forget_password_intent.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return BlocListener<ForgetPasswordCubit, BaseState<String?>>(
      listenWhen: (previous, current) =>
          previous.data != current.data ||
          previous.errorMessage != current.errorMessage,
      listener: (context, state) {
        if (state.data == "OTP_SENT") {
          Navigator.pushNamed(
            context,
            AppRoutes.emailVerification,
            arguments: context.read<ForgetPasswordCubit>(),
          );
        } else if (state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: Colors.red,
            ),
          );
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
                Text(AppStrings.forgetPassword, style: AppStyles.black18500),
                SizedBox(height: 16.h),
                Text(
                  AppStrings.forgetPasswordSubtitle,
                  style: AppStyles.gray14400,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: emailController,
                  fieldType: FieldType.email,
                ),
                const Spacer(),
                BlocBuilder<ForgetPasswordCubit, BaseState<String?>>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return CustomButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgetPasswordCubit>().handleIntent(
                            ForgetPasswordSendEmailIntent(emailController.text),
                          );
                        }
                      },
                      text: AppStrings.continueText,
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
