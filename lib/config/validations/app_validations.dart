import '../../core/utils/app_strings.dart';

abstract class AppValidations {
  // ── Generic ──
  static String? required(String? value, [String field = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$field ${AppStrings.fieldIsRequired}';
    }
    return null;
  }

  // ── Name ──
  static String? validateUserName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.userNameIsRequired;
    }
    if (value.length < 3) {
      return AppStrings.userNameTooShort;
    }
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return AppStrings.userNameInvalid;
    }
    return null;
  }

  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.firstNameIsRequired;
    }
    if (value.trim().length < 3) {
      return AppStrings.nameTooShort;
    }
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return AppStrings.nameNoNumbers;
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.lastNameIsRequired;
    }
    if (value.trim().length < 3) {
      return AppStrings.nameTooShort;
    }
    if (RegExp(r'[0-9]').hasMatch(value)) {
      return AppStrings.nameNoNumbers;
    }
    return null;
  }

  // ── Email ──
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.emailIsRequired;
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return AppStrings.enterValidEmail;
    }
    return null;
  }

  // ── Password ──
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordIsRequired;
    }

    if (value.length < 8) {
      return AppStrings.passwordTooShort;
    }

    if (!value.contains(RegExp(r'[a-z]'))) {
      return AppStrings.passwordNoLowercase;
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return AppStrings.passwordNoUppercase;
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return AppStrings.passwordNoNumber;
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordIsRequired;
    }
    if (value != password) {
      return AppStrings.passwordsNotMatched;
    }
    return null;
  }

  // ── Phone ──
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.phoneNumberIsRequired;
    }
    final cleaned = value.replaceAll(RegExp(r'[\s\-\(\)]'), '');
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(cleaned)) {
      return AppStrings.enterValidPhoneNumber;
    }
    return null;
  }
}
