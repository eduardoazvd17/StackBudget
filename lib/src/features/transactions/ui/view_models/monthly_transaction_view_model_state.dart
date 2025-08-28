import 'package:stackbudget/src/features/transactions/data/models/models.dart';

abstract class MonthlyTransactionViewModelState {
  const MonthlyTransactionViewModelState();
}

class MonthlyTransactionInitialState extends MonthlyTransactionViewModelState {
  const MonthlyTransactionInitialState();
}

class MonthlyTransactionLoadingState extends MonthlyTransactionViewModelState {
  const MonthlyTransactionLoadingState();
}

class MonthlyTransactionLoadedState extends MonthlyTransactionViewModelState {
  final TransactionModel baseTransaction;
  final MonthlyTransactionModel? monthlyOverride;
  final double
  currentValue; // Valor que está sendo usado no mês (base ou override)
  final bool hasOverride; // Se existe um override para este mês

  const MonthlyTransactionLoadedState({
    required this.baseTransaction,
    required this.monthlyOverride,
    required this.currentValue,
    required this.hasOverride,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MonthlyTransactionLoadedState &&
        other.baseTransaction == baseTransaction &&
        other.monthlyOverride == monthlyOverride &&
        other.currentValue == currentValue &&
        other.hasOverride == hasOverride;
  }

  @override
  int get hashCode =>
      Object.hash(baseTransaction, monthlyOverride, currentValue, hasOverride);
}

class MonthlyTransactionSuccessState extends MonthlyTransactionViewModelState {
  final String message;
  final MonthlyTransactionModel? monthlyTransaction;

  const MonthlyTransactionSuccessState({
    required this.message,
    this.monthlyTransaction,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MonthlyTransactionSuccessState &&
        other.message == message &&
        other.monthlyTransaction == monthlyTransaction;
  }

  @override
  int get hashCode => Object.hash(message, monthlyTransaction);
}

class MonthlyTransactionErrorState extends MonthlyTransactionViewModelState {
  final String message;

  const MonthlyTransactionErrorState({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MonthlyTransactionErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
