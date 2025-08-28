import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stackbudget/src/core/enums/enums.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

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

  // Monthly transactions
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
      throw Failure(message: 'Erro ao buscar transação: ${e.toString()}');
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
      throw Failure(message: 'Erro ao buscar transações: ${e.toString()}');
    }
  }

  @override
  Future<List<TransactionModel>> getTransactionsByUserAndMonth(
    String userId,
    int year,
    int month,
  ) async {
    try {
      // Buscar transações que se aplicam ao mês especificado
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
      throw Failure(
        message: 'Erro ao buscar transações do mês: ${e.toString()}',
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
      throw Failure(message: 'Erro ao criar transação: ${e.toString()}');
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
      throw Failure(message: 'Erro ao atualizar transação: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await _firestore.collection('transactions').doc(transactionId).delete();
    } catch (e) {
      throw Failure(message: 'Erro ao deletar transação: ${e.toString()}');
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
      throw Failure(
        message: 'Erro ao buscar transações mensais: ${e.toString()}',
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
      throw Failure(message: 'Erro ao criar transação mensal: ${e.toString()}');
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
      throw Failure(
        message: 'Erro ao atualizar transação mensal: ${e.toString()}',
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
      throw Failure(
        message: 'Erro ao deletar transação mensal: ${e.toString()}',
      );
    }
  }

  /// Verifica se uma transação se aplica ao mês/ano especificado
  bool _transactionAppliesTo(
    TransactionModel transaction,
    int year,
    int month,
  ) {
    final targetDate = DateTime(year, month, 1);

    switch (transaction.frequency) {
      case TransactionFrequencyEnum.oneTime:
        // Transação única: verifica se a data de criação está no mês
        final createdDate = transaction.createdAt;
        return createdDate.year == year && createdDate.month == month;

      case TransactionFrequencyEnum.monthly:
        // Transação mensal: verifica se está no período ativo
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

      case TransactionFrequencyEnum.yearly:
        // Transação anual: verifica se é o mês correto
        if (transaction.yearlyMonth == null) return false;
        return transaction.yearlyMonth!.value == month;

      case TransactionFrequencyEnum.installment:
        // Transação parcelada: verifica se a parcela se aplica ao mês
        if (transaction.totalInstallments == null ||
            transaction.startDate == null) {
          return false;
        }

        final startDate = transaction.startDate!;
        final installmentMonth = DateTime(
          startDate.year,
          startDate.month + (transaction.currentInstallment ?? 0),
          1,
        );

        return installmentMonth.year == year && installmentMonth.month == month;
    }
  }
}
