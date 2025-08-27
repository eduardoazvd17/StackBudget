import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final DateTime registrationDate;
  final DateTime? lastLogin;

  const UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.registrationDate,
    this.lastLogin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'registrationDate': Timestamp.fromDate(registrationDate),
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
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
    );
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? registrationDate,
    DateTime? lastLogin,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      registrationDate: registrationDate ?? this.registrationDate,
      lastLogin: lastLogin ?? this.lastLogin,
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
        other.lastLogin == lastLogin;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        registrationDate.hashCode ^
        lastLogin.hashCode;
  }
}
