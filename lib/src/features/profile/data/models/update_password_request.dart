class UpdatePasswordRequest {
  final String currentPassword;
  final String newPassword;

  const UpdatePasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UpdatePasswordRequest &&
        other.currentPassword == currentPassword &&
        other.newPassword == newPassword;
  }

  @override
  int get hashCode => currentPassword.hashCode ^ newPassword.hashCode;

  @override
  String toString() =>
      'UpdatePasswordRequest(currentPassword: [HIDDEN], newPassword: [HIDDEN])';
}
