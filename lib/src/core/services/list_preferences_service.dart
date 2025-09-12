import 'package:shared_preferences/shared_preferences.dart';

class ListPreferencesService {
  static const String _recurringTransactionsKey =
      'recurring_transactions_expanded';
  static const String _installmentTransactionsKey =
      'installment_transactions_expanded';
  static const String _oneTimeTransactionsKey =
      'one_time_transactions_expanded';

  static ListPreferencesService? _instance;
  late final SharedPreferences _prefs;

  ListPreferencesService._(this._prefs);

  static Future<ListPreferencesService> getInstance() async {
    if (_instance == null) {
      final prefs = await SharedPreferences.getInstance();
      _instance = ListPreferencesService._(prefs);
    }
    return _instance!;
  }

  Future<bool> getRecurringTransactionsExpanded() async {
    final value = _prefs.getBool(_recurringTransactionsKey) ?? true;
    return value;
  }

  Future<void> setRecurringTransactionsExpanded(bool expanded) async {
    await _prefs.setBool(_recurringTransactionsKey, expanded);
  }

  Future<bool> getInstallmentTransactionsExpanded() async {
    final value = _prefs.getBool(_installmentTransactionsKey) ?? true;
    return value;
  }

  Future<void> setInstallmentTransactionsExpanded(bool expanded) async {
    await _prefs.setBool(_installmentTransactionsKey, expanded);
  }

  Future<bool> getOneTimeTransactionsExpanded() async {
    final value = _prefs.getBool(_oneTimeTransactionsKey) ?? true;
    return value;
  }

  Future<void> setOneTimeTransactionsExpanded(bool expanded) async {
    await _prefs.setBool(_oneTimeTransactionsKey, expanded);
  }
}
