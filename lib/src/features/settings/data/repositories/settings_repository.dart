import '../datasources/datasources.dart';
import '../models/models.dart';

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

  Future<void> updateLanguage(String language) async {
    await _dataSource.updateLanguage(language);
  }

  Future<void> syncSettingsFromFirebase() async {
    await _dataSource.syncSettingsFromFirebase();
  }
}
