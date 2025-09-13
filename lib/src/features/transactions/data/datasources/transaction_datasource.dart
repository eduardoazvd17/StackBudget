import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/enums/enums.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

final transactionDatasourceProvider = Provider<TransactionDatasource>((ref) {
  return TransactionDatasourceImpl(firestore: FirebaseFirestore.instance);
});

abstract class TransactionDatasource {
  String generateTransactionId();
  Future<TransactionModel?> getTransactionById(String transactionId);
  Future<List<TransactionModel>> getTransactionsByUser(String userId);
  Future<List<TransactionModel>> getTransactionsByUserAndMonth(
    String userId,
    int year,
    int month,
  );
  Future<TransactionModel> createTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransaction(TransactionModel transaction);
  Future<void> deleteTransaction(String transactionId);

  Future<List<MonthlyTransactionModel>> getMonthlyTransactions(
    String userId,
    int year,
    int month,
  );
  Future<MonthlyTransactionModel> createMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  );
  Future<MonthlyTransactionModel> updateMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  );
  Future<void> deleteMonthlyTransaction(String monthlyTransactionId);
}

class TransactionDatasourceImpl implements TransactionDatasource {
  final FirebaseFirestore _firestore;

  const TransactionDatasourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  @override
  String generateTransactionId() {
    return _firestore.collection('transactions').doc().id;
  }

  @override
  Future<TransactionModel?> getTransactionById(String transactionId) async {
    try {
      final doc =
          await _firestore.collection('transactions').doc(transactionId).get();

      if (!doc.exists || doc.data() == null) {
        return null;
      }

      return TransactionModel.fromMap(doc.data()!);
    } catch (e) {
      throw AppException.transactionLoadFailed(
        'Failed to get transaction by id: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByUser(String userId) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('transactions')
              .where('userId', isEqualTo: userId)
              .orderBy('createdAt', descending: true)
              .get();

      return querySnapshot.docs
          .map((doc) => TransactionModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw AppException.transactionLoadFailed(
        'Failed to get transactions by user: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByUserAndMonth(
    String userId,
    int year,
    int month,
  ) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('transactions')
              .where('userId', isEqualTo: userId)
              .get();

      final transactions =
          querySnapshot.docs
              .map((doc) => TransactionModel.fromMap(doc.data()))
              .where(
                (transaction) =>
                    _transactionAppliesTo(transaction, year, month),
              )
              .toList();

      return transactions;
    } catch (e) {
      throw AppException.transactionLoadFailed(
        'Failed to get transactions by month: ${e.toString()}',
      );
    }
  }

  @override
  Future<TransactionModel> createTransaction(
    TransactionModel transaction,
  ) async {
    try {
      await _firestore
          .collection('transactions')
          .doc(transaction.id)
          .set(transaction.toMap());

      return transaction;
    } catch (e) {
      throw AppException.transactionSaveFailed(
        'Failed to create transaction: ${e.toString()}',
      );
    }
  }

  @override
  Future<TransactionModel> updateTransaction(
    TransactionModel transaction,
  ) async {
    try {
      await _firestore
          .collection('transactions')
          .doc(transaction.id)
          .update(transaction.toMap());

      return transaction;
    } catch (e) {
      throw AppException.transactionUpdateFailed(
        'Failed to update transaction: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _firestore.collection('transactions').doc(transactionId).delete();
    } catch (e) {
      throw AppException.transactionDeleteFailed(
        'Failed to delete transaction: ${e.toString()}',
      );
    }
  }

  @override
  Future<List<MonthlyTransactionModel>> getMonthlyTransactions(
    String userId,
    int year,
    int month,
  ) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('monthlyTransactions')
              .where('userId', isEqualTo: userId)
              .where('year', isEqualTo: year)
              .where('month', isEqualTo: month)
              .get();

      return querySnapshot.docs
          .map((doc) => MonthlyTransactionModel.fromMap(doc.data()))
          .toList();
    } catch (e) {
      throw AppException.transactionLoadFailed(
        'Failed to get monthly transactions: ${e.toString()}',
      );
    }
  }

  @override
  Future<MonthlyTransactionModel> createMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  ) async {
    try {
      await _firestore
          .collection('monthlyTransactions')
          .doc(monthlyTransaction.id)
          .set(monthlyTransaction.toMap());

      return monthlyTransaction;
    } catch (e) {
      throw AppException.transactionSaveFailed(
        'Failed to create monthly transaction: ${e.toString()}',
      );
    }
  }

  @override
  Future<MonthlyTransactionModel> updateMonthlyTransaction(
    MonthlyTransactionModel monthlyTransaction,
  ) async {
    try {
      await _firestore
          .collection('monthlyTransactions')
          .doc(monthlyTransaction.id)
          .update(monthlyTransaction.toMap());

      return monthlyTransaction;
    } catch (e) {
      throw AppException.transactionUpdateFailed(
        'Failed to update monthly transaction: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> deleteMonthlyTransaction(String monthlyTransactionId) async {
    try {
      await _firestore
          .collection('monthlyTransactions')
          .doc(monthlyTransactionId)
          .delete();
    } catch (e) {
      throw AppException.transactionDeleteFailed(
        'Failed to delete monthly transaction: ${e.toString()}',
      );
    }
  }

  bool _transactionAppliesTo(
    TransactionModel transaction,
    int year,
    int month,
  ) {
    final targetDate = DateTime(year, month, 1);

    switch (transaction.frequency) {
      case TransactionFrequencyEnum.oneTime:
        final createdDate = transaction.createdAt;
        return createdDate.year == year && createdDate.month == month;

      case TransactionFrequencyEnum.monthly:
        final startDate = transaction.startDate ?? transaction.createdAt;
        final endDate = transaction.endDate;

        if (targetDate.isBefore(DateTime(startDate.year, startDate.month, 1))) {
          return false;
        }

        if (endDate != null &&
            targetDate.isAfter(DateTime(endDate.year, endDate.month, 1))) {
          return false;
        }

        return true;

      case TransactionFrequencyEnum.customMonthly:
        if (transaction.customMonths == null ||
            transaction.customMonths!.isEmpty) {
          return false;
        }
        if (!transaction.customMonths!.contains(month)) return false;

        // Verificar se o ano atual está dentro do período de recorrência
        if (transaction.endYear != null && year > transaction.endYear!) {
          return false;
        }

        return true;

      case TransactionFrequencyEnum.yearly:
        if (transaction.yearlyMonth == null) return false;
        if (transaction.yearlyMonth!.value != month) return false;

        // Verificar se o ano atual está dentro do período de recorrência
        if (transaction.endYear != null && year > transaction.endYear!) {
          return false;
        }

        return true;

      case TransactionFrequencyEnum.installment:
        if (transaction.totalInstallments == null ||
            transaction.startDate == null) {
          return false;
        }

        final startDate = transaction.startDate!;
        final totalInstallments = transaction.totalInstallments!;

        for (int i = 0; i < totalInstallments; i++) {
          final installmentMonth = DateTime(
            startDate.year,
            startDate.month + i,
            1,
          );

          if (installmentMonth.year == year &&
              installmentMonth.month == month) {
            return true;
          }
        }

        return false;
    }
  }
}
