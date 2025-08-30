import '../../data/models/models.dart';

abstract class SettingsViewModelState {
  const SettingsViewModelState();
}

class SettingsInitialState extends SettingsViewModelState {
  const SettingsInitialState();
}

class SettingsLoadingState extends SettingsViewModelState {
  const SettingsLoadingState();
}

class SettingsLoadedState extends SettingsViewModelState {
  final SettingsModel settings;

  const SettingsLoadedState(this.settings);

  SettingsLoadedState copyWith({
    SettingsModel? settings,
  }) {
    return SettingsLoadedState(
      settings ?? this.settings,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsLoadedState && other.settings == settings;
  }

  @override
  int get hashCode => settings.hashCode;
}

class SettingsErrorState extends SettingsViewModelState {
  final String message;

  const SettingsErrorState({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SettingsErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
