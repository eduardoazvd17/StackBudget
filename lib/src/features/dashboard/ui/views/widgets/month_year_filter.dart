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
                  onPressed:
                      _canNavigateToPrevious(ref)
                          ? () => _previousMonth(ref)
                          : null,
                  icon: const Icon(Icons.chevron_left),
                  tooltip: 'Mês anterior',
                ),
                IconButton(
                  onPressed:
                      _canNavigateToNext(ref) ? () => _nextMonth(ref) : null,
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
    final userRegistrationDate = ref.read(userRegistrationDateProvider);

    final previousMonth = DateTime(currentDate.year, currentDate.month - 1, 1);

    // Verifica se o mês anterior não é menor que janeiro do ano de cadastro
    final firstAllowedDate =
        userRegistrationDate != null
            ? DateTime(userRegistrationDate.year, 1, 1)
            : DateTime(2020);

    if (!previousMonth.isBefore(firstAllowedDate)) {
      ref.read(selectedPeriodProvider.notifier).state = previousMonth;
    }
  }

  void _nextMonth(WidgetRef ref) {
    final currentDate = ref.read(selectedPeriodProvider);
    final nextMonth = DateTime(currentDate.year, currentDate.month + 1, 1);

    // Verifica se o próximo mês não é maior que dezembro do ano atual
    final now = DateTime.now();
    final lastAllowedDate = DateTime(now.year, 12, 1);

    if (!nextMonth.isAfter(lastAllowedDate)) {
      ref.read(selectedPeriodProvider.notifier).state = nextMonth;
    }
  }

  Future<void> _showDatePicker(BuildContext context, WidgetRef ref) async {
    final currentDate = ref.read(selectedPeriodProvider);
    final userRegistrationDate = ref.read(userRegistrationDateProvider);

    // Define a data mínima como janeiro do ano de cadastro do usuário, ou 2020 como fallback
    final firstDate =
        userRegistrationDate != null
            ? DateTime(userRegistrationDate.year, 1, 1)
            : DateTime(2020);

    // Define a data máxima como dezembro do ano atual
    final now = DateTime.now();
    final lastDate = DateTime(now.year, 12, 1);

    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate != null) {
      ref.read(selectedPeriodProvider.notifier).state = selectedDate;
    }
  }

  bool _canNavigateToPrevious(WidgetRef ref) {
    final currentDate = ref.read(selectedPeriodProvider);
    final userRegistrationDate = ref.read(userRegistrationDateProvider);

    final previousMonth = DateTime(currentDate.year, currentDate.month - 1, 1);
    final firstAllowedDate =
        userRegistrationDate != null
            ? DateTime(userRegistrationDate.year, 1, 1)
            : DateTime(2020);

    return !previousMonth.isBefore(firstAllowedDate);
  }

  bool _canNavigateToNext(WidgetRef ref) {
    final currentDate = ref.read(selectedPeriodProvider);
    final nextMonth = DateTime(currentDate.year, currentDate.month + 1, 1);

    final now = DateTime.now();
    final lastAllowedDate = DateTime(now.year, 12, 1);

    return !nextMonth.isAfter(lastAllowedDate);
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
