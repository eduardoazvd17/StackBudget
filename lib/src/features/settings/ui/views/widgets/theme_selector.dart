import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/l10n/app_localizations.dart';

class ThemeSelector extends StatelessWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onChanged;

  const ThemeSelector({
    super.key,
    required this.isDarkMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(l10n.appearance),
      subtitle: Text(
        isDarkMode ? l10n.darkMode : l10n.lightMode,
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: onChanged,
      ),
      onTap: () => onChanged(!isDarkMode),
    );
  }
}
