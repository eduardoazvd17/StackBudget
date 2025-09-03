class UpdateNameRequest {
  final String newName;

  const UpdateNameRequest({required this.newName});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UpdateNameRequest && other.newName == newName;
  }

  @override
  int get hashCode => newName.hashCode;

  @override
  String toString() => 'UpdateNameRequest(newName: $newName)';
}
