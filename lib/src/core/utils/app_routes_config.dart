class AppRoutesConfig {
  AppRoutesConfig._();

  static const String auth = 'auth';

  static const String transactions = 'transactions';
  static const String transactionDetail = 'transaction-detail';
  static const String addTransaction = 'add';
  static const String editTransaction = 'edit';

  static const String budget = 'budget';
  static const String profile = 'profile';
  static const String settings = 'settings';
  static const String reports = 'reports';

  static const String authPath = '/$auth';
  static const String transactionsPath = '/$transactions';
  static const String addTransactionPath = '/$transactions/$addTransaction';
  static const String settingsPath = '/$transactions/$settings';
  static const String profilePath = '/$transactions/$profile';
  static const String budgetPath = '/$budget';
  static const String reportsPath = '/$reports';
}

