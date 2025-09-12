class Validators {
  Validators._();

  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email é obrigatório';
    }
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Email inválido';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  static String? securePassword(
    String? value,
    String? Function(String) errorMessage,
  ) {
    if (value == null || value.isEmpty) {
      return 'Nova senha é obrigatória';
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
    if (value.trim().length < 2) {
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

  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    if (value != originalPassword) {
      return 'Senhas não coincidem';
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
