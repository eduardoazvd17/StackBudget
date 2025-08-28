import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/dashboard_header.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/month_year_filter.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/budget_summary_card.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/transactions_list.dart';

class DashboardView extends ConsumerWidget {
  static const routeName = 'dashboard';
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header com saudação e logout
            const SliverToBoxAdapter(child: DashboardHeader()),

            // Filtro de mês/ano
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: MonthYearFilter(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            // Resumo do orçamento (saldo, receitas, despesas)
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: BudgetSummaryCard(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.lg)),

            // Lista de transações do mês
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: Text(
                  'Transações do Mês',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            // Lista das transações
            const TransactionsList(),

            // Espaço para o FAB
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),

      // Botão flutuante para adicionar transação
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AppRoutes.goToAddTransaction(context),
        icon: const Icon(Icons.add),
        label: const Text('Nova Transação'),
      ),
    );
  }
}
