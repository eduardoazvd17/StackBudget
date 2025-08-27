class Validators {
  Validators._();

  /// Validador para campos obrigatórios
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo é obrigatório';
    }
    return null;
  }

  /// Validador para email
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

  /// Validador para senha
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (value.length < 6) {
      return 'Senha deve ter pelo menos 6 caracteres';
    }
    return null;
  }

  /// Validador para confirmação de senha
  static String? confirmPassword(String? value, String originalPassword) {
    if (value == null || value.isEmpty) {
      return 'Confirmação de senha é obrigatória';
    }
    if (value != originalPassword) {
      return 'Senhas não coincidem';
    }
    return null;
  }

  /// Regular expression for email validation (boolean)
  /// This pattern checks for:
  /// - One or more characters before the @ symbol
  /// - @ symbol
  /// - Domain name with at least one character
  /// - Dot followed by domain extension with 2-6 characters
  static bool isEmailValid(String? value) {
    if (value == null || value.isEmpty) return false;
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$',
    );
    return emailRegex.hasMatch(value);
  }

  /// Regular expression for name validation
  /// This pattern checks for:
  /// - At least two words separated by whitespace
  /// - Each word must contain at least one character
  static bool isNameValid(String? value) {
    if (value == null || value.isEmpty) return false;
    final nameRegex = RegExp(r'^\s*\S+(?:\s+\S+)+\s*$');
    return nameRegex.hasMatch(value);
  }

  /// Regular expression for password validation
  /// This pattern checks for:
  /// - At least 8 characters in length
  /// - At least one uppercase letter
  /// - At least one lowercase letter
  /// - At least one special character
  static bool isPasswordStrong(String? value) {
    if (value == null || value.isEmpty) return false;
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return passwordRegex.hasMatch(value);
  }
}
