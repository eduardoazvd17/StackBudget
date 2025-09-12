import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/repositories.dart';
import '../view_models/settings_view_model.dart';
import '../view_models/settings_view_model_state.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier(ref);
});

class LocaleNotifier extends StateNotifier<Locale> {
  final Ref _ref;

  LocaleNotifier(this._ref) : super(const Locale('pt')) {
    // Carregar configurações iniciais
    _loadInitialSettings();

    // Escuta mudanças nas configurações
    _ref.listen(settingsViewModelProvider, (previous, next) {
      if (next is SettingsLoadedState) {
        final language = next.settings.language;
        final locale =
            language == 'pt' ? const Locale('pt') : const Locale('en');
        state = locale;
      }
    });
  }

  Future<void> _loadInitialSettings() async {
    try {
      final settings =
          await _ref.read(settingsRepositoryProvider).getSettings();
      final language = settings.language;
      final locale = language == 'pt' ? const Locale('pt') : const Locale('en');
      state = locale;
    } catch (e) {
      // Mantém o locale padrão em caso de erro
      state = const Locale('pt');
    }
  }
}
