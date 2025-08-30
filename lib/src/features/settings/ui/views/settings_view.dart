import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/l10n/app_localizations.dart';
import '../view_models/settings_view_model.dart';
import '../view_models/settings_view_model_state.dart';
import 'widgets/currency_selector.dart';
import 'widgets/language_selector.dart';
import 'widgets/theme_selector.dart';

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(settingsViewModelProvider.notifier).loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsViewModelProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _buildBody(state, l10n),
    );
  }

  Widget _buildBody(SettingsViewModelState state, AppLocalizations l10n) {
    if (state is SettingsInitialState || state is SettingsLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is SettingsLoadedState) {
      return _buildSettingsList(state, l10n);
    } else if (state is SettingsErrorState) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.read(settingsViewModelProvider.notifier).loadSettings();
              },
              child: Text(l10n.retry),
            ),
          ],
        ),
      );
    }
    
    return const SizedBox.shrink();
  }

  Widget _buildSettingsList(SettingsLoadedState state, AppLocalizations l10n) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSection(
          title: l10n.appearance,
          children: [
            ThemeSelector(
              isDarkMode: state.settings.isDarkMode,
              onChanged: (isDarkMode) {
                ref.read(settingsViewModelProvider.notifier).updateTheme(isDarkMode);
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: l10n.language,
          children: [
            LanguageSelector(
              currentLanguage: state.settings.language,
              onChanged: (language) {
                ref.read(settingsViewModelProvider.notifier).updateLanguage(language);
              },
            ),
          ],
        ),
        const SizedBox(height: 24),
        _buildSection(
          title: l10n.currency,
          children: [
            CurrencySelector(
              currentCurrency: state.settings.currency,
              onChanged: (currency) {
                ref.read(settingsViewModelProvider.notifier).updateCurrency(currency);
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}
