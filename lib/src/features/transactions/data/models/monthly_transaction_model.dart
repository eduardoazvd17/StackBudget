import 'package:cloud_firestore/cloud_firestore.dart';

class MonthlyTransactionModel {
  final String id;
  final String userId;
  final String parentTransactionId; // ID da transação recorrente pai
  final int year;
  final int month;
  final double amount; // Valor específico para este mês
  final String? notes; // Observações específicas do mês
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isCustomAmount; // Se o valor foi alterado do valor padrão

  const MonthlyTransactionModel({
    required this.id,
    required this.userId,
    required this.parentTransactionId,
    required this.year,
    required this.month,
    required this.amount,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.isCustomAmount = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'parentTransactionId': parentTransactionId,
      'year': year,
      'month': month,
      'amount': amount,
      'notes': notes,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isCustomAmount': isCustomAmount,
    };
  }

  factory MonthlyTransactionModel.fromMap(Map<String, dynamic> map) {
    return MonthlyTransactionModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      parentTransactionId: map['parentTransactionId'] as String,
      year: map['year'] as int,
      month: map['month'] as int,
      amount: (map['amount'] as num).toDouble(),
      notes: map['notes'] as String?,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      isCustomAmount: map['isCustomAmount'] as bool? ?? false,
    );
  }

  MonthlyTransactionModel copyWith({
    String? id,
    String? userId,
    String? parentTransactionId,
    int? year,
    int? month,
    double? amount,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isCustomAmount,
  }) {
    return MonthlyTransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      parentTransactionId: parentTransactionId ?? this.parentTransactionId,
      year: year ?? this.year,
      month: month ?? this.month,
      amount: amount ?? this.amount,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isCustomAmount: isCustomAmount ?? this.isCustomAmount,
    );
  }

  String get monthYearKey => '${year}_${month.toString().padLeft(2, '0')}';

  DateTime get monthDate => DateTime(year, month, 1);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MonthlyTransactionModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'MonthlyTransactionModel(id: $id, parentId: $parentTransactionId, year: $year, month: $month, amount: $amount)';
  }
}
