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
                  final isSelected =
                      selectedMonth != -1 && month == selectedMonth;
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

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder:
        (context) => MonthYearPickerBottomSheet(
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

Future<MonthEnum?> showMonthPicker({
  required BuildContext context,
  required MonthEnum initialMonth,
}) async {
  MonthEnum? selectedMonth;

  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder:
        (context) => MonthPickerBottomSheet(
          initialMonth: initialMonth,
          onMonthSelected: (month) => selectedMonth = month,
        ),
  );

  return selectedMonth;
}

class MonthPickerBottomSheet extends StatefulWidget {
  final MonthEnum initialMonth;
  final void Function(MonthEnum selectedMonth) onMonthSelected;

  const MonthPickerBottomSheet({
    super.key,
    required this.initialMonth,
    required this.onMonthSelected,
  });

  @override
  State<MonthPickerBottomSheet> createState() => _MonthPickerBottomSheetState();
}

class _MonthPickerBottomSheetState extends State<MonthPickerBottomSheet> {
  late MonthEnum selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                context.strings.selectMonth,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Month grid
          SizedBox(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2.5,
                crossAxisSpacing: Spacing.sm,
                mainAxisSpacing: Spacing.sm,
              ),
              itemCount: 12,
              itemBuilder: (context, index) {
                final month = MonthEnum.values[index];

                return InkWell(
                  onTap: () {
                    widget.onMonthSelected(month);
                    Navigator.of(context).pop();
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          selectedMonth == month
                              ? context.colorScheme.primary
                              : context.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color:
                            selectedMonth == month
                                ? context.colorScheme.primary
                                : context.colorScheme.outline.withValues(
                                  alpha: 0.3,
                                ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        month.getDisplayName(context),
                        style: context.textTheme.bodyMedium?.copyWith(
                          color:
                              selectedMonth == month
                                  ? context.colorScheme.onPrimary
                                  : context.colorScheme.onSurface,
                          fontWeight:
                              selectedMonth == month ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class MonthYearPickerBottomSheet extends StatefulWidget {
  final DateTime initialDate;
  final DateTime firstDate;
  final DateTime lastDate;
  final void Function(DateTime selectedDate) onDateSelected;

  const MonthYearPickerBottomSheet({
    super.key,
    required this.initialDate,
    required this.firstDate,
    required this.lastDate,
    required this.onDateSelected,
  });

  @override
  State<MonthYearPickerBottomSheet> createState() =>
      _MonthYearPickerBottomSheetState();
}

class _MonthYearPickerBottomSheetState
    extends State<MonthYearPickerBottomSheet> {
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
    // Get current month and year dynamically
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerLow,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                context.strings.selectPeriod,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Year selector
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed:
                    selectedYear > widget.firstDate.year
                        ? () => setState(() {
                          selectedYear--;
                          selectedMonth =
                              -1; // Reset selection when year changes
                        })
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
                        ? () => setState(() {
                          selectedYear++;
                          selectedMonth =
                              -1; // Reset selection when year changes
                        })
                        : null,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),

          const SizedBox(height: Spacing.lg),

          // Month grid
          SizedBox(
            height: 250,
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
                final isCurrentMonth =
                    month == currentMonth && selectedYear == currentYear;
                final isEnabled = _isMonthEnabled(month);

                return InkWell(
                  onTap:
                      isEnabled
                          ? () {
                            final selectedDate = DateTime(
                              selectedYear,
                              month,
                              1,
                            );
                            widget.onDateSelected(selectedDate);
                            Navigator.of(context).pop();
                          }
                          : null,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? context.colorScheme.primary
                              : isCurrentMonth && isEnabled
                              ? context.colorScheme.primaryContainer.withValues(
                                alpha: 0.6,
                              )
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
                                : isCurrentMonth && isEnabled
                                ? context.colorScheme.primary.withValues(
                                  alpha: 0.7,
                                )
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
                                  : isCurrentMonth && isEnabled
                                  ? context.colorScheme.primary
                                  : isEnabled
                                  ? context.colorScheme.onSurface
                                  : context.colorScheme.onSurface.withValues(
                                    alpha: 0.4,
                                  ),
                          fontWeight:
                              isSelected
                                  ? FontWeight.bold
                                  : isCurrentMonth && isEnabled
                                  ? FontWeight.w600
                                  : null,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 24),
        ],
      ),
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
