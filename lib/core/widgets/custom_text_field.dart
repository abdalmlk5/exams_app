import 'package:exams_app/config/validations/app_validations.dart';
import 'package:exams_app/core/utils/app_strings.dart';
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
      decoration: InputDecoration(
        labelText: widget.fieldType.label,
        hintText: widget.fieldType.hint,
      ),
    );
  }

  String? _validate(String? value) {
    switch (widget.fieldType) {
      case FieldType.email:
        return AppValidations.validateEmail(value);
      case FieldType.password:
      case FieldType.currentPassword:
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
  email(AppStrings.email, AppStrings.enterYourEmail, TextInputType.emailAddress),
  password(AppStrings.password, AppStrings.enterYourPassword, TextInputType.text),
  currentPassword(AppStrings.password, AppStrings.enterYourPassword, TextInputType.text),
  newPassword(AppStrings.newPassword, AppStrings.newPassword, TextInputType.text),
  confirmPassword(AppStrings.confirmPassword, AppStrings.confirmPassword, TextInputType.text),
  username(AppStrings.userName, AppStrings.enterYourUserName, TextInputType.name),
  phoneNumber(AppStrings.phoneNumber, AppStrings.enterPhoneNumber, TextInputType.phone),
  firstName(AppStrings.firstName, AppStrings.enterFirstName, TextInputType.name),
  lastName(AppStrings.lastName, AppStrings.enterLastName, TextInputType.name),
  none('', '', TextInputType.text);

  final String label;
  final String hint;
  final TextInputType textInputType;
  const FieldType(this.label, this.hint, this.textInputType);
}
