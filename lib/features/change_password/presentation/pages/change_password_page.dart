import 'package:exams_app/config/di/di.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/widgets/custom_button.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:exams_app/features/change_password/presentation/cubit/change_password_cubit.dart';
import 'package:exams_app/features/change_password/presentation/cubit/change_password_events.dart';
import 'package:exams_app/features/change_password/presentation/cubit/change_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _oldPasswordController = TextEditingController();
  final _nowPasswordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _nowPasswordController.dispose();
    _rePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ChangePasswordCubit>(),
      child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
        listener: (context, state) {
          if (state.changePasswordResult.data != null) {
            CustomSnackBar.success(
              context,
              AppStrings.passwordChangedSuccessfully,
            );
            Navigator.pop(context);
          }
          if (state.changePasswordResult.errorMessage != null) {
            CustomSnackBar.error(
              context,
              state.changePasswordResult.errorMessage!,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text(AppStrings.resetPassword)),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 16.h),

                    AppTextField(
                      controller: _oldPasswordController,
                      fieldType: FieldType.password,
                    ),
                    SizedBox(height: 16.h),

                    AppTextField(
                      controller: _nowPasswordController,
                      fieldType: FieldType.newPassword,
                      compareController: _oldPasswordController,
                    ),
                    SizedBox(height: 16.h),

                    AppTextField(
                      controller: _rePasswordController,
                      fieldType: FieldType.confirmPassword,
                      compareController: _nowPasswordController,
                    ),
                    SizedBox(height: 48.h),
                    CustomButton(
                      text: AppStrings.update,
                      isLoading: state.changePasswordResult.isLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ChangePasswordCubit>().doEvent(
                            ChangePasswordSubmittedEvent(
                              oldPassword: _oldPasswordController.text,
                              password: _nowPasswordController.text,
                              rePassword: _rePasswordController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
