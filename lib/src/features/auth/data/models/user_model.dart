import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final DateTime registrationDate;
  final DateTime? lastLogin;
  final String currency;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.registrationDate,
    this.lastLogin,
    this.currency = 'BRL',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'registrationDate': Timestamp.fromDate(registrationDate),
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
      'currency': currency,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      registrationDate: (map['registrationDate'] as Timestamp).toDate(),
      lastLogin:
          map['lastLogin'] != null
              ? (map['lastLogin'] as Timestamp).toDate()
              : null,
      currency: map['currency'] as String? ?? 'BRL',
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? registrationDate,
    DateTime? lastLogin,
    String? currency,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      registrationDate: registrationDate ?? this.registrationDate,
      lastLogin: lastLogin ?? this.lastLogin,
      currency: currency ?? this.currency,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.registrationDate == registrationDate &&
        other.lastLogin == lastLogin &&
        other.currency == currency;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        registrationDate.hashCode ^
        lastLogin.hashCode ^
        currency.hashCode;
  }
}
