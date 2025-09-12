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
      onTap:
          () => _showThemeSelectionBottomSheet(context, ref, currentThemeMode),
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

  void _showThemeSelectionBottomSheet(
    BuildContext context,
    WidgetRef ref,
    ThemeModeType currentTheme,
  ) {
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
                    Icons.palette,
                    color: Theme.of(context).colorScheme.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    context.strings.appearance,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Theme options
              ...ThemeModeType.values.map((themeMode) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _buildThemeOption(context, themeMode, currentTheme, (
                    value,
                  ) async {
                    // Apply theme immediately when tapped
                    ref
                        .read(themeModeProvider.notifier)
                        .updateThemeModeFromType(value);

                    await ref
                        .read(settingsViewModelProvider.notifier)
                        .updateThemeMode(value);

                    Navigator.of(context).pop();
                  }),
                );
              }),

              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    ThemeModeType themeMode,
    ThemeModeType currentTheme,
    ValueChanged<ThemeModeType> onChanged,
  ) {
    final isSelected = currentTheme == themeMode;

    return InkWell(
      onTap: () => onChanged(themeMode),
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
                    : Theme.of(context).colorScheme.outline.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              _getThemeIcon(themeMode),
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.onSurface,
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                themeMode.displayName,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color:
                      isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                ),
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
