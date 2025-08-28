import 'package:stackbudget/src/core/enums/enums.dart';

class CategoryModel {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String? icon; // Nome do ícone (ex: 'shopping_cart', 'restaurant', etc)
  final String? color; // Cor em hex (ex: '#FF5722')
  final TransactionTypeEnum? type; // Null = ambos, senão específico para receita ou despesa
  final bool isDefault; // Se é uma categoria padrão do sistema
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryModel({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.icon,
    this.color,
    this.type,
    this.isDefault = false,
    required this.createdAt,
    required this.updatedAt,
  });

  CategoryModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    String? icon,
    String? color,
    TransactionTypeEnum? type,
    bool? isDefault,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      type: type ?? this.type,
      isDefault: isDefault ?? this.isDefault,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'description': description,
      'icon': icon,
      'color': color,
      'type': type?.name,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'] ?? '',
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      icon: map['icon'],
      color: map['color'],
      type: map['type'] != null 
          ? TransactionTypeEnum.values.firstWhere(
              (e) => e.name == map['type'],
              orElse: () => TransactionTypeEnum.expense,
            )
          : null,
      isDefault: map['isDefault'] ?? false,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CategoryModel &&
        other.id == id &&
        other.userId == userId &&
        other.name == name &&
        other.description == description &&
        other.icon == icon &&
        other.color == color &&
        other.type == type &&
        other.isDefault == isDefault &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      userId,
      name,
      description,
      icon,
      color,
      type,
      isDefault,
      createdAt,
      updatedAt,
    );
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, name: $name, type: $type, isDefault: $isDefault)';
  }
}
