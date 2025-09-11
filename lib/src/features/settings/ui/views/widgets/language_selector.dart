import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

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
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        Icons.language,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(context.strings.language),
      subtitle: Text(currentLanguage == 'pt' ? 'Português' : 'English'),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _showLanguageDialog(context),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Idioma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<String>(
                title: Text('Português'),
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
                title: Text('English'),
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
              child: Text(context.strings.cancel),
            ),
          ],
        );
      },
    );
  }
}
