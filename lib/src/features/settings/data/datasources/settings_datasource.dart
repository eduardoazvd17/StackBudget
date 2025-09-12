import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/settings_model.dart';

final settingsDataSourceProvider = Provider<SettingsDataSource>((ref) {
  throw UnimplementedError('Should be overridden in main.dart');
});

class SettingsDataSource {
  static const String _settingsKey = 'app_settings';

  final SharedPreferences _prefs;

  SettingsDataSource(this._prefs);

  Future<SettingsModel> getSettings() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userDoc.exists && userDoc.data() != null) {
          final userData = userDoc.data()!;
          final firebaseSettings = SettingsModel(
            currency: userData['currency'] as String? ?? 'BRL',
            themeMode: ThemeModeType.fromString(
              userData['themeMode'] as String? ?? 'system',
            ),
            language: userData['language'] as String? ?? 'pt',
          );

          await saveSettings(firebaseSettings);
          return firebaseSettings;
        }
      }

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

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'currency': currency},
      );
    }
  }

  Future<void> updateTheme(bool isDarkMode) async {
    final themeMode = isDarkMode ? ThemeModeType.dark : ThemeModeType.light;
    await updateThemeMode(themeMode);
  }

  Future<void> updateThemeMode(ThemeModeType themeMode) async {
    final currentSettings = await getSettings();
    final updatedSettings = currentSettings.copyWith(themeMode: themeMode);
    await saveSettings(updatedSettings);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {
          'themeMode': themeMode.name,
          'isDarkMode':
              themeMode == ThemeModeType.dark, // Mantém compatibilidade
        },
      );
    }
  }

  Future<void> updateLanguage(String language) async {
    final currentSettings = await getSettings();
    final updatedSettings = currentSettings.copyWith(language: language);
    await saveSettings(updatedSettings);

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update(
        {'language': language},
      );
    }
  }

  Future<void> syncSettingsFromFirebase() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final userDoc =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();

        if (userDoc.exists && userDoc.data() != null) {
          final userData = userDoc.data()!;
          final firebaseSettings = SettingsModel(
            currency: userData['currency'] as String? ?? 'BRL',
            themeMode: ThemeModeType.fromString(
              userData['themeMode'] as String? ?? 'system',
            ),
            language: userData['language'] as String? ?? 'pt',
          );

          await saveSettings(firebaseSettings);
        }
      } catch (e) {
      }
    }
  }
}
