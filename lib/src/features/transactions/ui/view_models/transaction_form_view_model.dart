import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/transactions/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model_state.dart';

class TransactionFormViewModel
    extends StateNotifier<TransactionFormViewModelState> {
  final TransactionRepository _repository;
  final Ref _ref;

  TransactionFormViewModel(this._repository, this._ref)
    : super(const TransactionFormInitialState());

  /// Cria uma nova transação
  Future<void> createTransaction({
    required String title,
    String? description,
    required double amount,
    required TransactionTypeEnum type,
    required TransactionFrequencyEnum frequency,
    TransactionCategoryEnum? category,
    List<String>? tags,
    DateTime? startDate,
    DateTime? endDate,
    int? totalInstallments,
    MonthEnum? yearlyMonth,
    bool isDynamic = false,
  }) async {
    state = const TransactionFormLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = const TransactionFormErrorState(
          message: 'Usuário não autenticado',
        );
        return;
      }

      final userId = authState.user.id;
      final now = DateTime.now();

      // Validações específicas por tipo
      final validationError = _validateTransaction(
        frequency: frequency,
        startDate: startDate,
        totalInstallments: totalInstallments,
        yearlyMonth: yearlyMonth,
      );

      if (validationError != null) {
        state = TransactionFormErrorState(message: validationError);
        return;
      }

      final transaction = TransactionModel(
        id: _repository.generateTransactionId(),
        userId: userId,
        title: title,
        description: description,
        amount: amount,
        type: type,
        frequency: frequency,
        createdAt: now,
        updatedAt: now,
        startDate: startDate,
        endDate: endDate,
        totalInstallments: totalInstallments,
        currentInstallment:
            frequency == TransactionFrequencyEnum.installment ? 0 : null,
        yearlyMonth: yearlyMonth,
        isDynamic: isDynamic,
        category: category,
        tags: tags,
      );

      final result = await _repository.createTransaction(transaction);

      result.fold(
        (failure) =>
            state = TransactionFormErrorState(message: failure.message),
        (createdTransaction) {
          state = TransactionFormSuccessState(transaction: createdTransaction);
          // Atualizar dashboard após criar transação
          _ref.read(dashboardViewModelProvider.notifier).refresh();
        },
      );
    } catch (e) {
      state = TransactionFormErrorState(
        message: 'Erro inesperado: ${e.toString()}',
      );
    }
  }

  /// Valida os dados da transação baseado no tipo
  String? _validateTransaction({
    required TransactionFrequencyEnum frequency,
    DateTime? startDate,
    int? totalInstallments,
    MonthEnum? yearlyMonth,
  }) {
    switch (frequency) {
      case TransactionFrequencyEnum.monthly:
        if (startDate == null) {
          return 'Data de início é obrigatória para transações mensais';
        }
        break;

      case TransactionFrequencyEnum.installment:
        if (totalInstallments == null || totalInstallments <= 0) {
          return 'Número de parcelas deve ser maior que zero';
        }
        if (startDate == null) {
          return 'Data de início é obrigatória para transações parceladas';
        }
        break;

      case TransactionFrequencyEnum.yearly:
        if (yearlyMonth == null) {
          return 'Mês do ano é obrigatório para transações anuais';
        }
        break;

      case TransactionFrequencyEnum.oneTime:
        // Sem validações específicas
        break;
    }

    return null;
  }

  /// Atualiza uma transação existente
  Future<void> updateTransaction({
    required String transactionId,
    required String title,
    String? description,
    required double amount,
    required TransactionTypeEnum type,
    required TransactionFrequencyEnum frequency,
    TransactionCategoryEnum? category,
    List<String>? tags,
    DateTime? startDate,
    DateTime? endDate,
    int? totalInstallments,
    MonthEnum? yearlyMonth,
    bool isDynamic = false,
  }) async {
    state = const TransactionFormLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = const TransactionFormErrorState(
          message: 'Usuário não autenticado',
        );
        return;
      }

      final userId = authState.user.id;
      final now = DateTime.now();

      // Validações específicas por tipo
      final validationError = _validateTransaction(
        frequency: frequency,
        startDate: startDate,
        totalInstallments: totalInstallments,
        yearlyMonth: yearlyMonth,
      );

      if (validationError != null) {
        state = TransactionFormErrorState(message: validationError);
        return;
      }

      final transaction = TransactionModel(
        id: transactionId,
        userId: userId,
        title: title,
        description: description,
        amount: amount,
        type: type,
        frequency: frequency,
        createdAt: DateTime.now(), // Será preservado no update
        updatedAt: now,
        startDate: startDate,
        endDate: endDate,
        totalInstallments: totalInstallments,
        currentInstallment:
            frequency == TransactionFrequencyEnum.installment ? 0 : null,
        yearlyMonth: yearlyMonth,
        isDynamic: isDynamic,
        category: category,
        tags: tags,
      );

      final result = await _repository.updateTransaction(transaction);

      result.fold(
        (failure) =>
            state = TransactionFormErrorState(message: failure.message),
        (updatedTransaction) {
          state = TransactionFormSuccessState(transaction: updatedTransaction);
          // Atualizar dashboard após editar transação
          _ref.read(dashboardViewModelProvider.notifier).refresh();
        },
      );
    } catch (e) {
      state = TransactionFormErrorState(
        message: 'Erro inesperado: ${e.toString()}',
      );
    }
  }

  /// Exclui uma transação
  Future<void> deleteTransaction(String transactionId) async {
    state = const TransactionFormLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = const TransactionFormErrorState(
          message: 'Usuário não autenticado',
        );
        return;
      }

      final result = await _repository.deleteTransaction(transactionId);

      result.fold(
        (failure) =>
            state = TransactionFormErrorState(message: failure.message),
        (_) {
          state = TransactionFormSuccessState(
            transaction: TransactionModel(
              id: '',
              userId: '',
              title: 'Transação excluída',
              amount: 0,
              type: TransactionTypeEnum.expense,
              frequency: TransactionFrequencyEnum.oneTime,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          );
          // Atualizar dashboard após excluir transação
          _ref.read(dashboardViewModelProvider.notifier).refresh();
        },
      );
    } catch (e) {
      state = TransactionFormErrorState(
        message: 'Erro inesperado: ${e.toString()}',
      );
    }
  }

  /// Reseta o estado do formulário
  void resetForm() {
    state = const TransactionFormInitialState();
  }
}

// Provider para o ViewModel do formulário
final transactionFormViewModelProvider = StateNotifierProvider<
  TransactionFormViewModel,
  TransactionFormViewModelState
>(
  (ref) =>
      TransactionFormViewModel(ref.read(transactionRepositoryProvider), ref),
);
