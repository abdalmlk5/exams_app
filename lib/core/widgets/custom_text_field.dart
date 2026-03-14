import 'package:exams_app/config/validations/app_validations.dart';
import 'package:exams_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final FieldType fieldType;
  final void Function(String)? onChanged;
  final String? suffixText;
  final VoidCallback? onSuffixPressed;
  final TextEditingController? compareController;

  const AppTextField({
    super.key,
    required this.controller,
    required this.fieldType,
    this.onChanged,
    this.suffixText,
    this.onSuffixPressed,
    this.compareController,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.fieldType.textInputType,
      onChanged: widget.onChanged,
      validator: _validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: widget.fieldType.label,
        hintText: widget.fieldType.hint,
        labelStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.error)) {
            return const TextStyle(color: AppColors.error);
          }
          return const TextStyle(color: AppColors.black30);
        }),
        errorStyle: const TextStyle(color: AppColors.error),

        border: _border(AppColors.black30),
        enabledBorder: _border(AppColors.black30),
        focusedBorder: _border(Theme.of(context).colorScheme.primary, 2),
        errorBorder: _border(AppColors.error),
        focusedErrorBorder: _border(AppColors.error, 2),
      ),
    );
  }

  OutlineInputBorder _border(Color color, [double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(color: color, width: width),
      );

  String? _validate(String? value) {
    switch (widget.fieldType) {
      case FieldType.email:
        return AppValidations.validateEmail(value);
      case FieldType.password:
        return AppValidations.validatePassword(value);
      case FieldType.newPassword:
        return AppValidations.validatePassword(value);
      case FieldType.confirmPassword:
        return AppValidations.validateConfirmPassword(
          value,
          widget.compareController?.text,
        );
      case FieldType.username:
        return AppValidations.validateUserName(value);
      case FieldType.firstName:
        return AppValidations.validateFirstName(value);
      case FieldType.lastName:
        return AppValidations.validateLastName(value);
      case FieldType.phoneNumber:
        return AppValidations.validatePhoneNumber(value);
      case FieldType.none:
        return null;
    }
  }
}

enum FieldType {
  email('Email', 'Enter your email', TextInputType.emailAddress),
  password('Password', 'Enter your password', TextInputType.text),
  newPassword('New password', 'New password', TextInputType.text),
  confirmPassword('Confirm password', 'Confirm password', TextInputType.text),
  username('User name', 'Enter your user name', TextInputType.name),
  phoneNumber('Phone Number', 'Enter phone number', TextInputType.phone),
  firstName('First name', 'Enter first name', TextInputType.name),
  lastName('Last name', 'Enter last name', TextInputType.name),
  none('', '', TextInputType.text);

  final String label;
  final String hint;
  final TextInputType textInputType;
  const FieldType(this.label, this.hint, this.textInputType);
}
