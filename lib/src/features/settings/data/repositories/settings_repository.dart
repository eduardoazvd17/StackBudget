import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

// Provider
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final dataSource = ref.watch(settingsDataSourceProvider);
  return SettingsRepository(dataSource);
});

class SettingsRepository {
  final SettingsDataSource _dataSource;

  SettingsRepository(this._dataSource);

  Future<SettingsModel> getSettings() async {
    return await _dataSource.getSettings();
  }

  Future<void> saveSettings(SettingsModel settings) async {
    await _dataSource.saveSettings(settings);
  }

  Future<void> updateCurrency(String currency) async {
    await _dataSource.updateCurrency(currency);
  }

  Future<void> updateTheme(bool isDarkMode) async {
    await _dataSource.updateTheme(isDarkMode);
  }

  Future<void> updateThemeMode(ThemeModeType themeMode) async {
    await _dataSource.updateThemeMode(themeMode);
  }

  Future<void> updateLanguage(String language) async {
    await _dataSource.updateLanguage(language);
  }

  Future<void> syncSettingsFromFirebase() async {
    await _dataSource.syncSettingsFromFirebase();
  }
}
