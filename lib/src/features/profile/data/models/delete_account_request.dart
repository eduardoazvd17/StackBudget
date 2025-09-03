class DeleteAccountRequest {
  final String currentPassword;

  const DeleteAccountRequest({required this.currentPassword});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DeleteAccountRequest &&
        other.currentPassword == currentPassword;
  }

  @override
  int get hashCode => currentPassword.hashCode;

  @override
  String toString() => 'DeleteAccountRequest(currentPassword: [HIDDEN])';
}
