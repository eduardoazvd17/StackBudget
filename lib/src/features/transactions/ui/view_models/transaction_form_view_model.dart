import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model_state.dart';

final transactionFormViewModelProvider = StateNotifierProvider<
  TransactionFormViewModel,
  TransactionFormViewModelState
>(
  (ref) =>
      TransactionFormViewModel(ref.read(transactionRepositoryProvider), ref),
);

class TransactionFormViewModel
    extends StateNotifier<TransactionFormViewModelState> {
  final TransactionRepository _repository;
  final Ref _ref;

  TransactionFormViewModel(this._repository, this._ref)
    : super(const TransactionFormInitialState());

  Future<void> createTransaction({
    required String title,
    String? description,
    required double amount,
    required TransactionTypeEnum type,
    required TransactionFrequencyEnum frequency,
    CategoryEnum? category,
    List<String>? tags,
    DateTime? startDate,
    DateTime? endDate,
    int? totalInstallments,
    MonthEnum? yearlyMonth,
    int? endYear,
    bool isDynamic = true,
  }) async {
    state = const TransactionFormLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = TransactionFormErrorState(
          exception: AppException.userNotAuthenticated(),
        );
        return;
      }

      final userId = authState.user.id;
      final now = DateTime.now();

      final validationError = _validateTransaction(
        frequency: frequency,
        startDate: startDate,
        totalInstallments: totalInstallments,
        yearlyMonth: yearlyMonth,
        endYear: endYear,
      );

      if (validationError != null) {
        state = TransactionFormErrorState(
          exception: AppException.validationError(validationError),
        );
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
        endYear: endYear,
        isDynamic: isDynamic,
        category: category,
        tags: tags,
      );

      final result = await _repository.createTransaction(transaction);

      result.fold(
        (exception) => state = TransactionFormErrorState(exception: exception),
        (createdTransaction) {
          state = TransactionFormSuccessState(transaction: createdTransaction);
          _ref.read(dashboardViewModelProvider.notifier).refresh();
        },
      );
    } catch (e) {
      state = TransactionFormErrorState(
        exception: AppException.unexpectedError(
          'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }

  String? _validateTransaction({
    required TransactionFrequencyEnum frequency,
    DateTime? startDate,
    int? totalInstallments,
    MonthEnum? yearlyMonth,
    int? endYear,
  }) {
    switch (frequency) {
      case TransactionFrequencyEnum.monthly:
        if (startDate == null) {
          return 'startDateRequiredForMonthly';
        }
        break;

      case TransactionFrequencyEnum.installment:
        if (totalInstallments == null || totalInstallments <= 0) {
          return 'installmentsMustBeGreaterThanZero';
        }
        if (startDate == null) {
          return 'startDateRequiredForInstallments';
        }
        break;

      case TransactionFrequencyEnum.yearly:
        if (yearlyMonth == null) {
          return 'yearlyMonthRequiredForYearly';
        }
        if (endYear != null && endYear < DateTime.now().year) {
          return 'endYearAfterCurrent';
        }
        break;

      case TransactionFrequencyEnum.oneTime:
        break;
    }

    return null;
  }

  Future<void> updateTransaction({
    required String transactionId,
    required String title,
    String? description,
    required double amount,
    required TransactionTypeEnum type,
    required TransactionFrequencyEnum frequency,
    CategoryEnum? category,
    List<String>? tags,
    DateTime? startDate,
    DateTime? endDate,
    int? totalInstallments,
    MonthEnum? yearlyMonth,
    int? endYear,
    bool isDynamic = true,
  }) async {
    state = const TransactionFormLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = TransactionFormErrorState(
          exception: AppException.userNotAuthenticated(),
        );
        return;
      }

      final userId = authState.user.id;
      final now = DateTime.now();

      final validationError = _validateTransaction(
        frequency: frequency,
        startDate: startDate,
        totalInstallments: totalInstallments,
        yearlyMonth: yearlyMonth,
        endYear: endYear,
      );

      if (validationError != null) {
        state = TransactionFormErrorState(
          exception: AppException.validationError(validationError),
        );
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
        createdAt: DateTime.now(),
        updatedAt: now,
        startDate: startDate,
        endDate: endDate,
        totalInstallments: totalInstallments,
        currentInstallment:
            frequency == TransactionFrequencyEnum.installment ? 0 : null,
        yearlyMonth: yearlyMonth,
        endYear: endYear,
        isDynamic: isDynamic,
        category: category,
        tags: tags,
      );

      final result = await _repository.updateTransaction(transaction);

      result.fold(
        (exception) => state = TransactionFormErrorState(exception: exception),
        (updatedTransaction) {
          state = TransactionFormSuccessState(transaction: updatedTransaction);
          _ref.read(dashboardViewModelProvider.notifier).refresh();
        },
      );
    } catch (e) {
      state = TransactionFormErrorState(
        exception: AppException.unexpectedError(
          'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }

  Future<void> deleteTransaction(String transactionId) async {
    state = const TransactionFormLoadingState();

    try {
      final authState = _ref.read(authViewModelProvider);
      if (authState is! AuthenticatedState) {
        state = TransactionFormErrorState(
          exception: AppException.userNotAuthenticated(),
        );
        return;
      }

      final result = await _repository.deleteTransaction(transactionId);

      result.fold(
        (exception) => state = TransactionFormErrorState(exception: exception),
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
          _ref.read(dashboardViewModelProvider.notifier).refresh();
        },
      );
    } catch (e) {
      state = TransactionFormErrorState(
        exception: AppException.unexpectedError(
          'Unexpected error: ${e.toString()}',
        ),
      );
    }
  }

  void resetForm() {
    state = const TransactionFormInitialState();
  }
}
