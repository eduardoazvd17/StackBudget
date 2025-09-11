import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        Icons.attach_money,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(context.strings.currency),
      subtitle: Text(_getCurrencyDisplayName(currentCurrency)),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showCurrencyDialog(context),
    );
  }

  String _getCurrencyDisplayName(String currency) {
    switch (currency) {
      case 'BRL':
        return 'Real Brasileiro';
      case 'USD':
        return 'Dolar Americano';
      case 'EUR':
        return 'Euro';
      default:
        return 'Real Brasileiro';
    }
  }

  void _showCurrencyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Moeda'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('Real Brasileiro'),
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
                title: Text('Dolar Americano'),
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
                title: Text('Euro'),
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
              child: Text(context.strings.cancel),
            ),
          ],
        );
      },
    );
  }
}
