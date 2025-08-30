import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/dashboard_header.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/month_year_filter.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/budget_summary_card.dart';
import 'package:stackbudget/src/features/dashboard/ui/views/widgets/simple_expandable_section.dart';

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

            // Header geral das transações
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: const Text(
                  'Transações',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            // Lista de transações recorrentes (mensais e anuais)
            const SliverToBoxAdapter(
              child: SimpleExpandableSection(
                title: 'Transações Recorrentes',
                icon: Icons.repeat,
                filterType: TransactionFrequencyEnum.monthly,
                sectionKey: 'recurring',
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            // Lista de parcelas
            const SliverToBoxAdapter(
              child: SimpleExpandableSection(
                title: 'Parcelas',
                icon: Icons.payment,
                filterType: TransactionFrequencyEnum.installment,
                sectionKey: 'installment',
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            // Lista de transações únicas
            const SliverToBoxAdapter(
              child: SimpleExpandableSection(
                title: 'Transações do Mês',
                icon: Icons.receipt,
                filterType: TransactionFrequencyEnum.oneTime,
                sectionKey: 'oneTime',
              ),
            ),

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
