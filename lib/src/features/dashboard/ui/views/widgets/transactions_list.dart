import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

class TransactionsList extends ConsumerWidget {
  const TransactionsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);

    if (dashboardState is DashboardLoadingState) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(Spacing.xl),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (dashboardState is DashboardErrorState) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: context.colorScheme.error,
              ),
              const SizedBox(height: Spacing.md),
              Text(
                'Erro ao carregar transações',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                dashboardState.message,
                textAlign: TextAlign.center,
                style: context.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      );
    }

    if (dashboardState is! DashboardLoadedState) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final transactions = dashboardState.transactions;

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
          child: _buildTransactionItem(context, transaction, ref),
        );
      }, childCount: transactions.length),
    );
  }

  Widget _buildTransactionItem(
    BuildContext context,
    TransactionModel transaction,
    WidgetRef ref,
  ) {
    final isIncome = transaction.type == TransactionTypeEnum.income;
    final color = isIncome ? Colors.green : Colors.red;

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
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
                transaction.category!.displayName,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ],
            Row(
              children: [
                Text(
                  _getFrequencyText(transaction.frequency),
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                if (_hasMonthlyAdjustment(ref, transaction)) ...[
                  const SizedBox(width: Spacing.xs),
                  Icon(Icons.tune, size: 14, color: Colors.orange),
                  const SizedBox(width: 2),
                  Text(
                    'Ajustado',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : '-'} ${_formatCurrency(_getCurrentMonthValue(ref, transaction))}',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              _formatDate(transaction.createdAt),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withOpacity(0.5),
              ),
            ),
          ],
        ),

        onTap: () => AppRoutes.goToTransactionDetail(context, transaction),
      ),
    );
  }

  IconData _getTransactionIcon(TransactionModel transaction) {
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

  bool _hasMonthlyAdjustment(WidgetRef ref, TransactionModel transaction) {
    // Só transações mensais dinâmicas podem ter ajustes
    if (transaction.frequency != TransactionFrequencyEnum.monthly ||
        !transaction.isDynamic) {
      return false;
    }

    // Buscar no estado do dashboard se há override para esta transação no período selecionado
    final dashboardState = ref.read(dashboardViewModelProvider);
    final selectedPeriod = ref.read(selectedPeriodProvider);

    if (dashboardState is DashboardLoadedState) {
      return dashboardState.monthlyTransactions.any(
        (mt) =>
            mt.parentTransactionId == transaction.id &&
            mt.year == selectedPeriod.year &&
            mt.month == selectedPeriod.month,
      );
    }

    return false;
  }

  double _getCurrentMonthValue(WidgetRef ref, TransactionModel transaction) {
    // Para transações não dinâmicas, retorna sempre o valor base
    if (transaction.frequency != TransactionFrequencyEnum.monthly ||
        !transaction.isDynamic) {
      return transaction.amount;
    }

    // Buscar override mensal no estado do dashboard para o período selecionado
    final dashboardState = ref.read(dashboardViewModelProvider);
    final selectedPeriod = ref.read(selectedPeriodProvider);

    if (dashboardState is DashboardLoadedState) {
      final monthlyOverride =
          dashboardState.monthlyTransactions
                  .where(
                    (mt) =>
                        mt.parentTransactionId == transaction.id &&
                        mt.year == selectedPeriod.year &&
                        mt.month == selectedPeriod.month,
                  )
                  .isNotEmpty
              ? dashboardState.monthlyTransactions
                  .where(
                    (mt) =>
                        mt.parentTransactionId == transaction.id &&
                        mt.year == selectedPeriod.year &&
                        mt.month == selectedPeriod.month,
                  )
                  .first
              : null;

      return monthlyOverride?.amount ?? transaction.amount;
    }

    return transaction.amount;
  }
}
