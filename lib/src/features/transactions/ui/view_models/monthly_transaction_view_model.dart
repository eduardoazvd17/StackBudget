import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/transactions/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/monthly_transaction_view_model_state.dart';

// Provider para o ViewModel de transações mensais
final monthlyTransactionViewModelProvider = StateNotifierProvider<
  MonthlyTransactionViewModel,
  MonthlyTransactionViewModelState
>(
  (ref) =>
      MonthlyTransactionViewModel(ref.read(transactionRepositoryProvider), ref),
);

class MonthlyTransactionViewModel
    extends StateNotifier<MonthlyTransactionViewModelState> {
  final TransactionRepository _repository;
  final Ref _ref;

  MonthlyTransactionViewModel(this._repository, this._ref)
    : super(const MonthlyTransactionInitialState());

  /// Carrega os dados de uma transação para um mês específico
  Future<void> loadMonthlyTransaction({
    required String transactionId,
    required int year,
    required int month,
  }) async {
    state = const MonthlyTransactionLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = const MonthlyTransactionErrorState(
          message: 'Usuário não autenticado',
        );
        return;
      }

      final userId = authState.user.id;

      // Buscar a transação base
      final baseTransactionResult = await _repository.getTransactionById(
        transactionId,
      );

      final baseTransaction = baseTransactionResult.fold(
        (failure) => throw failure,
        (transaction) => transaction,
      );

      if (baseTransaction == null) {
        state = const MonthlyTransactionErrorState(
          message: 'Transação não encontrada',
        );
        return;
      }

      // Verificar se é uma transação recorrente mensal
      if (baseTransaction.frequency != TransactionFrequencyEnum.monthly) {
        state = const MonthlyTransactionErrorState(
          message: 'Esta transação não permite ajustes mensais',
        );
        return;
      }

      // Buscar override mensal se existir
      final monthlyTransactionsResult = await _repository
          .getMonthlyTransactions(userId, year, month);

      final monthlyTransactions = monthlyTransactionsResult.fold(
        (failure) => <MonthlyTransactionModel>[],
        (transactions) => transactions,
      );

      // Encontrar override específico para esta transação
      final monthlyOverride =
          monthlyTransactions
                  .where((mt) => mt.parentTransactionId == transactionId)
                  .isNotEmpty
              ? monthlyTransactions
                  .where((mt) => mt.parentTransactionId == transactionId)
                  .first
              : null;

      final currentValue = monthlyOverride?.amount ?? baseTransaction.amount;
      final hasOverride = monthlyOverride != null;

      state = MonthlyTransactionLoadedState(
        baseTransaction: baseTransaction,
        monthlyOverride: monthlyOverride,
        currentValue: currentValue,
        hasOverride: hasOverride,
      );
    } catch (e) {
      state = MonthlyTransactionErrorState(
        message: 'Erro ao carregar dados: ${e.toString()}',
      );
    }
  }

  /// Atualiza o valor para um mês específico
  Future<void> updateMonthlyValue({
    required String transactionId,
    required int year,
    required int month,
    required double newAmount,
  }) async {
    if (state is! MonthlyTransactionLoadedState) {
      state = const MonthlyTransactionErrorState(
        message: 'Dados não carregados. Recarregue a tela.',
      );
      return;
    }

    final currentState = state as MonthlyTransactionLoadedState;
    state = const MonthlyTransactionLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = const MonthlyTransactionErrorState(
          message: 'Usuário não autenticado',
        );
        return;
      }

      final userId = authState.user.id;
      final baseTransaction = currentState.baseTransaction;

      // Se o novo valor é igual ao valor base, remover override
      if (newAmount == baseTransaction.amount) {
        if (currentState.hasOverride) {
          await _removeMonthlyOverride(currentState.monthlyOverride!.id);
          state = const MonthlyTransactionSuccessState(
            message: 'Valor restaurado para o valor padrão da transação',
          );
        } else {
          state = const MonthlyTransactionSuccessState(
            message: 'Valor mantido (já é o valor padrão)',
          );
        }
        return;
      }

      MonthlyTransactionModel monthlyTransaction;

      if (currentState.hasOverride) {
        // Atualizar override existente
        monthlyTransaction = currentState.monthlyOverride!.copyWith(
          amount: newAmount,
          updatedAt: DateTime.now(),
        );

        final result = await _repository.updateMonthlyTransaction(
          monthlyTransaction,
        );

        result.fold(
          (failure) => throw failure,
          (updated) => monthlyTransaction = updated,
        );
      } else {
        // Criar novo override
        monthlyTransaction = MonthlyTransactionModel(
          id: _repository.generateTransactionId(),
          userId: userId,
          parentTransactionId: transactionId,
          year: year,
          month: month,
          amount: newAmount,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        final result = await _repository.createMonthlyTransaction(
          monthlyTransaction,
        );

        result.fold(
          (failure) => throw failure,
          (created) => monthlyTransaction = created,
        );
      }

      state = MonthlyTransactionSuccessState(
        message: 'Valor atualizado para este mês com sucesso!',
        monthlyTransaction: monthlyTransaction,
      );

      // Atualizar dashboard
      _ref.read(dashboardViewModelProvider.notifier).refresh();
    } catch (e) {
      state = MonthlyTransactionErrorState(
        message: 'Erro ao atualizar valor: ${e.toString()}',
      );
    }
  }

  /// Remove um override mensal (volta ao valor base)
  Future<void> removeMonthlyOverride() async {
    if (state is! MonthlyTransactionLoadedState) {
      state = const MonthlyTransactionErrorState(
        message: 'Dados não carregados. Recarregue a tela.',
      );
      return;
    }

    final currentState = state as MonthlyTransactionLoadedState;

    if (!currentState.hasOverride) {
      state = const MonthlyTransactionSuccessState(
        message: 'Não há ajuste mensal para remover',
      );
      return;
    }

    state = const MonthlyTransactionLoadingState();

    try {
      await _removeMonthlyOverride(currentState.monthlyOverride!.id);

      state = const MonthlyTransactionSuccessState(
        message: 'Ajuste mensal removido. Valor restaurado para o padrão.',
      );

      // Atualizar dashboard
      _ref.read(dashboardViewModelProvider.notifier).refresh();
    } catch (e) {
      state = MonthlyTransactionErrorState(
        message: 'Erro ao remover ajuste: ${e.toString()}',
      );
    }
  }

  Future<void> _removeMonthlyOverride(String monthlyTransactionId) async {
    final result = await _repository.deleteMonthlyTransaction(
      monthlyTransactionId,
    );

    result.fold(
      (failure) => throw failure,
      (_) => {}, // Sucesso
    );
  }

  /// Reseta o estado
  void resetState() {
    state = const MonthlyTransactionInitialState();
  }
}
