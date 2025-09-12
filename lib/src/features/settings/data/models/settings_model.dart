enum ThemeModeType {
  system,
  light,
  dark;

  bool get isSystem => this == ThemeModeType.system;
  bool get isLight => this == ThemeModeType.light;
  bool get isDark => this == ThemeModeType.dark;

  String get displayName {
    switch (this) {
      case ThemeModeType.system:
        return 'Sistema';
      case ThemeModeType.light:
        return 'Claro';
      case ThemeModeType.dark:
        return 'Escuro';
    }
  }

  static ThemeModeType fromString(String value) {
    return ThemeModeType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ThemeModeType.system,
    );
  }
}

class SettingsModel {
  final String currency;
  final ThemeModeType themeMode;
  final String language;

  const SettingsModel({
    required this.currency,
    required this.themeMode,
    required this.language,
  });

  bool get isDarkMode => themeMode == ThemeModeType.dark;

  SettingsModel copyWith({
    String? currency,
    ThemeModeType? themeMode,
    String? language,
  }) {
    return SettingsModel(
      currency: currency ?? this.currency,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'themeMode': themeMode.name,
      'isDarkMode': isDarkMode, // Mantém compatibilidade com versões anteriores
      'language': language,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    ThemeModeType themeMode;
    if (json.containsKey('themeMode')) {
      themeMode = ThemeModeType.fromString(
        json['themeMode'] as String? ?? 'system',
      );
    } else {
      final isDarkMode = json['isDarkMode'] as bool? ?? false;
      themeMode = isDarkMode ? ThemeModeType.dark : ThemeModeType.light;
    }

    return SettingsModel(
      currency: json['currency'] as String? ?? 'BRL',
      themeMode: themeMode,
      language: json['language'] as String? ?? 'pt',
    );
  }

  factory SettingsModel.defaultSettings() {
    return const SettingsModel(
      currency: 'BRL',
      themeMode: ThemeModeType.system, // Primeiro uso sempre será system
      language: 'pt',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsModel &&
        other.currency == currency &&
        other.themeMode == themeMode &&
        other.language == language;
  }

  @override
  int get hashCode =>
      currency.hashCode ^ themeMode.hashCode ^ language.hashCode;

  @override
  String toString() {
    return 'SettingsModel(currency: $currency, themeMode: $themeMode, language: $language)';
  }
}
