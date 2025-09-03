import 'package:dartz/dartz.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/transactions/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

abstract class TransactionRepository {
  String generateTransactionId();
  Future<Either<AppException, TransactionModel?>> getTransactionById(
    String transactionId,
  );
  Future<Either<AppException, List<TransactionModel>>> getTransactionsByUser(
    String userId,
  );
  Future<Either<AppException, List<TransactionModel>>>
  getTransactionsByUserAndMonth(String userId, int year, int month);
  Future<Either<AppException, TransactionModel>> createTransaction(
    TransactionModel transaction,
  );
  Future<Either<AppException, TransactionModel>> updateTransaction(
    TransactionModel transaction,
  );
  Future<Either<AppException, void>> deleteTransaction(String transactionId);

  // Monthly transactions
  Future<Either<AppException, List<MonthlyTransactionModel>>>
  getMonthlyTransactions(String userId, int year, int month);
  Future<Either<AppException, MonthlyTransactionModel>>
  createMonthlyTransaction(MonthlyTransactionModel monthlyTransaction);
  Future<Either<AppException, MonthlyTransactionModel>>
  updateMonthlyTransaction(MonthlyTransactionModel monthlyTransaction);
  Future<Either<AppException, void>> deleteMonthlyTransaction(
    String monthlyTransactionId,
  );
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _datasource;

  const TransactionRepositoryImpl({required TransactionDatasource datasource})
    : _datasource = datasource;

  @override
  String generateTransactionId() {
    return _datasource.generateTransactionId();
  }

  @override
  Future<Either<AppException, TransactionModel?>> getTransactionById(
    String transactionId,
  ) async {
    return ErrorHandler.handle(
      'TransactionRepository.getTransactionById',
      onTry: () => _datasource.getTransactionById(transactionId),
    );
  }

  @override
  Future<Either<AppException, List<TransactionModel>>> getTransactionsByUser(
    String userId,
  ) async {
    return ErrorHandler.handle(
      'TransactionRepository.getTransactionsByUser',
      onTry: () => _datasource.getTransactionsByUser(userId),
    );
  }

  @override
  Future<Either<AppException, List<TransactionModel>>>
  getTransactionsByUserAndMonth(String userId, int year, int month) async {
    return ErrorHandler.handle(
      'TransactionRepository.getTransactionsByUserAndMonth',
      onTry:
          () => _datasource.getTransactionsByUserAndMonth(userId, year, month),
    );
  }

  @override
  Future<Either<AppException, TransactionModel>> createTransaction(
    TransactionModel transaction,
  ) async {
    return ErrorHandler.handle(
      'TransactionRepository.createTransaction',
      onTry: () => _datasource.createTransaction(transaction),
    );
  }

  @override
  Future<Either<AppException, TransactionModel>> updateTransaction(
    TransactionModel transaction,
  ) async {
    return ErrorHandler.handle(
      'TransactionRepository.updateTransaction',
      onTry: () => _datasource.updateTransaction(transaction),
    );
  }

  @override
  Future<Either<AppException, void>> deleteTransaction(
    String transactionId,
  ) async {
    return ErrorHandler.handle(
      'TransactionRepository.deleteTransaction',
      onTry: () => _datasource.deleteTransaction(transactionId),
    );
  }

  @override
  Future<Either<AppException, List<MonthlyTransactionModel>>>
  getMonthlyTransactions(String userId, int year, int month) async {
    return ErrorHandler.handle(
      'TransactionRepository.getMonthlyTransactions',
      onTry: () => _datasource.getMonthlyTransactions(userId, year, month),
    );
  }

  @override
  Future<Either<AppException, MonthlyTransactionModel>>
  createMonthlyTransaction(MonthlyTransactionModel monthlyTransaction) async {
    return ErrorHandler.handle(
      'TransactionRepository.createMonthlyTransaction',
      onTry: () => _datasource.createMonthlyTransaction(monthlyTransaction),
    );
  }

  @override
  Future<Either<AppException, MonthlyTransactionModel>>
  updateMonthlyTransaction(MonthlyTransactionModel monthlyTransaction) async {
    return ErrorHandler.handle(
      'TransactionRepository.updateMonthlyTransaction',
      onTry: () => _datasource.updateMonthlyTransaction(monthlyTransaction),
    );
  }

  @override
  Future<Either<AppException, void>> deleteMonthlyTransaction(
    String monthlyTransactionId,
  ) async {
    return ErrorHandler.handle(
      'TransactionRepository.deleteMonthlyTransaction',
      onTry: () => _datasource.deleteMonthlyTransaction(monthlyTransactionId),
    );
  }
}
