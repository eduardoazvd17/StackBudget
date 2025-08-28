import 'package:stackbudget/src/features/transactions/data/models/models.dart';

abstract class TransactionFormViewModelState {
  const TransactionFormViewModelState();
}

class TransactionFormInitialState extends TransactionFormViewModelState {
  const TransactionFormInitialState();
}

class TransactionFormLoadingState extends TransactionFormViewModelState {
  const TransactionFormLoadingState();
}

class TransactionFormSuccessState extends TransactionFormViewModelState {
  final TransactionModel transaction;

  const TransactionFormSuccessState({required this.transaction});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionFormSuccessState &&
        other.transaction == transaction;
  }

  @override
  int get hashCode => transaction.hashCode;
}

class TransactionFormErrorState extends TransactionFormViewModelState {
  final String message;

  const TransactionFormErrorState({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TransactionFormErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
