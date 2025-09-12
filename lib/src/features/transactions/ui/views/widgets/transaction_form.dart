import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model_state.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/currency_provider.dart';

class TransactionForm extends ConsumerStatefulWidget {
  final TransactionModel? transaction; // Para edição

  const TransactionForm({super.key, this.transaction});

  @override
  ConsumerState<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends ConsumerState<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  final _categoryController = TextEditingController();
  CategoryEnum? _selectedCategory;

  TransactionTypeEnum _selectedType = TransactionTypeEnum.expense;
  TransactionFrequencyEnum _selectedFrequency =
      TransactionFrequencyEnum.oneTime;
  DateTime? _startDate;
  DateTime? _endDate;
  int? _totalInstallments;
  MonthEnum? _selectedYearlyMonth;

  bool get _isEditing => widget.transaction != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _populateFieldsForEditing();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  void _populateFieldsForEditing() {
    final transaction = widget.transaction!;

    _titleController.text = transaction.title;
    _descriptionController.text = transaction.description ?? '';
    _selectedCategory = transaction.category;

    final currency = ref.read(currencyProvider);
    final formattedAmount = CurrencyFormatter.format(
      transaction.amount,
      currency,
    );
    _amountController.text = formattedAmount;

    _selectedType = transaction.type;
    _selectedFrequency = transaction.frequency;
    _startDate = transaction.startDate;
    _endDate = transaction.endDate;
    _totalInstallments = transaction.totalInstallments;
    _selectedYearlyMonth = transaction.yearlyMonth;
  }

