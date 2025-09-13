import 'package:stackbudget/src/core/enums/enums.dart';
import 'package:stackbudget/src/features/dashboard/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

class BudgetCalculationService {
  const BudgetCalculationService();

  MonthlyBudgetModel calculateMonthlyBudget({
    required String userId,
    required int year,
    required int month,
    required List<TransactionModel> transactions,
    required List<MonthlyTransactionModel> monthlyTransactions,
  }) {
    final applicableTransactions =
        transactions
            .where(
              (transaction) => _transactionAppliesTo(transaction, year, month),
            )
            .toList();

    double plannedIncome = 0.0;
    double actualIncome = 0.0;
    double plannedExpenses = 0.0;
    double actualExpenses = 0.0;

    final Map<CategoryEnum, double> plannedExpensesByCategory = {};
    final Map<CategoryEnum, double> actualExpensesByCategory = {};

    for (final transaction in applicableTransactions) {
      final amount = _getTransactionAmount(
        transaction,
        year,
        month,
        monthlyTransactions,
      );

      if (transaction.type == TransactionTypeEnum.income) {
        plannedIncome += transaction.amount;
        actualIncome += amount;
      } else {
        plannedExpenses += transaction.amount;
        actualExpenses += amount;

        final category = transaction.category ?? CategoryEnum.other;
        plannedExpensesByCategory[category] =
            (plannedExpensesByCategory[category] ?? 0) + transaction.amount;
        actualExpensesByCategory[category] =
            (actualExpensesByCategory[category] ?? 0) + amount;
      }
    }

    final now = DateTime.now();
    return MonthlyBudgetModel(
      id: '${userId}_${year}_${month.toString().padLeft(2, '0')}',
      userId: userId,
      year: year,
      month: month,
      plannedIncome: plannedIncome,
      actualIncome: actualIncome,
      plannedExpenses: plannedExpenses,
      actualExpenses: actualExpenses,
      createdAt: now,
      updatedAt: now,
      plannedExpensesByCategory:
          plannedExpensesByCategory.isNotEmpty
              ? plannedExpensesByCategory
              : null,
      actualExpensesByCategory:
          actualExpensesByCategory.isNotEmpty ? actualExpensesByCategory : null,
    );
  }

  bool _transactionAppliesTo(
    TransactionModel transaction,
    int year,
    int month,
  ) {
    final targetDate = DateTime(year, month, 1);

    switch (transaction.frequency) {
      case TransactionFrequencyEnum.oneTime:
        final createdDate = transaction.createdAt;
        return createdDate.year == year && createdDate.month == month;

      case TransactionFrequencyEnum.monthly:
        final startDate = transaction.startDate ?? transaction.createdAt;
        final endDate = transaction.endDate;

        if (targetDate.isBefore(DateTime(startDate.year, startDate.month, 1))) {
          return false;
        }

        if (endDate != null &&
            targetDate.isAfter(DateTime(endDate.year, endDate.month, 1))) {
          return false;
        }

        return true;

      case TransactionFrequencyEnum.customMonthly:
        if (transaction.customMonths == null ||
            transaction.customMonths!.isEmpty) {
          return false;
        }
        if (!transaction.customMonths!.contains(month)) return false;

        // Verificar se o ano atual está dentro do período de recorrência
        if (transaction.endYear != null && year > transaction.endYear!) {
          return false;
        }

        return true;

      case TransactionFrequencyEnum.yearly:
        if (transaction.yearlyMonth == null) return false;
        if (transaction.yearlyMonth!.value != month) return false;

        // Verificar se o ano atual está dentro do período de recorrência
        if (transaction.endYear != null && year > transaction.endYear!) {
          return false;
        }

        return true;

      case TransactionFrequencyEnum.installment:
        if (transaction.totalInstallments == null ||
            transaction.startDate == null) {
          return false;
        }

        final startDate = transaction.startDate!;
        final totalInstallments = transaction.totalInstallments!;

        for (int i = 0; i < totalInstallments; i++) {
          final installmentMonth = DateTime(
            startDate.year,
            startDate.month + i,
            1,
          );

          if (installmentMonth.year == year &&
              installmentMonth.month == month) {
            return true;
          }
        }

        return false;
    }
  }

  double _getTransactionAmount(
    TransactionModel transaction,
    int year,
    int month,
    List<MonthlyTransactionModel> monthlyTransactions,
  ) {
    double defaultAmount = transaction.amount;

    if (transaction.frequency == TransactionFrequencyEnum.installment &&
        transaction.totalInstallments != null &&
        transaction.totalInstallments! > 0) {
      defaultAmount = transaction.amount / transaction.totalInstallments!;
    }

    final monthlyTransaction = monthlyTransactions.firstWhere(
      (mt) =>
          mt.parentTransactionId == transaction.id &&
          mt.year == year &&
          mt.month == month,
      orElse:
          () => MonthlyTransactionModel(
            id: '',
            userId: transaction.userId,
            parentTransactionId: transaction.id,
            year: year,
            month: month,
            amount: defaultAmount, // Usar valor calculado
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
    );

    return monthlyTransaction.amount;
  }

  Map<String, dynamic> calculateBudgetStats(MonthlyBudgetModel budget) {
    final plannedBalance = budget.plannedBalance;
    final actualBalance = budget.actualBalance;
    final balanceDifference = budget.balanceDifference;

    final expensePercentage = budget.expensePercentage;
    final incomePercentage =
        budget.plannedIncome > 0
            ? (budget.actualIncome / budget.plannedIncome) * 100
            : 0.0;

    return {
      'plannedBalance': plannedBalance,
      'actualBalance': actualBalance,
      'balanceDifference': balanceDifference,
      'expensePercentage': expensePercentage,
      'incomePercentage': incomePercentage,
      'isOverBudget': actualBalance < plannedBalance,
      'savingsRate':
          budget.actualIncome > 0
              ? (actualBalance / budget.actualIncome) * 100
              : 0.0,
    };
  }
}
