import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  final String currentLanguage;
  final ValueChanged<String> onChanged;

  const LanguageSelector({
    super.key,
    required this.currentLanguage,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        Icons.language,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(l10n.language),
      subtitle: Text(
        currentLanguage == 'pt' ? l10n.portuguese : l10n.english,
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showLanguageDialog(context, l10n),
    );
  }

  void _showLanguageDialog(BuildContext context, AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text(l10n.portuguese),
                value: 'pt',
                groupValue: currentLanguage,
                onChanged: (value) {
                  if (value != null) {
                    onChanged(value);
                    Navigator.of(context).pop();
                  }
                },
              ),
              RadioListTile<String>(
                title: Text(l10n.english),
                value: 'en',
                groupValue: currentLanguage,
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
