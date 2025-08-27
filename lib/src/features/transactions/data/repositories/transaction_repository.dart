import 'package:dartz/dartz.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/transactions/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

abstract class TransactionRepository {
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByUser(
    String userId,
  );
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByUserAndMonth(
    String userId,
    int year,
    int month,
  );
  Future<Either<Failure, TransactionModel>> createTransaction(
    TransactionModel transaction,
  );
  Future<Either<Failure, TransactionModel>> updateTransaction(
    TransactionModel transaction,
  );
  Future<Either<Failure, void>> deleteTransaction(String transactionId);

  // Monthly transactions
  Future<Either<Failure, List<MonthlyTransactionModel>>> getMonthlyTransactions(
    String userId,
    int year,
    int month,
  );
  Future<Either<Failure, MonthlyTransactionModel>> createMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  );
  Future<Either<Failure, MonthlyTransactionModel>> updateMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  );
  Future<Either<Failure, void>> deleteMonthlyTransaction(
    String monthlyTransactionId,
  );
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _datasource;

  const TransactionRepositoryImpl({required TransactionDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByUser(
    String userId,
  ) async {
    try {
      final transactions = await _datasource.getTransactionsByUser(userId);
      return Right(transactions);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactionsByUserAndMonth(
    String userId,
    int year,
    int month,
  ) async {
    try {
      final transactions = await _datasource.getTransactionsByUserAndMonth(
        userId,
        year,
        month,
      );
      return Right(transactions);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TransactionModel>> createTransaction(
    TransactionModel transaction,
  ) async {
    try {
      final createdTransaction = await _datasource.createTransaction(
        transaction,
      );
      return Right(createdTransaction);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, TransactionModel>> updateTransaction(
    TransactionModel transaction,
  ) async {
    try {
      final updatedTransaction = await _datasource.updateTransaction(
        transaction,
      );
      return Right(updatedTransaction);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTransaction(String transactionId) async {
    try {
      await _datasource.deleteTransaction(transactionId);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<MonthlyTransactionModel>>> getMonthlyTransactions(
    String userId,
    int year,
    int month,
  ) async {
    try {
      final monthlyTransactions = await _datasource.getMonthlyTransactions(
        userId,
        year,
        month,
      );
      return Right(monthlyTransactions);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, MonthlyTransactionModel>> createMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  ) async {
    try {
      final createdMonthlyTransaction = await _datasource
          .createMonthlyTransaction(monthlyTransaction);
      return Right(createdMonthlyTransaction);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, MonthlyTransactionModel>> updateMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  ) async {
    try {
      final updatedMonthlyTransaction = await _datasource
          .updateMonthlyTransaction(monthlyTransaction);
      return Right(updatedMonthlyTransaction);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMonthlyTransaction(
    String monthlyTransactionId,
  ) async {
    try {
      await _datasource.deleteMonthlyTransaction(monthlyTransactionId);
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }
}
