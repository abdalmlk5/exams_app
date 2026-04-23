import 'package:exams_app/core/utils/app_routes.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/utils/app_text_styles.dart';
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

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  late final TextEditingController emailController;
  late final GlobalKey<FormState> formKey;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final emailController = TextEditingController();
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
          Navigator.pushNamed(context, AppRoutes.emailVerification);
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
                Text(AppStrings.forgetPassword, style: theme.textTheme.titleLarge),
                SizedBox(height: 16.h),
                Text(
                  AppStrings.forgetPasswordSubtitle,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                AppTextField(
                  controller: emailController,
                  fieldType: FieldType.email,
                ),
                const Spacer(),
                BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
                  builder: (context, state) {
                    return CustomButton(
                      isEnabled: true,
                      isLoading: state.forgetPasswordState.isLoading,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<ForgetPasswordCubit>().doEvent(
                            ForgetPasswordSendEmailEvent(emailController.text),
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
