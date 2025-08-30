import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/monthly_transaction_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/monthly_transaction_view_model_state.dart';

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
  ConsumerState<MonthlyValueEditorDialog> createState() => _MonthlyValueEditorDialogState();
}

class _MonthlyValueEditorDialogState extends ConsumerState<MonthlyValueEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Inicializar com valor base da transação
    _populateAmount(widget.transaction.amount);
    
    // Carregar dados para verificar se há override
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(monthlyTransactionViewModelProvider.notifier).loadMonthlyTransaction(
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

  String _getMonthName(int month) {
    const months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro',
    ];
    return months[month - 1];
  }

  String _formatCurrency(double value) {
    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 2,
    ).format(value);
  }

  void _populateAmount(double amount) {
    final formattedAmount = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 2,
    ).format(amount);
    _amountController.text = formattedAmount;
  }

  @override
  Widget build(BuildContext context) {
    final monthlyState = ref.watch(monthlyTransactionViewModelProvider);

    ref.listen<MonthlyTransactionViewModelState>(
      monthlyTransactionViewModelProvider,
      (previous, next) {
        if (next is MonthlyTransactionLoadedState) {
          // Só atualizar o campo se o valor for diferente do base
          if (next.currentValue != widget.transaction.amount) {
            _populateAmount(next.currentValue);
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
              content: Text(next.message),
              backgroundColor: context.colorScheme.error,
            ),
          );
        }
        
        // Controlar loading local
        setState(() {
          _isLoading = next is MonthlyTransactionLoadingState;
        });
      },
    );

    final hasOverride = monthlyState is MonthlyTransactionLoadedState && monthlyState.hasOverride;

    return AlertDialog(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(context.strings.adjustValue(_getMonthName(widget.month), widget.year.toString())),
          const SizedBox(height: Spacing.xs),
          Text(
            widget.transaction.title,
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.7),
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
                color: context.colorScheme.surfaceVariant,
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
                    'Valor padrão: ${_formatCurrency(widget.transaction.amount)}',
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
                labelText: 'Valor para este mês',
                hintText: 'R\$ 0,00',
                prefixIcon: const Icon(Icons.attach_money),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.restore),
                  tooltip: 'Restaurar valor padrão',
                  onPressed: () {
                    _populateAmount(widget.transaction.amount);
                  },
                ),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(currency: 'BRL'),
              ],
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Valor é obrigatório';
                }
                final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
                if (digitsOnly.isEmpty) {
                  return 'Valor é obrigatório';
                }
                final numValue = double.parse(digitsOnly) / 100;
                if (numValue <= 0) {
                  return 'Valor deve ser maior que zero';
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
                    'Este mês tem valor personalizado',
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
            onPressed: _isLoading ? null : () {
              ref.read(monthlyTransactionViewModelProvider.notifier).removeMonthlyOverride();
            },
                            child: Text(context.strings.removeAdjustment),
          ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
                      child: Text(context.strings.cancel),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _saveValue,
          child: _isLoading
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
    final amount = digitsOnly.isEmpty ? 0.0 : double.parse(digitsOnly) / 100;

    ref.read(monthlyTransactionViewModelProvider.notifier).updateMonthlyValue(
      transactionId: widget.transaction.id,
      year: widget.year,
      month: widget.month,
      newAmount: amount,
    );
  }
}

/// Função helper para mostrar o dialog
Future<bool?> showMonthlyValueEditor(
  BuildContext context, {
  required TransactionModel transaction,
  required int year,
  required int month,
}) {
  return showDialog<bool>(
    context: context,
    builder: (context) => MonthlyValueEditorDialog(
      transaction: transaction,
      year: year,
      month: month,
    ),
  );
}