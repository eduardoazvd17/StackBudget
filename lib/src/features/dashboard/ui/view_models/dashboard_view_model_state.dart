import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

abstract class DashboardViewModelState {
  const DashboardViewModelState();
}

class DashboardInitialState extends DashboardViewModelState {
  const DashboardInitialState();
}

class DashboardLoadingState extends DashboardViewModelState {
  const DashboardLoadingState();
}

class DashboardLoadedState extends DashboardViewModelState {
  final DateTime selectedPeriod;
  final MonthlyBudgetModel? budgetSummary;
  final List<TransactionModel> transactions;
  final List<MonthlyTransactionModel> monthlyTransactions;

  const DashboardLoadedState({
    required this.selectedPeriod,
    this.budgetSummary,
    required this.transactions,
    required this.monthlyTransactions,
  });

  DashboardLoadedState copyWith({
    DateTime? selectedPeriod,
    MonthlyBudgetModel? budgetSummary,
    List<TransactionModel>? transactions,
    List<MonthlyTransactionModel>? monthlyTransactions,
  }) {
    return DashboardLoadedState(
      selectedPeriod: selectedPeriod ?? this.selectedPeriod,
      budgetSummary: budgetSummary ?? this.budgetSummary,
      transactions: transactions ?? this.transactions,
      monthlyTransactions: monthlyTransactions ?? this.monthlyTransactions,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DashboardLoadedState &&
        other.selectedPeriod == selectedPeriod &&
        other.budgetSummary == budgetSummary &&
        other.transactions == transactions &&
        other.monthlyTransactions == monthlyTransactions;
  }

  @override
  int get hashCode {
    return selectedPeriod.hashCode ^
        budgetSummary.hashCode ^
        transactions.hashCode ^
        monthlyTransactions.hashCode;
  }
}

class DashboardErrorState extends DashboardViewModelState {
  final AppException exception;

  const DashboardErrorState({required this.exception});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is DashboardErrorState && other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;
}
