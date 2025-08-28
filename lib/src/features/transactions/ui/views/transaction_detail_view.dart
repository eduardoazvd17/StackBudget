import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model_state.dart';

class TransactionDetailView extends ConsumerWidget {
  static const routeName = 'transaction-detail';

  final TransactionModel transaction;

  const TransactionDetailView({super.key, required this.transaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                                    transaction.title,
                                    style: context.textTheme.headlineSmall
                                        ?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Text(
                                  _formatCurrency(transaction.amount),
                                  style: context.textTheme.headlineSmall
                                      ?.copyWith(
                                        color:
                                            transaction.type ==
                                                    TransactionTypeEnum.income
                                                ? Colors.green
                                                : Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ],
                            ),

                            if (transaction.description != null) ...[
                              const SizedBox(height: Spacing.md),
                              Text(
                                transaction.description!,
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
                        transaction.type == TransactionTypeEnum.income
                            ? 'Receita'
                            : 'Despesa',
                        Icons.swap_vert,
                      ),
                      _buildDetailItem(
                        'Frequência',
                        _getFrequencyDisplayName(transaction.frequency),
                        Icons.repeat,
                      ),
                      if (transaction.category != null)
                        _buildDetailItem(
                          'Categoria',
                          transaction.category!,
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

                    if (transaction.tags != null &&
                        transaction.tags!.isNotEmpty) ...[
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
    switch (transaction.frequency) {
      case TransactionFrequencyEnum.monthly:
        return [
          _buildDetailSection('Informações Mensais', [
            if (transaction.startDate != null)
              _buildDetailItem(
                'Data de Início',
                _formatDate(transaction.startDate!),
                Icons.play_arrow,
              ),
            if (transaction.endDate != null)
              _buildDetailItem(
                'Data de Fim',
                _formatDate(transaction.endDate!),
                Icons.stop,
              ),
            _buildDetailItem(
              'Valor Dinâmico',
              transaction.isDynamic ? 'Sim' : 'Não',
              Icons.tune,
            ),
          ]),
        ];

      case TransactionFrequencyEnum.installment:
        return [
          _buildDetailSection('Informações de Parcelamento', [
            if (transaction.totalInstallments != null)
              _buildDetailItem(
                'Total de Parcelas',
                '${transaction.totalInstallments}x',
                Icons.format_list_numbered,
              ),
            if (transaction.currentInstallment != null)
              _buildDetailItem(
                'Parcela Atual',
                '${transaction.currentInstallment! + 1}/${transaction.totalInstallments}',
                Icons.timeline,
              ),
            if (transaction.startDate != null)
              _buildDetailItem(
                'Primeira Parcela',
                _formatDate(transaction.startDate!),
                Icons.calendar_today,
              ),
          ]),
        ];

      case TransactionFrequencyEnum.yearly:
        return [
          _buildDetailSection('Informações Anuais', [
            if (transaction.yearlyMonth != null)
              _buildDetailItem(
                'Mês do Ano',
                _getMonthDisplayName(transaction.yearlyMonth!),
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
              transaction.tags!.map((tag) {
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

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
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

  void _editTransaction(BuildContext context) {
    AppRoutes.goToEditTransaction(context, transaction);
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirmar Exclusão'),
            content: Text(
              'Tem certeza que deseja excluir a transação "${transaction.title}"?\n\n'
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
                      .deleteTransaction(transaction.id);
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Excluir'),
              ),
            ],
          ),
    );
  }
}
