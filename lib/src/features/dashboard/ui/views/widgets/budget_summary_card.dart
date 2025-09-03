import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/currency_provider.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';

class BudgetSummaryCard extends ConsumerWidget {
  const BudgetSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Inicializar dashboard quando usuário estiver autenticado
    ref.watch(dashboardInitializerProvider);

    final dashboardState = ref.watch(dashboardViewModelProvider);

    // Verificar se há necessidade de recarregar dados
    final authState = ref.watch(authViewModelProvider);
    if (authState is AuthenticatedState &&
        dashboardState is DashboardLoadedState &&
        dashboardState.budgetSummary == null) {
      // Se há usuário autenticado mas budgetSummary é null, mostrar loading ao invés de "nenhum dado"
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Escutar mudanças no período e recarregar dados
    ref.listen<DateTime>(selectedPeriodProvider, (previous, next) {
      if (previous != next) {
        ref.read(dashboardViewModelProvider.notifier).loadDashboardData(next);
      }
    });

    if (dashboardState is DashboardLoadingState) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    if (dashboardState is DashboardErrorState) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: context.colorScheme.error,
                size: 48,
              ),
              const SizedBox(height: Spacing.md),
              Text(
                'Erro ao carregar dados',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                dashboardState.exception.getMessage(context),
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Se não é DashboardLoadedState, mostrar loading (exceto se for erro)
    if (dashboardState is! DashboardLoadedState) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(Spacing.lg),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }

    // Se é DashboardLoadedState mas budgetSummary é null, pode ser estado inconsistente
    if (dashboardState.budgetSummary == null) {
      // Se há usuário autenticado, mostrar loading pois dados deveriam existir
      if (authState is AuthenticatedState) {
        return const Card(
          child: Padding(
            padding: EdgeInsets.all(Spacing.lg),
            child: Center(child: CircularProgressIndicator()),
          ),
        );
      }

      // Se não há usuário autenticado, mostrar mensagem de dados vazios
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Column(
            children: [
              Icon(
                Icons.account_balance_wallet_outlined,
                color: context.colorScheme.onSurface.withOpacity(0.3),
                size: 48,
              ),
              const SizedBox(height: Spacing.md),
              Text(
                'Nenhum dado encontrado',
                style: context.textTheme.titleMedium,
              ),
              const SizedBox(height: Spacing.xs),
              Text(
                'Adicione transações para ver o resumo',
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final budget = dashboardState.budgetSummary!;
    final actualBalance = budget.actualBalance;
    final balanceDifference = budget.balanceDifference;

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
                        _formatCurrency(actualBalance, ref),
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
                            _formatCurrency(balanceDifference.abs(), ref),
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
                    budget.actualIncome,
                    budget.plannedIncome,
                    Icons.arrow_downward,
                    Colors.green,
                    ref,
                  ),
                ),
                const SizedBox(width: Spacing.md),
                Expanded(
                  child: _buildSummaryItem(
                    context,
                    'Despesas',
                    budget.actualExpenses,
                    budget.plannedExpenses,
                    Icons.arrow_upward,
                    Colors.red,
                    ref,
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
    WidgetRef ref,
  ) {
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
            _formatCurrency(actual, ref),
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double value, WidgetRef ref) {
    final currency = ref.watch(currencyProvider);
    return CurrencyFormatter.format(value, currency);
  }
}
