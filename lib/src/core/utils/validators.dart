class Validators {
  Validators._();

  /// Regular expression for email validation
  /// This pattern checks for:
  /// - One or more characters before the @ symbol
  /// - @ symbol
  /// - Domain name with at least one character
  /// - Dot followed by domain extension with 2-6 characters
  static bool email(String? value) {
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
  static bool name(String? value) {
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
  static bool password(String? value) {
    if (value == null || value.isEmpty) return false;
    final passwordRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[!@#$%^&*(),.?":{}|<>]).{8,}$',
    );
    return passwordRegex.hasMatch(value);
  }
}
