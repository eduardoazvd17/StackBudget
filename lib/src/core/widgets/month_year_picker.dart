import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

class MonthYearPicker extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime selectedDate) onDateSelected;

  const MonthYearPicker({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  State<MonthYearPicker> createState() => _MonthYearPickerState();
}

class _MonthYearPickerState extends State<MonthYearPicker> {
  late int selectedYear;
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
    selectedMonth = widget.initialDate.month;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Selecionar Período'),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
            // Seletor de Ano
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed:
                      selectedYear > widget.firstDate.year
                          ? () => setState(() => selectedYear--)
                          : null,
                  icon: const Icon(Icons.chevron_left),
                ),
                Text(
                  selectedYear.toString(),
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed:
                      selectedYear < widget.lastDate.year
                          ? () => setState(() => selectedYear++)
                          : null,
                  icon: const Icon(Icons.chevron_right),
                ),
              ],
            ),

            const SizedBox(height: Spacing.lg),

            // Grid de Meses
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: Spacing.sm,
                  mainAxisSpacing: Spacing.sm,
                ),
                itemCount: 12,
                itemBuilder: (context, index) {
                  final month = index + 1;
                  final isSelected = month == selectedMonth;
                  final isEnabled = _isMonthEnabled(month);

                  return InkWell(
                    onTap:
                        isEnabled
                            ? () => setState(() => selectedMonth = month)
                            : null,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? context.colorScheme.primary
                                : isEnabled
                                ? context.colorScheme.surface
                                : context.colorScheme.surface.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              isSelected
                                  ? context.colorScheme.primary
                                  : context.colorScheme.outline.withOpacity(
                                    0.3,
                                  ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          _getMonthAbbreviation(month),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color:
                                isSelected
                                    ? context.colorScheme.onPrimary
                                    : isEnabled
                                    ? context.colorScheme.onSurface
                                    : context.colorScheme.onSurface.withOpacity(
                                      0.4,
                                    ),
                            fontWeight: isSelected ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: () {
            final selectedDate = DateTime(selectedYear, selectedMonth, 1);
            widget.onDateSelected(selectedDate);
            Navigator.of(context).pop();
          },
          child: const Text('Confirmar'),
        ),
      ],
    );
  }

  bool _isMonthEnabled(int month) {
    final date = DateTime(selectedYear, month, 1);
    final firstAllowed = DateTime(
      widget.firstDate.year,
      widget.firstDate.month,
      1,
    );
    final lastAllowed = DateTime(
      widget.lastDate.year,
      widget.lastDate.month,
      1,
    );

    return !date.isBefore(firstAllowed) && !date.isAfter(lastAllowed);
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];
    return months[month - 1];
  }
}

/// Função utilitária para mostrar o seletor de mês/ano
Future<DateTime?> showMonthYearPicker({
  required BuildContext context,
  required DateTime initialDate,
  DateTime? firstDate,
  DateTime? lastDate,
}) async {
  DateTime? selectedDate;

  await showDialog<void>(
    context: context,
    builder:
        (context) => MonthYearPicker(
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2020),
          lastDate: lastDate ?? DateTime(DateTime.now().year + 2, 12, 1),
          onDateSelected: (date) => selectedDate = date,
        ),
  );

  return selectedDate;
}
