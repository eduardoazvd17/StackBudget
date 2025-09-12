import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/datasources.dart';
import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';
import 'settings_view_model_state.dart';

class SettingsViewModel extends StateNotifier<SettingsViewModelState> {
  final SettingsRepository _repository;

  SettingsViewModel(this._repository) : super(const SettingsInitialState());

  Future<void> loadSettings() async {
    try {
      state = const SettingsLoadingState();
      final settings = await _repository.getSettings();
      state = SettingsLoadedState(settings);
    } catch (e) {
      state = SettingsErrorState(message: e.toString());
    }
  }

  Future<void> updateCurrency(String currency) async {
    try {
      await _repository.updateCurrency(currency);
      await loadSettings(); // Recarrega as configurações
    } catch (e) {
      state = SettingsErrorState(message: e.toString());
    }
  }

  Future<void> updateTheme(bool isDarkMode) async {
    try {
      // Mantém compatibilidade com código existente
      final themeMode = isDarkMode ? ThemeModeType.dark : ThemeModeType.light;
      await _repository.updateThemeMode(themeMode);
      await loadSettings(); // Recarrega as configurações
    } catch (e) {
      state = SettingsErrorState(message: e.toString());
    }
  }

  Future<void> updateThemeMode(ThemeModeType themeMode) async {
    try {
      await _repository.updateThemeMode(themeMode);
      await loadSettings(); // Recarrega as configurações
    } catch (e) {
      state = SettingsErrorState(message: e.toString());
    }
  }

  Future<void> updateLanguage(String language) async {
    try {
      await _repository.updateLanguage(language);
      await loadSettings(); // Recarrega as configurações
    } catch (e) {
      state = SettingsErrorState(message: e.toString());
    }
  }

  Future<void> syncSettingsFromFirebase() async {
    try {
      await _repository.syncSettingsFromFirebase();
      await loadSettings(); // Recarrega as configurações após sincronização
    } catch (e) {
      // Ignora erros de sincronização para não interromper o fluxo
    }
  }
}

// Providers
final settingsDataSourceProvider = Provider<SettingsDataSource>((ref) {
  throw UnimplementedError('Should be overridden in main.dart');
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dataSource = ref.watch(settingsDataSourceProvider);
  return SettingsRepository(dataSource);
});

final settingsViewModelProvider =
    StateNotifierProvider<SettingsViewModel, SettingsViewModelState>(
      (ref) => SettingsViewModel(ref.watch(settingsRepositoryProvider)),
    );

// Provider dedicado para o tema
final themeModeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((
  ref,
) {
  final notifier = ThemeNotifier(ref);
  // Carregar configurações iniciais
  ref.listen(settingsViewModelProvider, (previous, next) {
    if (next is SettingsLoadedState) {
      notifier.updateThemeModeFromType(next.settings.themeMode);
    }
  });
  return notifier;
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  final Ref _ref;

  ThemeNotifier(this._ref) : super(ThemeMode.system) {
    _loadInitialTheme();
  }

  Future<void> _loadInitialTheme() async {
    try {
      final settings =
          await _ref.read(settingsRepositoryProvider).getSettings();
      updateThemeModeFromType(settings.themeMode);
    } catch (e) {
      // Mantém o tema padrão em caso de erro
      state = ThemeMode.system;
    }
  }

  void updateThemeModeFromType(ThemeModeType themeModeType) {
    switch (themeModeType) {
      case ThemeModeType.system:
        state = ThemeMode.system;
        break;
      case ThemeModeType.light:
        state = ThemeMode.light;
        break;
      case ThemeModeType.dark:
        state = ThemeMode.dark;
        break;
    }
  }

  // Mantém compatibilidade com código existente
  void updateThemeMode(bool isDarkMode) {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
    } else if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    }
    // Se estiver no modo system, alterna para dark
    else {
      state = ThemeMode.dark;
    }
  }
}
