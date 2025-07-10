import 'package:stackbudget/src/core/enums/recurrence_type_enum.dart';
import 'package:stackbudget/src/core/enums/transaction_type_enum.dart';

class TransactionModel {
  final String id;
  final String description;
  final DateTime date;
  final double baseValue;
  final TransactionTypeEnum type;
  final String userId;
  final String? category;
  final RecurrenceTypeEnum? recurrenceType;
  final Map<int, double>? valueByMonth;
  final DateTime? endDate;

  double getValue(DateTime date) => valueByMonth?[date.month] ?? baseValue;
  bool get isRecurring => recurrenceType != null;

  TransactionModel({
    required this.id,
    required this.description,
    required this.date,
    required this.baseValue,
    required this.type,
    required this.userId,
    this.category,
    this.recurrenceType,
    this.valueByMonth,
    this.endDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'description': description,
      'date': date.millisecondsSinceEpoch,
      'baseValue': baseValue,
      'type': type.index,
      'userId': userId,
      'category': category,
      'recurrenceType': recurrenceType?.index,
      'valueByMonth': valueByMonth,
      'endDate': endDate?.millisecondsSinceEpoch,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'] as String,
      description: map['description'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      baseValue: map['baseValue'] as double,
      type: TransactionTypeEnum.values[map['type'] as int],
      userId: map['userId'] as String,
      category: map['category'] != null ? map['category'] as String : null,
      recurrenceType:
          map['recurrenceType'] != null
              ? RecurrenceTypeEnum.values[map['recurrenceType'] as int]
              : null,
      valueByMonth:
          map['valueByMonth'] != null
              ? Map<int, double>.from((map['valueByMonth'] as Map<int, double>))
              : null,
      endDate:
          map['endDate'] != null
              ? DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int)
              : null,
    );
  }
}
