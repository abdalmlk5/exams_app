import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/app_text_styles.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:exams_app/features/authentication/presentation/auth/widgets/widgets/auth_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/custom_elevated_button.dart';
import '../cubit/forget_password_cubit.dart';
import '../cubit/forget_password_event.dart';
import '../cubit/forget_password_state.dart';
import '../cubit/forget_password_stateord_event.dart';

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
          CustomSnackBar.show(context, AppStrings.passwordChangedSuccessfully);
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.login,
            (route) => false,
          );
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Text(AppStrings.resetPassword, style: AppTextStyles.black18500),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: oldPasswordController,
                  fieldType: FieldType.password,
                  hint: AppStrings.oldPassword,
                ),
                SizedBox(height: 16.h),
                AppTextField(
                  controller: newPasswordController,
                  fieldType: FieldType.password,
                  hint: AppStrings.newPassword,
                ),
                const Spacer(),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    return CustomButton(
                      isEnabled: true,
                      isLoading: state.forgetPasswordState.isLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // TODO: Trigger Reset Password Event
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
