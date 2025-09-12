import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/core/constants/app_constants.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/monthly_transaction_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/monthly_transaction_view_model_state.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/currency_provider.dart';

class MonthlyValueEditorDialog extends ConsumerStatefulWidget {
  final TransactionModel transaction;
  final int year;
  final int month;

  const MonthlyValueEditorDialog({
    super.key,
    required this.transaction,
    required this.year,
    required this.month,
  });

  @override
  ConsumerState<MonthlyValueEditorDialog> createState() =>
      _MonthlyValueEditorDialogState();
}

class _MonthlyValueEditorDialogState
    extends ConsumerState<MonthlyValueEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _populateAmount(widget.transaction.amount, ref);
      ref
          .read(monthlyTransactionViewModelProvider.notifier)
          .loadMonthlyTransaction(
            transactionId: widget.transaction.id,
            year: widget.year,
            month: widget.month,
          );
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _populateAmount(double amount, WidgetRef ref) {
    final currency = ref.read(currencyProvider);
    final formattedAmount = CurrencyFormatter.format(amount, currency);
    _amountController.text = formattedAmount;
  }

  @override
  Widget build(BuildContext context) {
    final monthlyState = ref.watch(monthlyTransactionViewModelProvider);

    ref.listen<MonthlyTransactionViewModelState>(
      monthlyTransactionViewModelProvider,
      (previous, next) {
        if (next is MonthlyTransactionLoadedState) {
          if (next.currentValue != widget.transaction.amount) {
            _populateAmount(next.currentValue, ref);
          }
        } else if (next is MonthlyTransactionSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop(true); // Indica que houve mudança
        } else if (next is MonthlyTransactionErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.exception.getMessage(context)),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }

        setState(() {
          _isLoading = next is MonthlyTransactionLoadingState;
        });
      },
    );

    final hasOverride =
        monthlyState is MonthlyTransactionLoadedState &&
        monthlyState.hasOverride;

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.strings.adjustValue(
              MonthEnum.getNameByNumber(widget.month, context),
              widget.year.toString(),
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            widget.transaction.title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(Spacing.sm),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: Spacing.xs),
                  Text(
                    '${context.strings.defaultAmount}: ${ref.formatCurrency(widget.transaction.amount)}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.md),

            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: context.strings.valueForThisMonth,
                hintText: CurrencyFormatter.format(
                  0,
                  ref.watch(currencyProvider),
                ),
                prefixIcon: const Icon(Icons.attach_money),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.restore),
                  tooltip: context.strings.restoreDefaultValue,
                  onPressed: () {
                    _populateAmount(widget.transaction.amount, ref);
                  },
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(currency: ref.watch(currencyProvider)),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.strings.amountRequired;
                }
                final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
                if (digitsOnly.isEmpty) {
                  return context.strings.amountRequired;
                }
                final numValue =
                    double.parse(digitsOnly) / AppConstants.centsToRealDivider;
                if (numValue <= 0) {
                  return context.strings.amountMustBePositive;
                }
                return null;
              },
              enabled: !_isLoading,
            ),

            if (hasOverride) ...[
              const SizedBox(height: Spacing.sm),
              Row(
                children: [
                  Icon(Icons.edit, size: 14, color: Colors.orange),
                  const SizedBox(width: Spacing.xs),
                  Text(
                    context.strings.customAmountThisMonth,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      actions: [
        if (hasOverride)
          TextButton(
            onPressed:
                _isLoading
                    ? null
                    : () {
                      ref
                          .read(monthlyTransactionViewModelProvider.notifier)
                          .removeMonthlyOverride();
                    },
            child: Text(context.strings.removeAdjustment),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(context.strings.cancel),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveValue,
          child:
              _isLoading
                  ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : Text(context.strings.save),
        ),
      ],
    );
  }

  void _saveValue() {
    if (!_formKey.currentState!.validate()) return;

    final digitsOnly = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    final amount =
        digitsOnly.isEmpty
            ? 0.0
            : double.parse(digitsOnly) / AppConstants.centsToRealDivider;

    ref
        .read(monthlyTransactionViewModelProvider.notifier)
        .updateMonthlyValue(
          transactionId: widget.transaction.id,
          year: widget.year,
          month: widget.month,
          newAmount: amount,
        );
  }
}

Future<bool?> showMonthlyValueEditor(
  BuildContext context, {
  required TransactionModel transaction,
  required int year,
  required int month,
}) {
  return showDialog<bool>(
    context: context,
    builder:
        (context) => MonthlyValueEditorDialog(
          transaction: transaction,
          year: year,
          month: month,
        ),
  );
}
