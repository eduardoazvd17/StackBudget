import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';
import 'package:stackbudget/src/features/transactions/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/transactions/data/repositories/repositories.dart';

class DashboardViewModel extends StateNotifier<DashboardViewModelState> {
  final TransactionRepository _transactionRepository;
  final BudgetCalculationService _budgetService;
  final Ref _ref;

  DashboardViewModel(
    this._transactionRepository,
    this._budgetService,
    this._ref,
  ) : super(const DashboardInitialState()) {
    // Não carregar dados automaticamente - esperar o usuário estar autenticado
  }

  /// Carrega os dados do dashboard para um período específico
  Future<void> loadDashboardData(DateTime period) async {
    state = const DashboardLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = DashboardErrorState(
          exception: AppException.userNotAuthenticated(
            'User not authenticated',
          ),
        );
        return;
      }

      final userId = authState.user.id;
      final year = period.year;
      final month = period.month;

      // Buscar transações do período
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
              // Calcular resumo do orçamento
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

  /// Atualiza o período selecionado e recarrega os dados
  Future<void> changePeriod(DateTime newPeriod) async {
    await loadDashboardData(newPeriod);
  }

  /// Recarrega os dados do período atual
  Future<void> refresh() async {
    if (state is DashboardLoadedState) {
      final currentState = state as DashboardLoadedState;
      await loadDashboardData(currentState.selectedPeriod);
    } else {
      await loadDashboardData(DateTime.now());
    }
  }

  /// Obtém estatísticas do orçamento atual
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

// Providers
final budgetCalculationServiceProvider = Provider<BudgetCalculationService>((
  ref,
) {
  return const BudgetCalculationService();
});

final transactionDatasourceProvider = Provider<TransactionDatasource>((ref) {
  return TransactionDatasourceImpl(firestore: FirebaseFirestore.instance);
});

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) {
  return TransactionRepositoryImpl(
    datasource: ref.read(transactionDatasourceProvider),
  );
});

final dashboardViewModelProvider =
    StateNotifierProvider<DashboardViewModel, DashboardViewModelState>(
      (ref) => DashboardViewModel(
        ref.read(transactionRepositoryProvider),
        ref.read(budgetCalculationServiceProvider),
        ref,
      ),
    );

// Provider para o período selecionado (substitui o antigo selectedDateProvider)
final selectedPeriodProvider = StateProvider<DateTime>((ref) => DateTime.now());

// Provider para obter a data de cadastro do usuário atual
final userRegistrationDateProvider = Provider<DateTime?>((ref) {
  final authState = ref.watch(authViewModelProvider);
  if (authState is AuthenticatedState) {
    return authState.user.registrationDate;
  }
  return null;
});

// Provider que inicializa o dashboard quando o usuário está autenticado
final dashboardInitializerProvider = Provider<void>((ref) {
  final authState = ref.watch(authViewModelProvider);
  final selectedPeriod = ref.watch(selectedPeriodProvider);

  if (authState is AuthenticatedState) {
    final dashboardNotifier = ref.read(dashboardViewModelProvider.notifier);
    final currentDashboardState = ref.read(dashboardViewModelProvider);

    // Carregar se estiver no estado inicial, se não há dados para o período atual,
    // ou se estiver em estado de erro
    if (currentDashboardState is DashboardInitialState ||
        currentDashboardState is DashboardErrorState ||
        (currentDashboardState is DashboardLoadedState &&
            currentDashboardState.selectedPeriod != selectedPeriod)) {
      // Definir estado de loading imediatamente para evitar mostrar dados antigos
      // (isso será feito dentro do loadDashboardData)

      Future.microtask(
        () => dashboardNotifier.loadDashboardData(selectedPeriod),
      );
    }
  }
});
