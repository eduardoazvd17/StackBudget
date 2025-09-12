import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/repositories.dart';
import '../view_models/settings_view_model.dart';
import '../view_models/settings_view_model_state.dart';

final currencyProvider = StateNotifierProvider<CurrencyNotifier, String>((ref) {
  return CurrencyNotifier(ref);
});

class CurrencyNotifier extends StateNotifier<String> {
  final Ref _ref;

  CurrencyNotifier(this._ref) : super('BRL') {
    _loadInitialSettings();

    _ref.listen(settingsViewModelProvider, (previous, next) {
      if (next is SettingsLoadedState) {
        state = next.settings.currency;
      }
    });
  }

  Future<void> _loadInitialSettings() async {
    try {
      final settings =
          await _ref.read(settingsRepositoryProvider).getSettings();
      state = settings.currency;
    } catch (e) {
      state = 'BRL';
    }
  }

  Future<void> updateCurrency(String currency) async {
    await _ref
        .read(settingsViewModelProvider.notifier)
        .updateCurrency(currency);
  }
}
