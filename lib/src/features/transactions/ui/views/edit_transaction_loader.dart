import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/features/transactions/ui/views/edit_transaction_view.dart';

/// Loader que busca uma transação pelo ID e exibe o formulário de edição
/// Usado quando acessamos a rota diretamente via URL (F5 na web)
class EditTransactionLoader extends ConsumerWidget {
  final String transactionId;

  const EditTransactionLoader({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<TransactionModel?>(
      future: _loadTransaction(ref),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(title: const Text('Carregando...')),
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(title: const Text('Erro')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: context.colorScheme.error,
                  ),
                  const SizedBox(height: Spacing.md),
                  Text(
                    'Erro ao carregar transação',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    snapshot.error.toString(),
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Spacing.lg),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Voltar'),
                  ),
                ],
              ),
            ),
          );
        }

        final transaction = snapshot.data;
        if (transaction == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Não Encontrado')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: context.colorScheme.onSurface.withOpacity(0.3),
                  ),
                  const SizedBox(height: Spacing.md),
                  Text(
                    'Transação não encontrada',
                    style: context.textTheme.titleMedium,
                  ),
                  const SizedBox(height: Spacing.xs),
                  Text(
                    'A transação pode ter sido excluída ou o ID está incorreto.',
                    style: context.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: Spacing.lg),
                  ElevatedButton(
                    onPressed: () => AppRoutes.goToTransactions(context),
                    child: const Text('Voltar às Transações'),
                  ),
                ],
              ),
            ),
          );
        }

        return EditTransactionView(transaction: transaction);
      },
    );
  }

  Future<TransactionModel?> _loadTransaction(WidgetRef ref) async {
    try {
      final repository = ref.read(transactionRepositoryProvider);
      final result = await repository.getTransactionById(transactionId);

      return result.fold(
        (failure) => throw failure,
        (transaction) => transaction,
      );
    } catch (e) {
      throw Exception('Erro ao carregar transação: ${e.toString()}');
    }
  }
}
