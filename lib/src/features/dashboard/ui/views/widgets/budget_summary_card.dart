import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';

class BudgetSummaryCard extends ConsumerWidget {
  const BudgetSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Buscar dados reais do orçamento baseado na data selecionada
    // final selectedDate = ref.watch(selectedDateProvider);
    // Por enquanto, usando dados mock
    const plannedIncome = 5000.0;
    const actualIncome = 4800.0;
    const plannedExpenses = 3500.0;
    const actualExpenses = 2800.0;

    final plannedBalance = plannedIncome - plannedExpenses;
    final actualBalance = actualIncome - actualExpenses;
    final balanceDifference = actualBalance - plannedBalance;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumo do Orçamento',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: Spacing.md),

            // Saldo principal
            Container(
              padding: const EdgeInsets.all(Spacing.md),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saldo Atual',
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatCurrency(actualBalance),
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.onPrimaryContainer,
                        ),
                      ),
                    ],
                  ),

                  // Indicador de diferença
                  if (balanceDifference != 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Spacing.sm,
                        vertical: Spacing.xs,
                      ),
                      decoration: BoxDecoration(
                        color:
                            balanceDifference > 0
                                ? Colors.green.withOpacity(0.2)
                                : Colors.red.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            balanceDifference > 0
                                ? Icons.trending_up
                                : Icons.trending_down,
                            size: 16,
                            color:
                                balanceDifference > 0
                                    ? Colors.green
                                    : Colors.red,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            _formatCurrency(balanceDifference.abs()),
                            style: context.textTheme.bodySmall?.copyWith(
                              color:
                                  balanceDifference > 0
                                      ? Colors.green
                                      : Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: Spacing.md),

            // Receitas e despesas
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'Receitas',
                    actualIncome,
                    plannedIncome,
                    Icons.arrow_downward,
                    Colors.green,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'Despesas',
                    actualExpenses,
                    plannedExpenses,
                    Icons.arrow_upward,
                    Colors.red,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context,
    String title,
    double actual,
    double planned,
    IconData icon,
    Color color,
  ) {
    final percentage = planned > 0 ? (actual / planned) * 100 : 0.0;

    return Container(
      padding: const EdgeInsets.all(Spacing.md),
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.outline.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: Spacing.xs),
              Text(
                title,
                style: context.textTheme.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            _formatCurrency(actual),
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'de ${_formatCurrency(planned)} (${percentage.toStringAsFixed(0)}%)',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
