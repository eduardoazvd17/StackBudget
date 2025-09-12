import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import '../../view_models/settings_view_model.dart';
import '../../view_models/settings_view_model_state.dart';
import '../../../data/models/models.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsViewModelProvider);

    ThemeModeType currentThemeMode = ThemeModeType.system;
    if (settingsState is SettingsLoadedState) {
      currentThemeMode = settingsState.settings.themeMode;
    }

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        _getThemeIcon(currentThemeMode),
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(context.strings.appearance),
      subtitle: Text(currentThemeMode.displayName),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _showThemeSelectionDialog(context, ref, currentThemeMode),
    );
  }

  IconData _getThemeIcon(ThemeModeType themeMode) {
    switch (themeMode) {
      case ThemeModeType.system:
        return Icons.settings_suggest;
      case ThemeModeType.light:
        return Icons.light_mode;
      case ThemeModeType.dark:
        return Icons.dark_mode;
    }
  }

  Future<void> _showThemeSelectionDialog(
    BuildContext context,
    WidgetRef ref,
    ThemeModeType currentTheme,
  ) async {
    final selectedTheme = await showDialog<ThemeModeType>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(context.strings.appearance),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:
                  ThemeModeType.values.map((themeMode) {
                    return RadioListTile<ThemeModeType>(
                      title: Row(
                        children: [
                          Icon(
                            _getThemeIcon(themeMode),
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 16),
                          Text(themeMode.displayName),
                        ],
                      ),
                      value: themeMode,
                      groupValue: currentTheme,
                      onChanged: (value) {
                        if (value != null) {
                          Navigator.of(context).pop(value);
                        }
                      },
                    );
                  }).toList(),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
            ],
          ),
    );

    if (selectedTheme != null && selectedTheme != currentTheme) {
      // Atualizar o ThemeNotifier
      ref
          .read(themeModeProvider.notifier)
          .updateThemeModeFromType(selectedTheme);

      // Atualizar as configurações persistidas
      await ref
          .read(settingsViewModelProvider.notifier)
          .updateThemeMode(selectedTheme);
    }
  }
}
