import 'package:stackbudget/src/core/enums/moth_enum.dart';

class MonthTransactionModel {
  final String id;
  final String description;
  final double value;
  final MonthEnum month;
  final String? categoryId;

  MonthTransactionModel({
    required this.id,
    required this.description,
    required this.value,
    required this.month,
    this.categoryId,
  });
}
