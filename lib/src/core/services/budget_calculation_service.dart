import 'package:stackbudget/src/core/enums/enums.dart';
import 'package:stackbudget/src/features/budget/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

class BudgetCalculationService {
  const BudgetCalculationService();

  /// Calcula o resumo do orçamento para um período específico
  MonthlyBudgetModel calculateMonthlyBudget({
    required String userId,
    required int year,
    required int month,
    required List<TransactionModel> transactions,
    required List<MonthlyTransactionModel> monthlyTransactions,
  }) {
    // Filtrar transações que se aplicam ao período
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

    final Map<String, double> plannedExpensesByCategory = {};
    final Map<String, double> actualExpensesByCategory = {};

    // Processar transações base
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

        // Agrupar por categoria
        final category = transaction.category?.displayName ?? 'Outros';
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

  /// Verifica se uma transação se aplica ao mês/ano especificado
  bool _transactionAppliesTo(
    TransactionModel transaction,
    int year,
    int month,
  ) {
    final targetDate = DateTime(year, month, 1);

    switch (transaction.frequency) {
      case TransactionFrequencyEnum.oneTime:
        // Transação única: verifica se a data de criação está no mês
        final createdDate = transaction.createdAt;
        return createdDate.year == year && createdDate.month == month;

      case TransactionFrequencyEnum.monthly:
        // Transação mensal: verifica se está no período ativo
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

      case TransactionFrequencyEnum.yearly:
        // Transação anual: verifica se é o mês correto
        if (transaction.yearlyMonth == null) return false;
        return transaction.yearlyMonth!.value == month;

      case TransactionFrequencyEnum.installment:
        // Transação parcelada: verifica se alguma parcela se aplica ao mês
        if (transaction.totalInstallments == null ||
            transaction.startDate == null) {
          return false;
        }

        final startDate = transaction.startDate!;
        final totalInstallments = transaction.totalInstallments!;

        // Verificar se o mês alvo está dentro do período de parcelas
        for (int i = 0; i < totalInstallments; i++) {
          final installmentMonth = DateTime(
            startDate.year,
            startDate.month + i,
            1,
          );
          
          if (installmentMonth.year == year && installmentMonth.month == month) {
            return true;
          }
        }

        return false;
    }
  }

  /// Obtém o valor da transação para um período específico
  /// Considera alterações mensais para transações recorrentes
  double _getTransactionAmount(
    TransactionModel transaction,
    int year,
    int month,
    List<MonthlyTransactionModel> monthlyTransactions,
  ) {
    // Calcular valor padrão baseado no tipo de transação
    double defaultAmount = transaction.amount;
    
    // Para transações parceladas, dividir o valor total pelo número de parcelas
    if (transaction.frequency == TransactionFrequencyEnum.installment &&
        transaction.totalInstallments != null &&
        transaction.totalInstallments! > 0) {
      defaultAmount = transaction.amount / transaction.totalInstallments!;
    }

    // Buscar valor específico do mês (todas as transações podem ter valores ajustados)
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

  /// Calcula estatísticas adicionais do orçamento
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
