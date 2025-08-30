class SettingsModel {
  final String currency;
  final bool isDarkMode;
  final String language;

  const SettingsModel({
    required this.currency,
    required this.isDarkMode,
    required this.language,
  });

  SettingsModel copyWith({
    String? currency,
    bool? isDarkMode,
    String? language,
  }) {
    return SettingsModel(
      currency: currency ?? this.currency,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currency': currency,
      'isDarkMode': isDarkMode,
      'language': language,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      currency: json['currency'] as String? ?? 'BRL',
      isDarkMode: json['isDarkMode'] as bool? ?? false,
      language: json['language'] as String? ?? 'pt',
    );
  }

  factory SettingsModel.defaultSettings() {
    return const SettingsModel(
      currency: 'BRL',
      isDarkMode: false,
      language: 'pt',
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsModel &&
        other.currency == currency &&
        other.isDarkMode == isDarkMode &&
        other.language == language;
  }

  @override
  int get hashCode => currency.hashCode ^ isDarkMode.hashCode ^ language.hashCode;

  @override
  String toString() {
    return 'SettingsModel(currency: $currency, isDarkMode: $isDarkMode, language: $language)';
  }
}