  @override
  Widget build(BuildContext context) {
    final formState = ref.watch(transactionFormViewModelProvider);

    ref.listen<TransactionFormViewModelState>(
      transactionFormViewModelProvider,
      (previous, next) {
        if (next is TransactionFormSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.strings.transactionSaved),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else if (next is TransactionFormErrorState) {
          String errorMessage = next.exception.getMessage(context);

          // Handle specific validation error codes that need translation
          if (next.exception.debugMessage != null) {
            switch (next.exception.debugMessage) {
              case 'startDateRequiredForMonthly':
                errorMessage = context.strings.startDateRequiredForMonthly;
                break;
              case 'installmentsMustBeGreaterThanZero':
                errorMessage =
                    context.strings.installmentsMustBeGreaterThanZero;
                break;
              case 'startDateRequiredForInstallments':
                errorMessage = context.strings.startDateRequiredForInstallments;
                break;
              case 'yearlyMonthRequiredForYearly':
                errorMessage = context.strings.yearlyMonthRequiredForYearly;
                break;
            }
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    next.exception.getTitle(context),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(errorMessage),
                ],
              ),
              backgroundColor: context.colorScheme.error,
              duration: const Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
    );

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTransactionTypeSelector(),
            const SizedBox(height: Spacing.lg),

            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: context.strings.titleRequiredLabel,
                hintText: context.strings.titleHint,
                prefixIcon: const Icon(Icons.title),
              ),
              textInputAction: TextInputAction.next,
              validator:
                  (value) => Validators.required(value, (key) {
                    switch (key) {
                      case 'fieldRequired':
                        return context.strings.titleRequired;
                      default:
                        return key;
                    }
                  }),
              enabled: formState is! TransactionFormLoadingState,
            ),
            const SizedBox(height: Spacing.md),

            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: context.strings.amountRequiredLabel,
                hintText: context.strings.amountHint,
                prefixIcon: const Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(currency: ref.watch(currencyProvider)),
              ],
              onChanged: (value) {
                setState(() {});
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return context.strings.amountRequiredLabel;
                }
                final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
                if (digitsOnly.isEmpty) {
                  return context.strings.amountRequiredLabel;
                }
                final numValue = double.parse(digitsOnly) / 100;
                if (numValue <= 0) {
                  return context.strings.amountPositive;
                }
                return null;
              },
              enabled: formState is! TransactionFormLoadingState,
            ),
            const SizedBox(height: Spacing.md),

            _buildCategorySelector(),
            const SizedBox(height: Spacing.md),

            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: context.strings.enterDescription,
                hintText: context.strings.additionalDetails,
                prefixIcon: const Icon(Icons.description),
              ),
              maxLines: 2,
              textInputAction: TextInputAction.next,
              enabled: formState is! TransactionFormLoadingState,
            ),
            const SizedBox(height: Spacing.lg),

            _buildFrequencySelector(),
            const SizedBox(height: Spacing.md),

            ..._buildFrequencySpecificFields(),

            const SizedBox(height: Spacing.xl),

            ElevatedButton(
              onPressed:
                  formState is TransactionFormLoadingState ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(Spacing.md),
              ),
              child:
                  formState is TransactionFormLoadingState
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          const SizedBox(width: Spacing.sm),
                          Text(context.strings.saving),
                        ],
                      )
                      : Text(
                        _isEditing
                            ? context.strings.updateTransaction
                            : context.strings.saveTransaction,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.transactionType,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Spacing.sm),
        Row(
          children: [
            Expanded(
              child: _buildTypeCard(
                type: TransactionTypeEnum.income,
                title: context.strings.income,
                subtitle: context.strings.moneyIn,
                icon: Icons.arrow_downward,
                color: Colors.green,
                isSelected: _selectedType == TransactionTypeEnum.income,
              ),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: _buildTypeCard(
                type: TransactionTypeEnum.expense,
                title: context.strings.expense,
                subtitle: context.strings.moneyOut,
                icon: Icons.arrow_upward,
                color: Colors.red,
                isSelected: _selectedType == TransactionTypeEnum.expense,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTypeCard({
    required TransactionTypeEnum type,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedType = type;
          _selectedCategory = null;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(Spacing.md),
        decoration: BoxDecoration(
          border: Border.all(
            color:
                isSelected
                    ? color
                    : context.colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? color.withValues(alpha: 0.1) : null,
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: isSelected ? 0.2 : 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: Spacing.sm),
            Text(
              title,
              style: context.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? color : null,
              ),
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              subtitle,
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrequencySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.strings.frequency,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Spacing.sm),
        DropdownButtonFormField<TransactionFrequencyEnum>(
          value: _selectedFrequency,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.repeat),
            hintText: context.strings.selectFrequency,
          ),
          items:
              TransactionFrequencyEnum.values.map((frequency) {
                return DropdownMenuItem(
                  value: frequency,
                  child: Text(_getFrequencyDisplayName(frequency)),
                );
              }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedFrequency = value;
                _resetFrequencyFields();
              });
            }
          },
          validator:
              (value) =>
                  value == null
                      ? context.strings.selectFrequencyRequired
                      : null,
        ),
      ],
    );
  }

  List<Widget> _buildFrequencySpecificFields() {
    switch (_selectedFrequency) {
      case TransactionFrequencyEnum.monthly:
        return _buildMonthlyFields();
      case TransactionFrequencyEnum.installment:
        return _buildInstallmentFields();
      case TransactionFrequencyEnum.yearly:
        return _buildYearlyFields();
      case TransactionFrequencyEnum.oneTime:
        return [];
    }
  }

  List<Widget> _buildMonthlyFields() {
    return [
      const SizedBox(height: Spacing.md),
      Text(
        context.strings.monthlySettings,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: Spacing.sm),

      ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text(context.strings.startMonthRequiredLabel),
        subtitle: Text(
          _startDate != null
              ? '${MonthEnum.values[_startDate!.month - 1].getDisplayName(context)} de ${_startDate!.year}'
              : context.strings.selectStartDate,
        ),
        onTap: () => _selectStartDate(),
        contentPadding: EdgeInsets.zero,
      ),

      ListTile(
        leading: Icon(
          Icons.event_busy,
          color: _startDate == null ? Colors.grey : null,
        ),
        title: Text(
          context.strings.endMonthOptional,
          style: _startDate == null ? TextStyle(color: Colors.grey) : null,
        ),
        subtitle: Text(
          _endDate != null
              ? '${MonthEnum.values[_endDate!.month - 1].getDisplayName(context)} de ${_endDate!.year}'
              : _startDate != null
              ? context.strings.endDateAfterStartSpecific(
                MonthEnum.values[_startDate!.month - 1].getDisplayName(context),
                _startDate!.year.toString(),
              )
              : context.strings.selectStartDateFirst,
          style: _startDate == null ? TextStyle(color: Colors.grey) : null,
        ),
        onTap: _startDate != null ? () => _selectEndDate() : null,
        contentPadding: EdgeInsets.zero,
      ),
    ];
  }

  List<Widget> _buildInstallmentFields() {
    return [
      const SizedBox(height: Spacing.md),
      Text(
        context.strings.installmentSettings,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: Spacing.sm),

      TextFormField(
        initialValue: _totalInstallments?.toString(),
        decoration: InputDecoration(
          labelText: context.strings.totalInstallmentsRequiredLabel,
          hintText: context.strings.enterInstallments,
          prefixIcon: const Icon(Icons.format_list_numbered),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          setState(() {
            _totalInstallments = int.tryParse(value);
          });
        },
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return context.strings.installmentsRequiredForm;
          }
          final num = int.tryParse(value);
          if (num == null || num <= 0) {
            return context.strings.installmentsPositive;
          }
          return null;
        },
      ),

      if (_canCalculateInstallmentValue())
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.calculate, color: Colors.blue.shade700, size: 20),
                const SizedBox(width: 8),
                Text(
                  '${context.strings.installmentValueForm}: ${_getInstallmentValueText()}',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      const SizedBox(height: Spacing.md),

      ListTile(
        leading: const Icon(Icons.calendar_today),
        title: Text('${context.strings.firstInstallmentMonth} *'),
        subtitle: Text(
          _startDate != null
              ? '${MonthEnum.values[_startDate!.month - 1].getDisplayName(context)} de ${_startDate!.year}'
              : context.strings.selectFirstInstallmentMonth,
        ),
        onTap: () => _selectStartDate(),
        contentPadding: EdgeInsets.zero,
      ),
    ];
  }

  List<Widget> _buildYearlyFields() {
    return [
      const SizedBox(height: Spacing.md),
      Text(
        context.strings.yearlySettings,
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: Spacing.sm),

      DropdownButtonFormField<MonthEnum>(
        value: _selectedYearlyMonth,
        decoration: InputDecoration(
          labelText: context.strings.yearlyMonthRequiredLabel,
          prefixIcon: const Icon(Icons.calendar_month),
          hintText: context.strings.selectYearlyMonth,
        ),
        items:
            MonthEnum.values.map((month) {
              return DropdownMenuItem(
                value: month,
                child: Text(month.getDisplayName(context)),
              );
            }).toList(),
        onChanged: (value) => setState(() => _selectedYearlyMonth = value),
        validator:
            (value) =>
                value == null ? context.strings.selectMonthRequired : null,
      ),
    ];
  }

  String _getFrequencyDisplayName(TransactionFrequencyEnum frequency) {
    switch (frequency) {
      case TransactionFrequencyEnum.oneTime:
        return context.strings.frequencyOneTime;
      case TransactionFrequencyEnum.monthly:
        return context.strings.frequencyMonthly;
      case TransactionFrequencyEnum.installment:
        return context.strings.frequencyInstallment;
      case TransactionFrequencyEnum.yearly:
        return context.strings.frequencyYearly;
    }
  }

  Widget _buildCategorySelector() {
    final categories =
        _selectedType == TransactionTypeEnum.income
            ? CategoryEnum.incomeCategories
            : CategoryEnum.expenseCategories;

    return DropdownButtonFormField<CategoryEnum>(
      value: _selectedCategory,
      decoration: InputDecoration(
        labelText: context.strings.categoryField,
        hintText: context.strings.selectCategory,
        prefixIcon: const Icon(Icons.category),
      ),
      items:
          categories.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _getCategoryIcon(category),
                    size: 20,
                    color: context.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Flexible(child: Text(category.getDisplayName(context))),
                ],
              ),
            );
          }).toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      validator: (value) => null, // Categoria é opcional
    );
  }

  IconData _getCategoryIcon(CategoryEnum category) {
    return _getIconFromName(category.iconName);
  }

  IconData _getIconFromName(String iconName) {
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'laptop':
        return Icons.laptop;
      case 'trending_up':
        return Icons.trending_up;
      case 'star':
        return Icons.star;
      case 'card_giftcard':
        return Icons.card_giftcard;
      case 'attach_money':
        return Icons.attach_money;
      case 'home':
        return Icons.home;
      case 'electrical_services':
        return Icons.electrical_services;
      case 'local_grocery_store':
        return Icons.local_grocery_store;
      case 'directions_car':
        return Icons.directions_car;
      case 'security':
        return Icons.security;
      case 'local_hospital':
        return Icons.local_hospital;
      case 'restaurant':
        return Icons.restaurant;
      case 'movie':
        return Icons.movie;
      case 'shopping_bag':
        return Icons.shopping_bag;
      case 'flight':
        return Icons.flight;
      case 'palette':
        return Icons.palette;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'face':
        return Icons.face;
      case 'account_balance':
        return Icons.account_balance;
      case 'credit_card':
        return Icons.credit_card;
      case 'receipt':
        return Icons.receipt;
      case 'money_off':
        return Icons.money_off;
      case 'school':
        return Icons.school;
      case 'menu_book':
        return Icons.menu_book;
      case 'play_lesson':
        return Icons.play_lesson;
      case 'child_care':
        return Icons.child_care;
      case 'pets':
        return Icons.pets;
      case 'redeem':
        return Icons.redeem;
      case 'volunteer_activism':
        return Icons.volunteer_activism;
      case 'savings':
        return Icons.savings;
      case 'category':
      default:
        return Icons.category;
    }
  }

  bool _canCalculateInstallmentValue() {
    if (_totalInstallments == null || _totalInstallments! <= 0) return false;
    if (_amountController.text.trim().isEmpty) return false;

    final digitsOnly = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.isEmpty) return false;

    final amount = double.parse(digitsOnly) / 100;
    return amount > 0;
  }

  String _getInstallmentValueText() {
    final currency = ref.read(currencyProvider);
    if (!_canCalculateInstallmentValue()) {
      return CurrencyFormatter.format(0, currency);
    }

    final digitsOnly = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    final totalAmount = double.parse(digitsOnly) / 100;
    final installmentValue = totalAmount / _totalInstallments!;

    return CurrencyFormatter.format(installmentValue, currency);
  }

  Future<void> _selectStartDate() async {
    final currentDate = _startDate ?? DateTime.now();
    final userRegistrationDate = ref.read(userRegistrationDateProvider);

    final firstDate =
        userRegistrationDate != null
            ? DateTime(userRegistrationDate.year, 1, 1)
            : DateTime(2020);

    final now = DateTime.now();
    final lastDate = DateTime(now.year + 2, 12, 1);

    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDate != null) {
      final newStartDate = DateTime(selectedDate.year, selectedDate.month, 1);

      setState(() {
        _startDate = newStartDate;

        if (_endDate != null && !newStartDate.isBefore(_endDate!)) {
          _endDate = null;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(context.strings.endDateRemoved),
              backgroundColor: Colors.orange,
            ),
          );
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    final now = DateTime.now();
    final currentDate = _endDate ?? DateTime(now.year, now.month, 1);
    final userRegistrationDate = ref.read(userRegistrationDateProvider);

    DateTime firstDate;
    if (_startDate != null) {
      final nextMonth = DateTime(_startDate!.year, _startDate!.month + 1, 1);
      firstDate = nextMonth;
    } else {
      firstDate =
          userRegistrationDate != null
              ? DateTime(userRegistrationDate.year, 1, 1)
              : DateTime(2020);
    }

    final lastDate = DateTime(now.year, 12, 1);

    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDate != null) {
      final lastDay =
          DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
      setState(
        () =>
            _endDate = DateTime(selectedDate.year, selectedDate.month, lastDay),
      );
    }
  }

  void _resetFrequencyFields() {
    setState(() {
      _startDate = null;
      _endDate = null;
      _totalInstallments = null;
      _selectedYearlyMonth = null;
    });
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedFrequency == TransactionFrequencyEnum.monthly &&
        _startDate == null) {
      return; // Não deve acontecer na interface, mas mantém a segurança
    }

    final digitsOnly = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    final amount = digitsOnly.isEmpty ? 0.0 : double.parse(digitsOnly) / 100;

    final viewModel = ref.read(transactionFormViewModelProvider.notifier);

    if (_isEditing) {
      viewModel.updateTransaction(
        transactionId: widget.transaction!.id,
        title: _titleController.text.trim(),
        description:
            _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
        amount: amount,
        type: _selectedType,
        frequency: _selectedFrequency,
        category: _selectedCategory,
        startDate: _startDate,
        endDate: _endDate,
        totalInstallments: _totalInstallments,
        yearlyMonth: _selectedYearlyMonth,
        isDynamic: true,
      );
    } else {
      viewModel.createTransaction(
        title: _titleController.text.trim(),
        description:
            _descriptionController.text.trim().isEmpty
                ? null
                : _descriptionController.text.trim(),
        amount: amount,
        type: _selectedType,
        frequency: _selectedFrequency,
        category: _selectedCategory,
        startDate: _startDate,
        endDate: _endDate,
        totalInstallments: _totalInstallments,
        yearlyMonth: _selectedYearlyMonth,
        isDynamic: true,
      );
    }
  }
}
