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
import 'package:stackbudget/src/features/settings/ui/view_models/currency_provider.dart';

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
          if (next.transaction.title == context.strings.deletedTransaction) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.strings.transactionDeletedSuccess),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(context.strings.transactionUpdatedSuccess),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          }
        } else if (next is TransactionFormErrorState) {
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
                  Text(next.exception.getMessage(context)),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.transactionDetails),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: PopupMenuButton<String>(
              icon: Icon(Icons.more_horiz),
              enabled: formState is! TransactionFormLoadingState,
              itemBuilder:
                  (context) => [
                    PopupMenuItem<String>(
                      value: 'edit',
                      child: Row(
                        children: [
                          const Icon(Icons.edit),
                          const SizedBox(width: 8),
                          Text(context.strings.edit),
                        ],
                      ),
                    ),
                    if (_canAdjustMonthlyValue())
                      PopupMenuItem<String>(
                        value: 'adjust',
                        child: Row(
                          children: [
                            const Icon(Icons.tune, color: Colors.orange),
                            const SizedBox(width: 8),
                            Text(
                              context.strings.adjustMonthlyValueAction,
                              style: const TextStyle(color: Colors.orange),
                            ),
                          ],
                        ),
                      ),
                    const PopupMenuDivider(),
                    PopupMenuItem<String>(
                      value: 'delete',
                      child: Row(
                        children: [
                          const Icon(Icons.delete, color: Colors.red),
                          const SizedBox(width: 8),
                          Text(
                            context.strings.delete,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    _editTransaction(context);
                    break;
                  case 'adjust':
                    _adjustMonthlyValue(context);
                    break;
                  case 'delete':
                    _showDeleteConfirmation(context, ref);
                    break;
                }
              },
            ),
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
                    _buildDetailSection(context.strings.generalInformation, [
                      _buildDetailItem(
                        context.strings.type,
                        widget.transaction.type == TransactionTypeEnum.income
                            ? context.strings.income
                            : context.strings.expense,
                        Icons.swap_vert,
                      ),
                      _buildDetailItem(
                        context.strings.frequency,
                        _getFrequencyDisplayName(
                          context,
                          widget.transaction.frequency,
                        ),
                        Icons.repeat,
                      ),
                      if (widget.transaction.category != null)
                        _buildDetailItem(
                          context.strings.categoryField,
                          widget.transaction.category!.displayName,
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
            if (widget.transaction.totalInstallments != null)
              _buildDetailItem(
                'Parcela Atual',
                '${_getCurrentInstallmentNumber()}/${widget.transaction.totalInstallments}',
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
    final currency = ref.watch(currencyProvider);
    return CurrencyFormatter.format(value, currency);
  }

  String _formatMonthYear(DateTime date) {
    return '${_getMonthDisplayName(MonthEnum.values[date.month - 1])} de ${date.year}';
  }

  String _formatDateTime(DateTime date) {
    return DateFormat('dd/MM/yyyy HH:mm').format(date);
  }

  String _getFrequencyDisplayName(
    BuildContext context,
    TransactionFrequencyEnum frequency,
  ) {
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

    final isInstallment =
        widget.transaction.frequency == TransactionFrequencyEnum.installment;

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

        // Para transações parceladas, mostrar informação adicional
        if (isInstallment &&
            widget.transaction.totalInstallments != null &&
            widget.transaction.totalInstallments! > 0) ...[
          const SizedBox(height: Spacing.xs),
          Text(
            'Valor da parcela',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.orange,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: Spacing.xs),
          Text(
            'Valor total: ${_formatCurrency(widget.transaction.amount)}',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],

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
            isInstallment
                ? 'Valor padrão da parcela: ${_formatCurrency(widget.transaction.amount / widget.transaction.totalInstallments!)}'
                : 'Valor padrão: ${_formatCurrency(widget.transaction.amount)}',
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.onSurface.withOpacity(0.6),
            ),
          ),
        ],
      ],
    );
  }

  bool _hasCurrentPeriodAdjustment(
    int year,
    int month,
    DashboardViewModelState dashboardState,
  ) {
    // Só transações mensais podem ter ajustes
    if (widget.transaction.frequency != TransactionFrequencyEnum.monthly) {
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

  double _getCurrentPeriodValue(
    int year,
    int month,
    DashboardViewModelState dashboardState,
  ) {
    // Calcular valor padrão baseado no tipo de transação
    double defaultAmount = widget.transaction.amount;

    // Para transações parceladas, dividir o valor total pelo número de parcelas
    if (widget.transaction.frequency == TransactionFrequencyEnum.installment &&
        widget.transaction.totalInstallments != null &&
        widget.transaction.totalInstallments! > 0) {
      defaultAmount =
          widget.transaction.amount / widget.transaction.totalInstallments!;
    }

    // Buscar override mensal no estado do dashboard para o período selecionado
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

      return monthlyOverride?.amount ?? defaultAmount;
    }

    return defaultAmount;
  }

  int _getCurrentInstallmentNumber() {
    if (widget.transaction.startDate == null ||
        widget.transaction.totalInstallments == null) {
      return 1;
    }

    final selectedPeriod = ref.read(selectedPeriodProvider);
    final startDate = widget.transaction.startDate!;

    // Calcular quantos meses se passaram desde o início
    final monthsDifference =
        ((selectedPeriod.year - startDate.year) * 12) +
        (selectedPeriod.month - startDate.month);

    // A parcela atual é a diferença + 1 (primeira parcela = 1)
    final installmentNumber = monthsDifference + 1;

    // Garantir que não ultrapasse o total de parcelas
    return installmentNumber.clamp(1, widget.transaction.totalInstallments!);
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
    return widget.transaction.frequency == TransactionFrequencyEnum.monthly;
  }

  void _adjustMonthlyValue(BuildContext context) async {
    // Usar o período selecionado no dashboard, não o mês atual
    final selectedPeriod = ref.read(selectedPeriodProvider);
    await showMonthlyValueEditor(
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
            title: Text(context.strings.confirmDelete),
            content: Text(
              'Tem certeza que deseja excluir a transação "${widget.transaction.title}"?\n\n'
              'Esta ação não pode ser desfeita.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(context.strings.cancel),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ref
                      .read(transactionFormViewModelProvider.notifier)
                      .deleteTransaction(widget.transaction.id);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text(context.strings.delete),
              ),
            ],
          ),
    );
  }
}
