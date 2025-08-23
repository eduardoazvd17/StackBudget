import 'package:stackbudget/src/core/enums/moth_enum.dart';

class RecurrentTransactionModel {
  final String id;
  final String description;
  final double predictedValue;
  final Set<MonthEnum> months;
  final Map<MonthEnum, double> valueOverrides;
  final int? startYear;
  final int? endYear;
  final String? categoryId;

  RecurrentTransactionModel({
    required this.id,
    required this.description,
    required this.predictedValue,
    required this.months,
    required this.valueOverrides,
    this.startYear,
    this.endYear,
    this.categoryId,
  });
}
