import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stackbudget/src/core/enums/enums.dart';

class TransactionModel {
  final String id;
  final String userId;
  final String title;
  final String? description;
  final double amount;
  final TransactionTypeEnum type; // income ou expense
  final TransactionFrequencyEnum frequency;
  final DateTime createdAt;
  final DateTime updatedAt;

  final DateTime? startDate;
  final DateTime? endDate;

  final int? totalInstallments;
  final int? currentInstallment;

  final MonthEnum? yearlyMonth; // Em qual mês do ano ocorre

  final bool isDynamic; // Se o valor pode ser alterado mês a mês

  final CategoryEnum? category;

  final List<String>? tags;

  const TransactionModel({
    required this.id,
    required this.userId,
    required this.title,
    this.description,
    required this.amount,
    required this.type,
    required this.frequency,
    required this.createdAt,
    required this.updatedAt,
    this.startDate,
    this.endDate,
    this.totalInstallments,
    this.currentInstallment,
    this.yearlyMonth,
    this.isDynamic = false,
    this.category,
    this.tags,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'amount': amount,
      'type': type.name,
      'frequency': frequency.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'startDate': startDate != null ? Timestamp.fromDate(startDate!) : null,
      'endDate': endDate != null ? Timestamp.fromDate(endDate!) : null,
      'totalInstallments': totalInstallments,
      'currentInstallment': currentInstallment,
      'yearlyMonth': yearlyMonth?.name,
      'isDynamic': isDynamic,
      'category': category?.name,
      'tags': tags,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      title: map['title'] as String,
      description: map['description'] as String?,
      amount: (map['amount'] as num).toDouble(),
      type: TransactionTypeEnum.values.firstWhere(
        (e) => e.name == map['type'],
        orElse: () => TransactionTypeEnum.expense,
      ),
      frequency: TransactionFrequencyEnum.values.firstWhere(
        (e) => e.name == map['frequency'],
        orElse: () => TransactionFrequencyEnum.oneTime,
      ),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      startDate:
          map['startDate'] != null
              ? (map['startDate'] as Timestamp).toDate()
              : null,
      endDate:
          map['endDate'] != null
              ? (map['endDate'] as Timestamp).toDate()
              : null,
      totalInstallments: map['totalInstallments'] as int?,
      currentInstallment: map['currentInstallment'] as int?,
      yearlyMonth:
          map['yearlyMonth'] != null
              ? MonthEnum.values.firstWhere(
                (e) => e.name == map['yearlyMonth'],
                orElse: () => MonthEnum.january,
              )
              : null,
      isDynamic: map['isDynamic'] as bool? ?? false,
      category:
          map['category'] != null
              ? CategoryEnum.values.firstWhere(
                (e) => e.name == map['category'],
                orElse: () => CategoryEnum.other,
              )
              : null,
      tags: map['tags'] != null ? List<String>.from(map['tags'] as List) : null,
    );
  }

  TransactionModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    double? amount,
    TransactionTypeEnum? type,
    TransactionFrequencyEnum? frequency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? startDate,
    DateTime? endDate,
    int? totalInstallments,
    int? currentInstallment,
    MonthEnum? yearlyMonth,
    bool? isDynamic,
    CategoryEnum? category,
    List<String>? tags,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      frequency: frequency ?? this.frequency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      totalInstallments: totalInstallments ?? this.totalInstallments,
      currentInstallment: currentInstallment ?? this.currentInstallment,
      yearlyMonth: yearlyMonth ?? this.yearlyMonth,
      isDynamic: isDynamic ?? this.isDynamic,
      category: category ?? this.category,
      tags: tags ?? this.tags,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'TransactionModel(id: $id, title: $title, amount: $amount, type: $type, frequency: $frequency)';
  }
}
