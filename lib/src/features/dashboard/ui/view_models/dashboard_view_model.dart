import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';
import 'package:stackbudget/src/features/transactions/data/repositories/repositories.dart';

final budgetCalculationServiceProvider = Provider<BudgetCalculationService>((
  ref,
) {
  return const BudgetCalculationService();
});

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardViewModelState>(
      (ref) => DashboardViewModel(
        ref.read(transactionRepositoryProvider),
        ref.read(budgetCalculationServiceProvider),
        ref,
      ),
    );

final selectedPeriodProvider = StateProvider<DateTime>((ref) => DateTime.now());

final userRegistrationDateProvider = Provider<DateTime?>((ref) {
  final authState = ref.watch(authViewModelProvider);
  if (authState is AuthenticatedState) {
    return authState.user.registrationDate;
  }
  return null;
});

final dashboardInitializerProvider = Provider<void>((ref) {
  final authState = ref.watch(authViewModelProvider);
  final selectedPeriod = ref.watch(selectedPeriodProvider);

  if (authState is AuthenticatedState) {
    final dashboardNotifier = ref.read(dashboardViewModelProvider.notifier);
    final currentDashboardState = ref.read(dashboardViewModelProvider);

    if (currentDashboardState is DashboardInitialState ||
        currentDashboardState is DashboardErrorState ||
        (currentDashboardState is DashboardLoadedState &&
            currentDashboardState.selectedPeriod != selectedPeriod)) {
      Future.microtask(
        () => dashboardNotifier.loadDashboardData(selectedPeriod),
      );
    }
  }
});

class DashboardViewModel extends StateNotifier<DashboardViewModelState> {
  final TransactionRepository _transactionRepository;
  final BudgetCalculationService _budgetService;
  final Ref _ref;

  DashboardViewModel(
    this._transactionRepository,
    this._budgetService,
    this._ref,
  ) : super(const DashboardInitialState());

  Future<void> loadDashboardData(
    DateTime period, {
    BuildContext? context,
  }) async {
    state = const DashboardLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = DashboardErrorState(
          exception: AppException.userNotAuthenticated(),
        );
        return;
      }

      final userId = authState.user.id;
      final year = period.year;
      final month = period.month;

      final transactionsResult = await _transactionRepository
          .getTransactionsByUserAndMonth(userId, year, month);

      final monthlyTransactionsResult = await _transactionRepository
          .getMonthlyTransactions(userId, year, month);

      await transactionsResult.fold(
        (exception) async {
          state = DashboardErrorState(exception: exception);
        },
        (transactions) async {
          await monthlyTransactionsResult.fold(
            (exception) async {
              state = DashboardErrorState(exception: exception);
            },
            (monthlyTransactions) async {
              final budgetSummary = _budgetService.calculateMonthlyBudget(
                userId: userId,
                year: year,
                month: month,
                transactions: transactions,
                monthlyTransactions: monthlyTransactions,
              );

              state = DashboardLoadedState(
                selectedPeriod: period,
                budgetSummary: budgetSummary,
                transactions: transactions,
                monthlyTransactions: monthlyTransactions,
              );
            },
          );
        },
      );
    } catch (e) {
      state = DashboardErrorState(
        exception: AppException.unexpectedError(
          'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> changePeriod(DateTime newPeriod) async {
    await loadDashboardData(newPeriod);
  }

  Future<void> refresh() async {
    if (state is DashboardLoadedState) {
      final currentState = state as DashboardLoadedState;
      await loadDashboardData(currentState.selectedPeriod);
    } else {
      await loadDashboardData(DateTime.now());
    }
  }

  Map<String, dynamic>? getBudgetStats() {
    if (state is DashboardLoadedState) {
      final currentState = state as DashboardLoadedState;
      if (currentState.budgetSummary != null) {
        return _budgetService.calculateBudgetStats(currentState.budgetSummary!);
      }
    }
    return null;
  }
}
