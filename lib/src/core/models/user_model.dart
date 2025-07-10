class UserModel {
  final String id;
  final String name;
  final String email;
  final String currency;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.currency,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'currency': currency,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      currency: map['currency'] as String,
    );
  }
}
