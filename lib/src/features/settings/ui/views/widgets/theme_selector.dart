import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/core.dart';
import '../../view_models/settings_view_model.dart';

class ThemeSelector extends ConsumerWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    final isDarkMode = themeMode == ThemeMode.dark;
    final isSystemMode = themeMode == ThemeMode.system;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: Icon(
        isDarkMode ? Icons.dark_mode : Icons.light_mode,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(context.strings.appearance),
      subtitle: Text(
        isSystemMode
            ? 'Sistema'
            : isDarkMode
            ? context.strings.darkMode
            : context.strings.lightMode,
      ),
      trailing: Switch(
        value: isDarkMode,
        onChanged: (value) {
          ref.read(themeModeProvider.notifier).updateThemeMode(value);
          // Também atualizar as configurações persistidas
          ref.read(settingsViewModelProvider.notifier).updateTheme(value);
        },
      ),
      onTap: () {
        final newValue = !isDarkMode;
        ref.read(themeModeProvider.notifier).updateThemeMode(newValue);
        ref.read(settingsViewModelProvider.notifier).updateTheme(newValue);
      },
    );
  }
}
