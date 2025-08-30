import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/l10n/app_localizations.dart';

class CurrencySelector extends StatelessWidget {
  final String currentCurrency;
  final ValueChanged<String> onChanged;

  const CurrencySelector({
    super.key,
    required this.currentCurrency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        Icons.attach_money,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(l10n.currency),
      subtitle: Text(_getCurrencyDisplayName(currentCurrency, l10n)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showCurrencyDialog(context, l10n),
    );
  }

  String _getCurrencyDisplayName(String currency, AppLocalizations l10n) {
    switch (currency) {
      case 'BRL':
        return l10n.brazilianReal;
      case 'USD':
        return l10n.usDollar;
      case 'EUR':
        return l10n.euro;
      default:
        return l10n.brazilianReal;
    }
  }

  void _showCurrencyDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.currency),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(l10n.brazilianReal),
                value: 'BRL',
                groupValue: currentCurrency,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                    Navigator.of(context).pop();
                  }
                },
              ),
              RadioListTile<String>(
                title: Text(l10n.usDollar),
                value: 'USD',
                groupValue: currentCurrency,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                    Navigator.of(context).pop();
                  }
                },
              ),
              RadioListTile<String>(
                title: Text(l10n.euro),
                value: 'EUR',
                groupValue: currentCurrency,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.cancel),
            ),
          ],
        );
      },
    );
  }
}
