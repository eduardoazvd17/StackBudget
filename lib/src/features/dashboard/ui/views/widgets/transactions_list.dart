import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';

// Mock data para demonstração
class TransactionMock {
  final String id;
  final String title;
  final String? description;
  final double amount;
  final TransactionTypeEnum type;
  final TransactionFrequencyEnum frequency;
  final DateTime date;
  final String? category;

  const TransactionMock({
    required this.id,
    required this.title,
    this.description,
    required this.amount,
    required this.type,
    required this.frequency,
    required this.date,
    this.category,
  });
}

// Mock provider - será substituído por dados reais
final transactionsProvider = Provider<List<TransactionMock>>((ref) {
  return [
    TransactionMock(
      id: '1',
      title: 'Salário',
      amount: 5000.0,
      type: TransactionTypeEnum.income,
      frequency: TransactionFrequencyEnum.monthly,
      date: DateTime.now(),
      category: 'Trabalho',
    ),
    TransactionMock(
      id: '2',
      title: 'Aluguel',
      amount: 1200.0,
      type: TransactionTypeEnum.expense,
      frequency: TransactionFrequencyEnum.monthly,
      date: DateTime.now(),
      category: 'Moradia',
    ),
    TransactionMock(
      id: '3',
      title: 'Conta de Luz',
      amount: 150.0,
      type: TransactionTypeEnum.expense,
      frequency: TransactionFrequencyEnum.monthly,
      date: DateTime.now(),
      category: 'Utilidades',
    ),
    TransactionMock(
      id: '4',
      title: 'Supermercado',
      amount: 350.0,
      type: TransactionTypeEnum.expense,
      frequency: TransactionFrequencyEnum.oneTime,
      date: DateTime.now().subtract(const Duration(days: 2)),
      category: 'Alimentação',
    ),
    TransactionMock(
      id: '5',
      title: 'IPVA',
      amount: 800.0,
      type: TransactionTypeEnum.expense,
      frequency: TransactionFrequencyEnum.yearly,
      date: DateTime.now(),
      category: 'Veículo',
    ),
  ];
});

class TransactionsList extends ConsumerWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionsProvider);
    // TODO: Filtrar transações baseado na data selecionada
    // final selectedDate = ref.watch(selectedDateProvider);

    if (transactions.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withOpacity(0.3),
              ),
              const SizedBox(height: Spacing.md),
              Text(
                'Nenhuma transação encontrada',
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                'Adicione sua primeira transação para começar',
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final transaction = transactions[index];
        return Padding(
          padding: EdgeInsets.only(
            left: Spacing.lg,
            right: Spacing.lg,
            bottom: index == transactions.length - 1 ? 0 : Spacing.sm,
          ),
          child: _buildTransactionItem(context, transaction),
        );
      }, childCount: transactions.length),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    TransactionMock transaction,
  ) {
    final isIncome = transaction.type == TransactionTypeEnum.income;
    final color = isIncome ? Colors.green : Colors.red;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(_getTransactionIcon(transaction), color: color),
        ),

        title: Text(
          transaction.title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (transaction.category != null) ...[
              Text(
                transaction.category!,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
            Text(
              _getFrequencyText(transaction.frequency),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : '-'} ${_formatCurrency(transaction.amount)}',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              _formatDate(transaction.date),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),

        onTap: () {
          // TODO: Navegar para detalhes/edição da transação
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Editar ${transaction.title} - Em breve!')),
          );
        },
      ),
    );
  }

  IconData _getTransactionIcon(TransactionMock transaction) {
    if (transaction.type == TransactionTypeEnum.income) {
      return Icons.arrow_downward;
    }

    switch (transaction.frequency) {
      case TransactionFrequencyEnum.monthly:
        return Icons.repeat;
      case TransactionFrequencyEnum.yearly:
        return Icons.event_repeat;
      case TransactionFrequencyEnum.installment:
        return Icons.payment;
      case TransactionFrequencyEnum.oneTime:
        return Icons.arrow_upward;
    }
  }

  String _getFrequencyText(TransactionFrequencyEnum frequency) {
    switch (frequency) {
      case TransactionFrequencyEnum.monthly:
        return 'Mensal';
      case TransactionFrequencyEnum.yearly:
        return 'Anual';
      case TransactionFrequencyEnum.installment:
        return 'Parcelado';
      case TransactionFrequencyEnum.oneTime:
        return 'Único';
    }
  }

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}';
  }
}
