import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model_state.dart';

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
  TransactionCategoryEnum? _selectedCategory;

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

    // Formatar o valor para o campo
    final formattedAmount = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 2,
    ).format(transaction.amount);
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
              content: Text(
                _isEditing
                    ? 'Transação atualizada com sucesso!'
                    : 'Transação criada com sucesso!',
              ),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.of(context).pop();
        } else if (next is TransactionFormErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.message),
              backgroundColor: context.colorScheme.error,
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
            // Tipo da transação (Receita/Despesa)
            _buildTransactionTypeSelector(),
            const SizedBox(height: Spacing.lg),

            // Título
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título *',
                hintText: 'Ex: Salário, Aluguel, Supermercado...',
                prefixIcon: Icon(Icons.title),
              ),
              textInputAction: TextInputAction.next,
              validator: Validators.required,
              enabled: formState is! TransactionFormLoadingState,
            ),
            const SizedBox(height: Spacing.md),

            // Valor
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Valor *',
                hintText: 'R\$ 0,00',
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CurrencyInputFormatter(currency: 'BRL'),
              ],
              onChanged: (value) {
                // Atualizar o estado para recalcular valor da parcela
                setState(() {});
              },
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Valor é obrigatório';
                }
                // Extrai apenas os dígitos e converte para double
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
              enabled: formState is! TransactionFormLoadingState,
            ),
            const SizedBox(height: Spacing.md),

            // Categoria
            _buildCategorySelector(),
            const SizedBox(height: Spacing.md),

            // Descrição
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                hintText: 'Detalhes adicionais (opcional)',
                prefixIcon: Icon(Icons.description),
              ),
              maxLines: 2,
              textInputAction: TextInputAction.next,
              enabled: formState is! TransactionFormLoadingState,
            ),
            const SizedBox(height: Spacing.lg),

            // Frequência
            _buildFrequencySelector(),
            const SizedBox(height: Spacing.md),

            // Campos específicos por frequência
            ..._buildFrequencySpecificFields(),

            const SizedBox(height: Spacing.xl),

            // Botão de salvar
            ElevatedButton(
              onPressed:
                  formState is TransactionFormLoadingState ? null : _submitForm,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(Spacing.md),
              ),
              child:
                  formState is TransactionFormLoadingState
                      ? const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                          SizedBox(width: Spacing.sm),
                          Text('Salvando...'),
                        ],
                      )
                      : Text(
                        _isEditing ? 'Atualizar Transação' : 'Salvar Transação',
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
          'Tipo da Transação',
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
                title: 'Receita',
                subtitle: 'Dinheiro que entra',
                icon: Icons.arrow_downward,
                color: Colors.green,
                isSelected: _selectedType == TransactionTypeEnum.income,
              ),
            ),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: _buildTypeCard(
                type: TransactionTypeEnum.expense,
                title: 'Despesa',
                subtitle: 'Dinheiro que sai',
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
          // Reset categoria quando o tipo muda
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
                    : context.colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? color.withOpacity(0.1) : null,
        ),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(isSelected ? 0.2 : 0.1),
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
                color: context.colorScheme.onSurface.withOpacity(0.6),
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
          'Frequência',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: Spacing.sm),
        DropdownButtonFormField<TransactionFrequencyEnum>(
          value: _selectedFrequency,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.repeat),
            hintText: 'Selecione a frequência',
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
              (value) => value == null ? 'Selecione uma frequência' : null,
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
        'Configurações Mensais',
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: Spacing.sm),

      // Data de início
      ListTile(
        leading: const Icon(Icons.calendar_today),
        title: const Text('Mês de Início *'),
        subtitle: Text(
          _startDate != null
              ? '${_getMonthDisplayName(MonthEnum.values[_startDate!.month - 1])} de ${_startDate!.year}'
              : 'Selecione quando começar',
        ),
        onTap: () => _selectStartDate(),
        contentPadding: EdgeInsets.zero,
      ),

      // Data de fim (opcional)
      ListTile(
        leading: Icon(
          Icons.event_busy,
          color: _startDate == null ? Colors.grey : null,
        ),
        title: Text(
          'Mês de Fim (opcional)',
          style: _startDate == null ? TextStyle(color: Colors.grey) : null,
        ),
        subtitle: Text(
          _endDate != null
              ? '${_getMonthDisplayName(MonthEnum.values[_endDate!.month - 1])} de ${_endDate!.year}'
              : _startDate != null
              ? 'Deve ser posterior a ${_getMonthDisplayName(MonthEnum.values[_startDate!.month - 1])}/${_startDate!.year}'
              : 'Selecione primeiro a data de início',
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
        'Configurações de Parcelamento',
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: Spacing.sm),

      // Número de parcelas
      TextFormField(
        initialValue: _totalInstallments?.toString(),
        decoration: const InputDecoration(
          labelText: 'Número de Parcelas *',
          hintText: 'Ex: 12',
          prefixIcon: Icon(Icons.format_list_numbered),
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
            return 'Número de parcelas é obrigatório';
          }
          final num = int.tryParse(value);
          if (num == null || num <= 0) {
            return 'Deve ser um número maior que zero';
          }
          return null;
        },
      ),

      // Exibir valor por parcela se ambos os campos estiverem preenchidos
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
                  'Valor por parcela: ${_getInstallmentValueText()}',
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

      // Data da primeira parcela
      ListTile(
        leading: const Icon(Icons.calendar_today),
        title: const Text('Mês da 1ª Parcela *'),
        subtitle: Text(
          _startDate != null
              ? '${_getMonthDisplayName(MonthEnum.values[_startDate!.month - 1])} de ${_startDate!.year}'
              : 'Selecione o mês da primeira parcela',
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
        'Configurações Anuais',
        style: context.textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      const SizedBox(height: Spacing.sm),

      // Mês do ano
      DropdownButtonFormField<MonthEnum>(
        value: _selectedYearlyMonth,
        decoration: const InputDecoration(
          labelText: 'Mês do Ano *',
          prefixIcon: Icon(Icons.calendar_month),
          hintText: 'Em qual mês ocorre anualmente',
        ),
        items:
            MonthEnum.values.map((month) {
              return DropdownMenuItem(
                value: month,
                child: Text(_getMonthDisplayName(month)),
              );
            }).toList(),
        onChanged: (value) => setState(() => _selectedYearlyMonth = value),
        validator: (value) => value == null ? 'Selecione o mês' : null,
      ),
    ];
  }

  String _getFrequencyDisplayName(TransactionFrequencyEnum frequency) {
    switch (frequency) {
      case TransactionFrequencyEnum.oneTime:
        return 'Única';
      case TransactionFrequencyEnum.monthly:
        return 'Mensal';
      case TransactionFrequencyEnum.installment:
        return 'Parcelado';
      case TransactionFrequencyEnum.yearly:
        return 'Anual';
    }
  }

  Widget _buildCategorySelector() {
    // Filtra as categorias baseado no tipo de transação selecionado
    final categories =
        _selectedType == TransactionTypeEnum.income
            ? TransactionCategoryEnum.incomeCategories
            : TransactionCategoryEnum.expenseCategories;

    return DropdownButtonFormField<TransactionCategoryEnum>(
      value: _selectedCategory,
      decoration: const InputDecoration(
        labelText: 'Categoria',
        hintText: 'Selecione uma categoria',
        prefixIcon: Icon(Icons.category),
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
                    color: context.colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  Flexible(child: Text(category.displayName)),
                ],
              ),
            );
          }).toList(),
      onChanged: (value) => setState(() => _selectedCategory = value),
      validator: (value) => null, // Categoria é opcional
    );
  }

  IconData _getCategoryIcon(TransactionCategoryEnum category) {
    switch (category.iconName) {
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
    if (!_canCalculateInstallmentValue()) return 'R\$ 0,00';

    final digitsOnly = _amountController.text.replaceAll(RegExp(r'[^\d]'), '');
    final totalAmount = double.parse(digitsOnly) / 100;
    final installmentValue = totalAmount / _totalInstallments!;

    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 2,
    ).format(installmentValue);
  }

  String _getMonthDisplayName(MonthEnum month) {
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
    return months[month.index];
  }

  Future<void> _selectStartDate() async {
    final currentDate = _startDate ?? DateTime.now();
    final userRegistrationDate = ref.read(userRegistrationDateProvider);

    // Define a data mínima como janeiro do ano de cadastro do usuário, ou 2020 como fallback
    final firstDate =
        userRegistrationDate != null
            ? DateTime(userRegistrationDate.year, 1, 1)
            : DateTime(2020);

    // Define a data máxima como dezembro do ano atual + 2 anos (para recorrências longas)
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

        // Se a nova data de início é igual ou posterior à data de fim, limpar a data de fim
        // Para recorrências, a data de fim deve ser posterior (não igual) à data de início
        if (_endDate != null && !newStartDate.isBefore(_endDate!)) {
          _endDate = null;
          // Mostrar aviso informativo
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Data de fim removida - deve ser posterior à data de início',
              ),
              backgroundColor: Colors.orange,
            ),
          );
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    // Sempre abre no mês atual, independente da data de fim já selecionada
    final now = DateTime.now();
    final currentDate = _endDate ?? DateTime(now.year, now.month, 1);
    final userRegistrationDate = ref.read(userRegistrationDateProvider);

    // Define a data mínima baseada na data de início (se definida) ou na data de cadastro
    DateTime firstDate;
    if (_startDate != null) {
      // Se há data de início, a data de fim deve ser no mês seguinte (posterior)
      // Para gastos recorrentes, precisa ter pelo menos 2 meses
      final nextMonth = DateTime(_startDate!.year, _startDate!.month + 1, 1);
      firstDate = nextMonth;
    } else {
      // Se não há data de início, usar a data de cadastro como fallback
      firstDate =
          userRegistrationDate != null
              ? DateTime(userRegistrationDate.year, 1, 1)
              : DateTime(2020);
    }

    // Define a data máxima como dezembro do ano atual
    final lastDate = DateTime(now.year, 12, 1);

    final selectedDate = await showMonthYearPicker(
      context: context,
      initialDate: currentDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDate != null) {
      // Define como último dia do mês selecionado
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

    // Validação mínima para transações mensais
    if (_selectedFrequency == TransactionFrequencyEnum.monthly &&
        _startDate == null) {
      return; // Não deve acontecer na interface, mas mantém a segurança
    }

    // Extrai apenas os dígitos do valor formatado e converte para double
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
