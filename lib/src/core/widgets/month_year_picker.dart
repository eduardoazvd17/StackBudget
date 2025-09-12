import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/core/constants/app_constants.dart';

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
      title: Text(context.strings.selectPeriod),
      content: SizedBox(
        width: 300,
        height: 300,
        child: Column(
          children: [
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
                                : context.colorScheme.surface.withValues(
                                  alpha: 0.3,
                                ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              isSelected
                                  ? context.colorScheme.primary
                                  : context.colorScheme.outline.withValues(
                                    alpha: 0.3,
                                  ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          MonthEnum.getAbbreviationByNumber(month, context),
                          style: context.textTheme.bodyMedium?.copyWith(
                            color:
                                isSelected
                                    ? context.colorScheme.onPrimary
                                    : isEnabled
                                    ? context.colorScheme.onSurface
                                    : context.colorScheme.onSurface.withValues(
                                      alpha: 0.4,
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
          child: Text(context.strings.cancel),
        ),
        FilledButton(
          onPressed: () {
            final selectedDate = DateTime(selectedYear, selectedMonth, 1);
            widget.onDateSelected(selectedDate);
            Navigator.of(context).pop();
          },
          child: Text(context.strings.confirm),
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
}

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
          firstDate: firstDate ?? DateTime(AppConstants.minYear),
          lastDate:
              lastDate ??
              DateTime(
                DateTime.now().year.toInt() + AppConstants.futureYearsLimit,
                12,
                1,
              ),
          onDateSelected: (date) => selectedDate = date,
        ),
  );

  return selectedDate;
}
