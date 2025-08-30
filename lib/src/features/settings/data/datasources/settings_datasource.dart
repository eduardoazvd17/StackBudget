import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/models/models.dart';

class SettingsDataSource {
  static const String _settingsKey = 'app_settings';

  final SharedPreferences _prefs;

  SettingsDataSource(this._prefs);

  Future<SettingsModel> getSettings() async {
    try {
      final settingsJson = _prefs.getString(_settingsKey);
      if (settingsJson != null) {
        final settingsMap = json.decode(settingsJson) as Map<String, dynamic>;
        return SettingsModel.fromJson(settingsMap);
      }
      return SettingsModel.defaultSettings();
    } catch (e) {
      return SettingsModel.defaultSettings();
    }
  }

  Future<void> saveSettings(SettingsModel settings) async {
    try {
      final settingsJson = json.encode(settings.toJson());
      await _prefs.setString(_settingsKey, settingsJson);
    } catch (e) {
      throw Exception('Failed to save settings: $e');
    }
  }

  Future<void> updateCurrency(String currency) async {
    final currentSettings = await getSettings();
    final updatedSettings = currentSettings.copyWith(currency: currency);
    await saveSettings(updatedSettings);
    
    // Atualizar também no Firebase
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'currency': currency});
    }
  }

  Future<void> updateTheme(bool isDarkMode) async {
    final currentSettings = await getSettings();
    final updatedSettings = currentSettings.copyWith(isDarkMode: isDarkMode);
    await saveSettings(updatedSettings);
  }

  Future<void> updateLanguage(String language) async {
    final currentSettings = await getSettings();
    final updatedSettings = currentSettings.copyWith(language: language);
    await saveSettings(updatedSettings);
  }
}
