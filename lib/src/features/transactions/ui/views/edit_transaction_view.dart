import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/features/transactions/data/models/models.dart';
import 'package:stackbudget/src/core/l10n/app_localizations.dart';
import 'package:stackbudget/src/features/transactions/ui/views/widgets/transaction_form.dart';

class EditTransactionView extends ConsumerWidget {
  static const routeName = 'edit-transaction';

  final TransactionModel transaction;

  const EditTransactionView({super.key, required this.transaction});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.editTransaction),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: TransactionForm(transaction: transaction),
    );
  }
}
