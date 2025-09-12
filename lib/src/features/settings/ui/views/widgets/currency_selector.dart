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
      onTap: () => _showCurrencyBottomSheet(context),
    );
  }

  String _getCurrencyDisplayName(String currency) {
    switch (currency) {
      case 'BRL':
        return 'Real Brasileiro';
      case 'USD':
        return 'Dólar Americano';
      case 'EUR':
        return 'Euro';
      default:
        return 'Real Brasileiro';
    }
  }

  void _showCurrencyBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Icon(
                    Icons.attach_money,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.strings.currency,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Currency options
              _buildCurrencyOption(context, 'BRL', 'Real Brasileiro', 'R\$'),
              const SizedBox(height: 8),
              _buildCurrencyOption(context, 'USD', 'Dólar Americano', '\$'),
              const SizedBox(height: 8),
              _buildCurrencyOption(context, 'EUR', 'Euro', '€'),

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCurrencyOption(
    BuildContext context,
    String value,
    String displayName,
    String symbol,
  ) {
    final isSelected = currentCurrency == value;

    return InkWell(
      onTap: () {
        onChanged(value);
        Navigator.of(context).pop();
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(
                      context,
                    ).colorScheme.outline.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w500,
                      color:
                          isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Text(
                    symbol,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              )
            else
              Icon(
                Icons.circle_outlined,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
