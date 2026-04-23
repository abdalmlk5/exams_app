import 'package:exams_app/config/di/di.dart';
import 'package:exams_app/core/utils/app_colors.dart';
import 'package:exams_app/core/utils/app_strings.dart';
import 'package:exams_app/core/widgets/custom_button.dart';
import 'package:exams_app/core/widgets/custom_snack_bar.dart';
import 'package:exams_app/core/widgets/custom_text_field.dart';
import 'package:exams_app/features/profile_tab/domain/entities/profile_user_entity.dart';
import 'package:exams_app/features/profile_tab/presentation/cubit/profile_cubit.dart';
import 'package:exams_app/features/profile_tab/presentation/cubit/profile_events.dart';
import 'package:exams_app/features/profile_tab/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/profile_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final TextEditingController _usernameController;
  late final TextEditingController _firstNameController;
  late final TextEditingController _lastNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _phoneController;
  late final ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<ProfileCubit>();

    _usernameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController(
      text: AppStrings.profilePassword,
    );
    _phoneController = TextEditingController();

    if (_cubit.state.profileState.data == null) {
      _cubit.doEvent(const GetProfileDataEvent());
    } else {
      _populateControllers(_cubit.state.profileState.data!);
    }
  }

  void _populateControllers(ProfileUserEntity user) {
    _usernameController.text = user.username ?? '';
    _firstNameController.text = user.firstName ?? '';
    _lastNameController.text = user.lastName ?? '';
    _emailController.text = user.email ?? '';
    _phoneController.text = user.phoneNumber ?? '';
  }

  void _onFieldsChanged() {
    _cubit.doEvent(
      ProfileDataChangedEvent(
        ProfileUserEntity(
          username: _usernameController.text,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          phoneNumber: _phoneController.text,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listenWhen: (prev, curr) => prev.profileState != curr.profileState,
        listener: (context, state) {
          // Handle Initial Data Loading
          if (state.profileState.data != null &&
              _usernameController.text.isEmpty &&
              !state.isDataChanged) {
            _populateControllers(state.profileState.data!);
          }

          // Handle Update Success
          if (!state.profileState.isLoading &&
              state.profileState.errorMessage == null) {
            CustomSnackBar.success(
              context,
              AppStrings.profileUpdatedSuccessfully,
            );
          }

          // Handle Errors
          if (state.profileState.errorMessage != null) {
            CustomSnackBar.error(context, state.profileState.errorMessage!);
          }
        },
        builder: (context, state) {
          // 1. Loading State (Only show spinner if no data exists yet)
          if (state.profileState.isLoading && state.profileState.data == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // 2. Error State (Show error message if data failed and we have no cached data)
          if (state.profileState.errorMessage != null &&
              state.profileState.data == null) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.profileState.errorMessage ?? "User not found",
                  style: TextStyle(fontSize: 16.sp, color: AppColors.error),
                ),
              ),
            );
          }

          // 3. Success State (Show Form)
          return Scaffold(
            appBar: AppBar(title: const Text(AppStrings.profile)),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  SizedBox(height: 12.h),
                  const ProfileImage(),
                  SizedBox(height: 24.h),
                  AppTextField(
                    controller: _usernameController,
                    fieldType: FieldType.username,
                    onChanged: (_) => _onFieldsChanged(),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          controller: _firstNameController,
                          fieldType: FieldType.firstName,
                          onChanged: (_) => _onFieldsChanged(),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: AppTextField(
                          controller: _lastNameController,
                          fieldType: FieldType.lastName,
                          onChanged: (_) => _onFieldsChanged(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _emailController,
                    fieldType: FieldType.email,
                    onChanged: (_) => _onFieldsChanged(),
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _passwordController,
                    fieldType: FieldType.profilePassword,
                    readOnly: true,
                    suffix: TextButton(
                      onPressed: () {
                        // TODO: Navigate to reset password page
                      },
                      child: Text(
                        AppStrings.change,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  AppTextField(
                    controller: _phoneController,
                    fieldType: FieldType.phoneNumber,
                    onChanged: (_) => _onFieldsChanged(),
                  ),
                  SizedBox(height: 48.h),
                  CustomButton(
                    text: AppStrings.update,
                    isEnabled: state.isDataChanged,
                    isLoading: state.profileState.isLoading,
                    onPressed: () {
                      _cubit.doEvent(const UpdateProfileEvent());
                    },
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
