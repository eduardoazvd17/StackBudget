import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';

class MonthYearFilter extends ConsumerWidget {
  const MonthYearFilter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedPeriodProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.md),
        child: Row(
          children: [
            Icon(Icons.calendar_month, color: context.colorScheme.primary),
            const SizedBox(width: Spacing.sm),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Período',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _formatMonthYear(selectedDate),
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            // Botões de navegação
            Row(
              children: [
                IconButton(
                  onPressed: () => _previousMonth(ref),
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Mês anterior',
                ),
                IconButton(
                  onPressed: () => _nextMonth(ref),
                  icon: const Icon(Icons.chevron_right),
                  tooltip: 'Próximo mês',
                ),
                IconButton(
                  onPressed: () => _showDatePicker(context, ref),
                  icon: const Icon(Icons.date_range),
                  tooltip: 'Selecionar data',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _previousMonth(WidgetRef ref) {
    final currentDate = ref.read(selectedPeriodProvider);
    final previousMonth = DateTime(currentDate.year, currentDate.month - 1, 1);
    ref.read(selectedPeriodProvider.notifier).state = previousMonth;
  }

  void _nextMonth(WidgetRef ref) {
    final currentDate = ref.read(selectedPeriodProvider);
    final nextMonth = DateTime(currentDate.year, currentDate.month + 1, 1);
    ref.read(selectedPeriodProvider.notifier).state = nextMonth;
  }

  Future<void> _showDatePicker(BuildContext context, WidgetRef ref) async {
    final currentDate = ref.read(selectedPeriodProvider);

    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (selectedDate != null) {
      ref.read(selectedPeriodProvider.notifier).state = selectedDate;
    }
  }

  String _formatMonthYear(DateTime date) {
    const months = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
