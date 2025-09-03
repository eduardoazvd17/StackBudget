import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/datasources.dart';
import '../../data/repositories/repositories.dart';
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
      await _repository.updateTheme(isDarkMode);
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
