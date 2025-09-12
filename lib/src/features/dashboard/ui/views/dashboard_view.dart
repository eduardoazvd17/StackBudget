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
            const SliverToBoxAdapter(child: DashboardHeader()),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: MonthYearFilter(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: BudgetSummaryCard(),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.lg)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Spacing.lg),
                child: Text(
                  context.strings.dashboardTransactions,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            SliverToBoxAdapter(
              child: SimpleExpandableSection(
                title: context.strings.recurringTransactions,
                icon: Icons.repeat,
                filterType: TransactionFrequencyEnum.monthly,
                sectionKey: 'recurring',
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            SliverToBoxAdapter(
              child: SimpleExpandableSection(
                title: context.strings.installments,
                icon: Icons.payment,
                filterType: TransactionFrequencyEnum.installment,
                sectionKey: 'installment',
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: Spacing.md)),

            SliverToBoxAdapter(
              child: SimpleExpandableSection(
                title: context.strings.monthlyTransactions,
                icon: Icons.receipt,
                filterType: TransactionFrequencyEnum.oneTime,
                sectionKey: 'oneTime',
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => AppRoutes.goToAddTransaction(context),
        icon: const Icon(Icons.add),
        label: Text(context.strings.newTransaction),
      ),
    );
  }
}
