import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/features/transactions/ui/views/widgets/transaction_form.dart';

class AddTransactionView extends ConsumerWidget {
  static const routeName = 'add-transaction';

  const AddTransactionView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nova Transação'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const TransactionForm(),
    );
  }
}
