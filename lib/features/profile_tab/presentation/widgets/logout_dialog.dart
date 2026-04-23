import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../authentication/presentation/auth/cubit/auth_cubit.dart';
import '../../../authentication/presentation/auth/cubit/auth_event.dart';

void showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text(AppStrings.logout),
      content: const Text(AppStrings.logoutQuestion),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(AppStrings.cancel),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<AuthCubit>().doEvent(Logout());
          },
          child: const Text(
            AppStrings.logout,
            style: TextStyle(color: AppColors.error),
          ),
        ),
      ],
    ),
  );
}
