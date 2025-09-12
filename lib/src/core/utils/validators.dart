import '../constants/app_constants.dart';

class Validators {
  Validators._();

  static String? required(
    String? value,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage('fieldRequired');
    }
    return null;
  }

  static String? email(String? value, String? Function(String) errorMessage) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage('emailRequired');
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return errorMessage('emailInvalid');
    }
    return null;
  }

  static String? password(
    String? value,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return errorMessage('passwordRequired');
    }
    if (value.length < AppConstants.minPasswordLength) {
      return errorMessage('passwordMinLength');
    }
    return null;
  }

  static String? securePassword(
    String? value,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return errorMessage('newPasswordRequired');
    }
    if (!isPasswordStrong(value)) {
      return errorMessage('passwordTooWeak');
    }
    return null;
  }

  static String? profileName(
    String? value,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.trim().isEmpty) {
      return errorMessage('nameRequired');
    }
    if (value.trim().length < AppConstants.minNameLength) {
      return errorMessage('nameMinLength');
    }
    return null;
  }

  static String? currentPassword(
    String? value,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return errorMessage('currentPasswordRequired');
    }
    return null;
  }

  static String? confirmSecurePassword(
    String? value,
    String originalPassword,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return errorMessage('confirmPasswordRequired');
    }
    if (value != originalPassword) {
      return errorMessage('passwordsDoNotMatch');
    }
    return null;
  }

  static String? confirmPassword(
    String? value,
    String originalPassword,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return errorMessage('confirmPasswordRequired');
    }
    if (value != originalPassword) {
      return errorMessage('passwordsDoNotMatch');
    }
    return null;
  }

  static bool isEmailValid(String? value) {
    if (value == null || value.isEmpty) return false;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$',
    );
    return emailRegex.hasMatch(value);
  }

  static bool isNameValid(String? value) {
    if (value == null || value.isEmpty) return false;
    final nameRegex = RegExp(r'^\s*\S+(?:\s+\S+)+\s*$');
    return nameRegex.hasMatch(value);
  }

  static bool isPasswordStrong(String? value) {
    if (value == null || value.isEmpty) return false;
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return passwordRegex.hasMatch(value);
  }
}
