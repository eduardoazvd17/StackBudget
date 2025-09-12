import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stackbudget/src/core/core.dart';

/// Modelo para resumo mensal do orçamento
/// Otimizado para consultas rápidas na tela principal
class MonthlyBudgetModel {
  final String id;
  final String userId;
  final int year;
  final int month;
  final double plannedIncome;
  final double actualIncome;
  final double plannedExpenses;
  final double actualExpenses;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Resumos por categoria (opcional)
  final Map<CategoryEnum, double>? plannedExpensesByCategory;
  final Map<CategoryEnum, double>? actualExpensesByCategory;

  const MonthlyBudgetModel({
    required this.id,
    required this.userId,
    required this.year,
    required this.month,
    this.plannedIncome = 0.0,
    this.actualIncome = 0.0,
    this.plannedExpenses = 0.0,
    this.actualExpenses = 0.0,
    required this.createdAt,
    required this.updatedAt,
    this.plannedExpensesByCategory,
    this.actualExpensesByCategory,
  });

  /// Saldo planejado (receitas - despesas planejadas)
  double get plannedBalance => plannedIncome - plannedExpenses;

  /// Saldo atual (receitas atuais - despesas atuais)
  double get actualBalance => actualIncome - actualExpenses;

  /// Diferença entre planejado e atual
  double get balanceDifference => actualBalance - plannedBalance;

  /// Percentual gasto do planejado
  double get expensePercentage =>
      plannedExpenses > 0 ? (actualExpenses / plannedExpenses) * 100 : 0;

  /// Chave única para o mês/ano
  String get monthYearKey => '${year}_${month.toString().padLeft(2, '0')}';

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'year': year,
      'month': month,
      'plannedIncome': plannedIncome,
      'actualIncome': actualIncome,
      'plannedExpenses': plannedExpenses,
      'actualExpenses': actualExpenses,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'plannedExpensesByCategory': plannedExpensesByCategory,
      'actualExpensesByCategory': actualExpensesByCategory,
    };
  }

  factory MonthlyBudgetModel.fromMap(Map<String, dynamic> map) {
    return MonthlyBudgetModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      year: map['year'] as int,
      month: map['month'] as int,
      plannedIncome: (map['plannedIncome'] as num?)?.toDouble() ?? 0.0,
      actualIncome: (map['actualIncome'] as num?)?.toDouble() ?? 0.0,
      plannedExpenses: (map['plannedExpenses'] as num?)?.toDouble() ?? 0.0,
      actualExpenses: (map['actualExpenses'] as num?)?.toDouble() ?? 0.0,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      plannedExpensesByCategory:
          map['plannedExpensesByCategory'] != null
              ? Map<CategoryEnum, double>.from(
                (map['plannedExpensesByCategory'] as Map).map(
                  (key, value) =>
                      MapEntry(key.toString(), (value as num).toDouble()),
                ),
              )
              : null,
      actualExpensesByCategory:
          map['actualExpensesByCategory'] != null
              ? Map<CategoryEnum, double>.from(
                (map['actualExpensesByCategory'] as Map).map(
                  (key, value) =>
                      MapEntry(key.toString(), (value as num).toDouble()),
                ),
              )
              : null,
    );
  }

  MonthlyBudgetModel copyWith({
    String? id,
    String? userId,
    int? year,
    int? month,
    double? plannedIncome,
    double? actualIncome,
    double? plannedExpenses,
    double? actualExpenses,
    DateTime? createdAt,
    DateTime? updatedAt,
    Map<CategoryEnum, double>? plannedExpensesByCategory,
    Map<CategoryEnum, double>? actualExpensesByCategory,
  }) {
    return MonthlyBudgetModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      year: year ?? this.year,
      month: month ?? this.month,
      plannedIncome: plannedIncome ?? this.plannedIncome,
      actualIncome: actualIncome ?? this.actualIncome,
      plannedExpenses: plannedExpenses ?? this.plannedExpenses,
      actualExpenses: actualExpenses ?? this.actualExpenses,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      plannedExpensesByCategory:
          plannedExpensesByCategory ?? this.plannedExpensesByCategory,
      actualExpensesByCategory:
          actualExpensesByCategory ?? this.actualExpensesByCategory,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MonthlyBudgetModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'MonthlyBudgetModel(year: $year, month: $month, plannedBalance: $plannedBalance, actualBalance: $actualBalance)';
  }
}
