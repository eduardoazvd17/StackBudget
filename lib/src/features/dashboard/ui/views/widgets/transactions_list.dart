import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/core/enums/category_enum.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

class TransactionsList extends ConsumerWidget {
  final bool onlyOneTimeTransactions;

  const TransactionsList({
    super.key,
    this.onlyOneTimeTransactions =
        true, // Por padrão, mostrar apenas transações únicas
  });

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
                context.strings.errorLoadingTransactions,
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                dashboardState.exception.getMessage(context),
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

    var transactions = dashboardState.transactions;

    if (onlyOneTimeTransactions) {
      transactions =
          transactions
              .where(
                (transaction) =>
                    transaction.frequency == TransactionFrequencyEnum.oneTime,
              )
              .toList()
            ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    if (transactions.isEmpty) {
      return SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(Spacing.xl),
          child: Column(
            children: [
              Icon(
                Icons.receipt_long_outlined,
                size: 64,
                color: context.colorScheme.onSurface.withValues(alpha: 0.3),
              ),
              const SizedBox(height: Spacing.md),
              Text(
                context.strings.noTransactionsFound,
                style: context.textTheme.titleMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                context.strings.addFirstTransaction,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
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
          child: TransactionListItem(
            transaction: transaction,
            showAllTypes: !onlyOneTimeTransactions,
          ),
        );
      }, childCount: transactions.length),
    );
  }
}

class TransactionListItem extends ConsumerWidget {
  final TransactionModel transaction;
  final bool showAllTypes;

  const TransactionListItem({
    super.key,
    required this.transaction,
    this.showAllTypes = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isIncome = transaction.type == TransactionTypeEnum.income;
    final defaultColor = isIncome ? Colors.green : Colors.red;

    Color iconColor = defaultColor;
    Color backgroundColor = defaultColor.withValues(alpha: 0.1);

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
            color: backgroundColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(_getTransactionIcon(transaction), color: iconColor),
        ),

        title: Text(
          transaction.title,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        subtitle: Row(
          children: [
            Text(
              _getSubtitleText(context, transaction),
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.5),
              ),
            ),
            if (transaction.frequency == TransactionFrequencyEnum.installment &&
                transaction.totalInstallments != null) ...[
              const SizedBox(width: Spacing.xs),
              Text(
                '${_getCurrentInstallmentNumber(ref, transaction)}/${transaction.totalInstallments}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
            if (_hasMonthlyAdjustment(ref, transaction)) ...[
              const SizedBox(width: Spacing.xs),
              Icon(Icons.tune, size: 14, color: Colors.orange),
              const SizedBox(width: 2),
              Text(
                context.strings.adjusted,
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${isIncome ? '+' : '-'} ${ref.formatCurrency(_getCurrentMonthValue(ref, transaction))}',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: defaultColor,
              ),
            ),
          ],
        ),

        onTap: () => AppRoutes.goToTransactionDetail(context, transaction),
      ),
    );
  }

  IconData _getTransactionIcon(TransactionModel transaction) {
    if (transaction.category != null) {
      return _getIconFromString(transaction.category!.iconName);
    }

    if (transaction.type == TransactionTypeEnum.income) {
      return Icons.arrow_downward; // Seta para baixo (entrada)
    } else {
      return Icons.arrow_upward; // Seta para cima (saída)
    }
  }

  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'laptop':
        return Icons.laptop;
      case 'trending_up':
        return Icons.trending_up;
      case 'star':
        return Icons.star;
      case 'card_giftcard':
        return Icons.card_giftcard;
      case 'attach_money':
        return Icons.attach_money;
      case 'home':
        return Icons.home;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'local_grocery_store':
        return Icons.local_grocery_store;
      case 'directions_car':
        return Icons.directions_car;
      case 'security':
        return Icons.security;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'restaurant':
        return Icons.restaurant;
      case 'movie':
        return Icons.movie;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'flight':
        return Icons.flight;
      case 'palette':
        return Icons.palette;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'face':
        return Icons.face;
      case 'account_balance':
        return Icons.account_balance;
      case 'credit_card':
        return Icons.credit_card;
      case 'receipt':
        return Icons.receipt;
      case 'money_off':
        return Icons.money_off;
      case 'school':
        return Icons.school;
      case 'menu_book':
        return Icons.menu_book;
      case 'play_lesson':
        return Icons.play_lesson;
      case 'child_care':
        return Icons.child_care;
      case 'pets':
        return Icons.pets;
      case 'redeem':
        return Icons.redeem;
      case 'volunteer_activism':
        return Icons.volunteer_activism;
      case 'savings':
        return Icons.savings;
      case 'category':
      default:
        return Icons.category;
    }
  }

  String _getSubtitleText(BuildContext context, TransactionModel transaction) {
    // Se a transação tem categoria, mostra a categoria
    if (transaction.category != null) {
      final CategoryEnum category = transaction.category!;
      return category.getDisplayName(context);
    }

    // Caso contrário, mostra a frequência
    return _getFrequencyText(context, transaction.frequency);
  }

  String _getFrequencyText(
    BuildContext context,
    TransactionFrequencyEnum frequency,
  ) {
    switch (frequency) {
      case TransactionFrequencyEnum.monthly:
        return context.strings.frequencyMonthly;
      case TransactionFrequencyEnum.customMonthly:
        return context.strings.frequencyCustomMonthly;
      case TransactionFrequencyEnum.yearly:
        return context.strings.frequencyYearly;
      case TransactionFrequencyEnum.installment:
        return context.strings.frequencyInstallment;
      case TransactionFrequencyEnum.oneTime:
        return context.strings.frequencyOneTime;
    }
  }

  int _getCurrentInstallmentNumber(
    WidgetRef ref,
    TransactionModel transaction,
  ) {
    if (transaction.startDate == null ||
        transaction.totalInstallments == null) {
      return 1;
    }

    final selectedPeriod = ref.read(selectedPeriodProvider);
    final startDate = transaction.startDate!;

    final monthsDifference =
        ((selectedPeriod.year - startDate.year) * 12) +
        (selectedPeriod.month - startDate.month);

    final installmentNumber = monthsDifference + 1;

    return installmentNumber.clamp(1, transaction.totalInstallments!);
  }

  bool _hasMonthlyAdjustment(WidgetRef ref, TransactionModel transaction) {
    if (transaction.frequency != TransactionFrequencyEnum.monthly) {
      return false;
    }

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
    final dashboardState = ref.read(dashboardViewModelProvider);
    final selectedPeriod = ref.read(selectedPeriodProvider);

    double defaultAmount = transaction.amount;

    if (transaction.frequency == TransactionFrequencyEnum.installment &&
        transaction.totalInstallments != null &&
        transaction.totalInstallments! > 0) {
      defaultAmount = transaction.amount / transaction.totalInstallments!;
    }

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

      return monthlyOverride?.amount ?? defaultAmount;
    }

    return defaultAmount;
  }
}
