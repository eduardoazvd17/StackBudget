class Failure implements Exception {
  final String message;
  const Failure({required this.message});

  @override
  String toString() => 'Failure: $message';
}
