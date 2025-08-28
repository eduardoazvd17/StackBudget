import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model_state.dart';
import 'package:stackbudget/src/features/transactions/ui/views/widgets/monthly_value_editor_dialog.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model_state.dart';

class TransactionDetailView extends ConsumerStatefulWidget {
  static const routeName = 'transaction-detail';

  final TransactionModel transaction;

  const TransactionDetailView({super.key, required this.transaction});

  @override
  ConsumerState<TransactionDetailView> createState() =>
      _TransactionDetailViewState();
}

class _TransactionDetailViewState extends ConsumerState<TransactionDetailView> {
  @override
  Widget build(BuildContext context) {
    final transaction = widget.transaction;
    final formState = ref.watch(transactionFormViewModelProvider);

    ref.listen<TransactionFormViewModelState>(
      transactionFormViewModelProvider,
      (previous, next) {
        if (next is TransactionFormSuccessState) {
          if (next.transaction.title == 'Transação excluída') {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transação excluída com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Transação atualizada com sucesso!'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          }
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Transação'),
        actions: [
          // Botão para ajustar valor mensal (só para transações mensais dinâmicas)
          if (_canAdjustMonthlyValue())
            IconButton(
              icon: const Icon(Icons.tune),
              tooltip: 'Ajustar valor deste mês',
              onPressed:
                  formState is TransactionFormLoadingState
                      ? null
                      : () => _adjustMonthlyValue(context),
            ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed:
                formState is TransactionFormLoadingState
                    ? null
                    : () => _editTransaction(context),
          ),
          PopupMenuButton(
            enabled: formState is! TransactionFormLoadingState,
            itemBuilder:
                (context) => [
                  const PopupMenuItem(
                    value: 'delete',
                    child: Row(
                      children: [
                        Icon(Icons.delete, color: Colors.red),
                        SizedBox(width: 8),
                        Text('Excluir', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ],
            onSelected: (value) {
              if (value == 'delete') {
                _showDeleteConfirmation(context, ref);
              }
            },
          ),
        ],
      ),
      body:
          formState is TransactionFormLoadingState
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(Spacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Card principal
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Spacing.lg),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Título e valor
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.transaction.title,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                _buildValueSection(),
                              ],
                            ),

                            if (widget.transaction.description != null) ...[
                              const SizedBox(height: Spacing.md),
                              Text(
                                widget.transaction.description!,
                                style: context.textTheme.bodyLarge,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: Spacing.lg),

                    // Informações detalhadas
                    _buildDetailSection('Informações Gerais', [
                      _buildDetailItem(
                        'Tipo',
                        widget.transaction.type == TransactionTypeEnum.income
                            ? 'Receita'
                            : 'Despesa',
                        Icons.swap_vert,
                      ),
                      _buildDetailItem(
                        'Frequência',
                        _getFrequencyDisplayName(widget.transaction.frequency),
                        Icons.repeat,
                      ),
                      if (widget.transaction.category != null)
                        _buildDetailItem(
                          'Categoria',
                          widget.transaction.category!,
                          Icons.category,
                        ),
                    ]),

                    const SizedBox(height: Spacing.lg),

                    // Informações de frequência específicas
                    ..._buildFrequencySpecificInfo(),

                    const SizedBox(height: Spacing.lg),

                    // Informações de data
                    _buildDetailSection('Datas', [
                      _buildDetailItem(
                        'Criado em',
                        _formatDateTime(transaction.createdAt),
                        Icons.calendar_today,
                      ),
                      _buildDetailItem(
                        'Atualizado em',
                        _formatDateTime(transaction.updatedAt),
                        Icons.update,
                      ),
                    ]),

                    if (widget.transaction.tags != null &&
                        widget.transaction.tags!.isNotEmpty) ...[
                      const SizedBox(height: Spacing.lg),
                      _buildTagsSection(),
                    ],
                  ],
                ),
              ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Spacing.sm),
        Card(child: Column(children: items)),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.xs,
      ),
    );
  }

  List<Widget> _buildFrequencySpecificInfo() {
    switch (widget.transaction.frequency) {
      case TransactionFrequencyEnum.monthly:
        return [
          _buildDetailSection('Informações Mensais', [
            if (widget.transaction.startDate != null)
              _buildDetailItem(
                'Mês de Início',
                _formatMonthYear(widget.transaction.startDate!),
                Icons.play_arrow,
              ),
            if (widget.transaction.endDate != null)
              _buildDetailItem(
                'Mês de Fim',
                _formatMonthYear(widget.transaction.endDate!),
                Icons.stop,
              ),
            _buildDetailItem(
              'Valor Dinâmico',
              widget.transaction.isDynamic ? 'Sim' : 'Não',
              Icons.tune,
            ),
          ]),
        ];

      case TransactionFrequencyEnum.installment:
        return [
          _buildDetailSection('Informações de Parcelamento', [
            if (widget.transaction.totalInstallments != null)
              _buildDetailItem(
                'Total de Parcelas',
                '${widget.transaction.totalInstallments}x',
                Icons.format_list_numbered,
              ),
            if (widget.transaction.currentInstallment != null)
              _buildDetailItem(
                'Parcela Atual',
                '${widget.transaction.currentInstallment! + 1}/${widget.transaction.totalInstallments}',
                Icons.timeline,
              ),
            if (widget.transaction.startDate != null)
              _buildDetailItem(
                'Mês da 1ª Parcela',
                _formatMonthYear(widget.transaction.startDate!),
                Icons.calendar_today,
              ),
          ]),
        ];

      case TransactionFrequencyEnum.yearly:
        return [
          _buildDetailSection('Informações Anuais', [
            if (widget.transaction.yearlyMonth != null)
              _buildDetailItem(
                'Mês do Ano',
                _getMonthDisplayName(widget.transaction.yearlyMonth!),
                Icons.calendar_month,
              ),
          ]),
        ];

      case TransactionFrequencyEnum.oneTime:
        return [];
    }
  }

  Widget _buildTagsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tags',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: Spacing.sm),
        Wrap(
          spacing: Spacing.xs,
          runSpacing: Spacing.xs,
          children:
              widget.transaction.tags!.map((tag) {
                return Chip(
                  label: Text(tag),
                  backgroundColor: Colors.blue.withOpacity(0.1),
                );
              }).toList(),
        ),
      ],
    );
  }

  String _formatCurrency(double value) {
    return NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$ ',
      decimalDigits: 2,
    ).format(value);
  }

  String _formatMonthYear(DateTime date) {
    return '${_getMonthDisplayName(MonthEnum.values[date.month - 1])} de ${date.year}';
  }

  String _formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  String _getFrequencyDisplayName(TransactionFrequencyEnum frequency) {
    switch (frequency) {
      case TransactionFrequencyEnum.oneTime:
        return 'Único/Variável';
      case TransactionFrequencyEnum.monthly:
        return 'Mensal (Recorrente)';
      case TransactionFrequencyEnum.installment:
        return 'Parcelado';
      case TransactionFrequencyEnum.yearly:
        return 'Anual';
    }
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

  Widget _buildValueSection() {
    final selectedPeriod = ref.watch(selectedPeriodProvider);
    final dashboardState = ref.watch(dashboardViewModelProvider);
    
    final currentPeriodValue = _getCurrentPeriodValue(
      selectedPeriod.year,
      selectedPeriod.month,
      dashboardState,
    );
    final hasAdjustment = _hasCurrentPeriodAdjustment(
      selectedPeriod.year,
      selectedPeriod.month,
      dashboardState,
    );

    final color =
        widget.transaction.type == TransactionTypeEnum.income
            ? Colors.green
            : Colors.red;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Valor principal (do período selecionado)
        Text(
          _formatCurrency(currentPeriodValue),
          style: context.textTheme.headlineSmall?.copyWith(
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Se há ajuste, mostrar informação adicional
        if (hasAdjustment) ...[
          const SizedBox(height: Spacing.xs),
          Row(
            children: [
              Icon(Icons.tune, size: 16, color: Colors.orange),
              const SizedBox(width: Spacing.xs),
              Text(
                'Valor ajustado para ${_getMonthName(selectedPeriod.month)}/${selectedPeriod.year}',
                style: context.textTheme.bodySmall?.copyWith(
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            'Valor padrão: ${_formatCurrency(widget.transaction.amount)}',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }

  bool _hasCurrentPeriodAdjustment(int year, int month, DashboardViewModelState dashboardState) {
    // Só transações mensais dinâmicas podem ter ajustes
    if (widget.transaction.frequency != TransactionFrequencyEnum.monthly ||
        !widget.transaction.isDynamic) {
      return false;
    }

    if (dashboardState is DashboardLoadedState) {
      return dashboardState.monthlyTransactions.any(
        (mt) =>
            mt.parentTransactionId == widget.transaction.id &&
            mt.year == year &&
            mt.month == month,
      );
    }

    return false;
  }

  double _getCurrentPeriodValue(int year, int month, DashboardViewModelState dashboardState) {
    // Para transações não dinâmicas, retorna sempre o valor base
    if (widget.transaction.frequency != TransactionFrequencyEnum.monthly ||
        !widget.transaction.isDynamic) {
      return widget.transaction.amount;
    }

    if (dashboardState is DashboardLoadedState) {
      final monthlyOverride =
          dashboardState.monthlyTransactions
                  .where(
                    (mt) =>
                        mt.parentTransactionId == widget.transaction.id &&
                        mt.year == year &&
                        mt.month == month,
                  )
                  .isNotEmpty
              ? dashboardState.monthlyTransactions
                  .where(
                    (mt) =>
                        mt.parentTransactionId == widget.transaction.id &&
                        mt.year == year &&
                        mt.month == month,
                  )
                  .first
              : null;

      return monthlyOverride?.amount ?? widget.transaction.amount;
    }

    return widget.transaction.amount;
  }

  String _getMonthName(int month) {
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
    return months[month - 1];
  }

  bool _canAdjustMonthlyValue() {
    return widget.transaction.frequency == TransactionFrequencyEnum.monthly &&
        widget.transaction.isDynamic;
  }

     void _adjustMonthlyValue(BuildContext context) async {
    // Usar o período selecionado no dashboard, não o mês atual
    final selectedPeriod = ref.read(selectedPeriodProvider);
    final result = await showMonthlyValueEditor(
      context,
      transaction: widget.transaction,
      year: selectedPeriod.year,
      month: selectedPeriod.month,
    );

    // A atualização será automática via ref.watch no _buildValueSection
  }

  void _editTransaction(BuildContext context) {
    AppRoutes.goToEditTransaction(context, widget.transaction);
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text(
              'Tem certeza que deseja excluir a transação "${widget.transaction.title}"?\n\n'
              'Esta ação não pode ser desfeita.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref
                      .read(transactionFormViewModelProvider.notifier)
                      .deleteTransaction(widget.transaction.id);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );
  }
}
