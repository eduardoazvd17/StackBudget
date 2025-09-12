import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/transactions_list.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

class ExpandableTransactionsSection extends ConsumerStatefulWidget {
  final String title;
  final IconData icon;
  final TransactionFrequencyEnum filterType;
  final String preferenceKey;
  final Future<void> Function(bool) onExpansionChanged;

  const ExpandableTransactionsSection({
    super.key,
    required this.title,
    required this.icon,
    required this.filterType,
    required this.preferenceKey,
    required this.onExpansionChanged,
  });

  @override
  ConsumerState<ExpandableTransactionsSection> createState() =>
      _ExpandableTransactionsSectionState();
}

class _ExpandableTransactionsSectionState
    extends ConsumerState<ExpandableTransactionsSection> {
  bool? _isExpanded;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    try {
      final service = await ListPreferencesService.getInstance();
      bool expanded;

      switch (widget.preferenceKey) {
        case 'recurring':
          expanded = await service.getRecurringTransactionsExpanded();
          break;
        case 'installment':
          expanded = await service.getInstallmentTransactionsExpanded();
          break;
        case 'oneTime':
          expanded = await service.getOneTimeTransactionsExpanded();
          break;
        default:
          expanded = true;
      }

      if (mounted) {
        setState(() {
          _isExpanded = expanded;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isExpanded = true; // Padrão expandido em caso de erro
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardViewModelProvider);

    if (dashboardState is! DashboardLoadedState || _isLoading) {
      return const SizedBox.shrink();
    }

    final isExpanded = _isExpanded ?? true;

    List<TransactionModel> filteredTransactions;

    switch (widget.filterType) {
      case TransactionFrequencyEnum.monthly:
      case TransactionFrequencyEnum.yearly:
        filteredTransactions =
            dashboardState.transactions
                .where(
                  (t) =>
                      t.frequency == TransactionFrequencyEnum.monthly ||
                      t.frequency == TransactionFrequencyEnum.yearly,
                )
                .toList();
        break;
      case TransactionFrequencyEnum.installment:
        filteredTransactions =
            dashboardState.transactions
                .where(
                  (t) => t.frequency == TransactionFrequencyEnum.installment,
                )
                .toList();
        break;
      case TransactionFrequencyEnum.oneTime:
        filteredTransactions =
            dashboardState.transactions
                .where((t) => t.frequency == TransactionFrequencyEnum.oneTime)
                .toList()
              ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
      child: Column(
        children: [
          InkWell(
            onTap: () async {
              final newExpanded = !isExpanded;
              setState(() {
                _isExpanded = newExpanded;
              });
              await widget.onExpansionChanged(newExpanded);
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Spacing.sm,
                horizontal: Spacing.xs,
              ),
              child: Row(
                children: [
                  Icon(
                    widget.icon,
                    size: 20,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '(${filteredTransactions.length})',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withValues(
                        alpha: 0.6,
                      ),
                    ),
                  ),
                  const SizedBox(width: Spacing.xs),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),

          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.topLeft, // Alinhar ao topo à esquerda
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            firstChild: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Alinhar conteúdo à esquerda
              children: [
                const SizedBox(height: Spacing.sm),
                if (filteredTransactions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Text(
                      'Nenhuma transação encontrada',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  )
                else
                  ...filteredTransactions.map(
                    (transaction) => Padding(
                      padding: const EdgeInsets.only(bottom: Spacing.sm),
                      child: TransactionListItem(
                        transaction: transaction,
                        showAllTypes: true,
                      ),
                    ),
                  ),
              ],
            ),
            secondChild: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
