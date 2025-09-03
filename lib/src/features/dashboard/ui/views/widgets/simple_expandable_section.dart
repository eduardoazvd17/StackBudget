import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/expansion_state_provider.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/transactions_list.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';

class SimpleExpandableSection extends ConsumerWidget {
  final String title;
  final IconData icon;
  final TransactionFrequencyEnum filterType;
  final String sectionKey;

  const SimpleExpandableSection({
    super.key,
    required this.title,
    required this.icon,
    required this.filterType,
    required this.sectionKey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final expansionState = ref.watch(expansionStateProvider);

    // Se estiver carregando, mostrar indicador de loading
    if (dashboardState is DashboardLoadingState) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: Spacing.lg),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Row(
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: Spacing.sm),
              Text(
                title,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ],
          ),
        ),
      );
    }

    if (dashboardState is! DashboardLoadedState || expansionState == null) {
      return const SizedBox.shrink();
    }

    // Obter estado de expansão baseado na seção
    bool isExpanded;
    switch (sectionKey) {
      case 'recurring':
        isExpanded = expansionState.recurringExpanded;
        break;
      case 'installment':
        isExpanded = expansionState.installmentExpanded;
        break;
      case 'oneTime':
        isExpanded = expansionState.oneTimeExpanded;
        break;
      default:
        isExpanded = true;
    }

    // Filtrar transações baseado no tipo
    List<TransactionModel> filteredTransactions;

    switch (filterType) {
      case TransactionFrequencyEnum.monthly:
      case TransactionFrequencyEnum.yearly:
        // Gastos recorrentes (mensais e anuais)
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
        // Parcelas
        filteredTransactions =
            dashboardState.transactions
                .where(
                  (t) => t.frequency == TransactionFrequencyEnum.installment,
                )
                .toList();
        break;
      case TransactionFrequencyEnum.oneTime:
        // Transações únicas (ordenadas da mais recente para mais antiga)
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
          // Header da seção
          InkWell(
            onTap: () async {
              final notifier = ref.read(expansionStateProvider.notifier);
              final newExpanded = !isExpanded;

              switch (sectionKey) {
                case 'recurring':
                  await notifier.setRecurringExpanded(newExpanded);
                  break;
                case 'installment':
                  await notifier.setInstallmentExpanded(newExpanded);
                  break;
                case 'oneTime':
                  await notifier.setOneTimeExpanded(newExpanded);
                  break;
              }
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
                    icon,
                    size: 20,
                    color: context.colorScheme.onSurface.withOpacity(0.7),
                  ),
                  const SizedBox(width: Spacing.sm),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '(${filteredTransactions.length})',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.6),
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

          // Lista de transações (expansível)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            alignment: Alignment.topLeft,
            crossFadeState:
                isExpanded
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
            firstChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: Spacing.sm),
                if (filteredTransactions.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(Spacing.lg),
                    child: Text(
                      'Nenhuma transação encontrada',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurface.withOpacity(0.5),
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
