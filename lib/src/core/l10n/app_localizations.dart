import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';


abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  String get frequencyOneTime;

  String get frequencyMonthly;

  String get frequencyYearly;

  String get frequencyInstallment;

  String get frequency;

  String get selectFrequency;

  String get selectFrequencyRequired;

  String get monthlySettings;

  String get startMonthField;

  String get endMonthField;

  String get selectStartMonth;

  String get selectEndMonth;

  String get yearlySettings;

  String get yearlyMonthField;

  String get selectYearlyMonth;

  String get selectMonthRequired;

  String get installmentSettings;

  String get totalInstallmentsField;

  String get enterTotalInstallments;

  String get installmentsRequired;

  String get installmentsMinValue;

  String get startDateRequired;

  String get endDateAfterStart;

  String endDateAfterStartSpecific(String startMonth, String startYear);

  String get transactions;

  String get recurringTransactions;

  String get installments;

  String get monthlyTransactions;

  String get noTransactionsFound;

  String get addFirstTransaction;

  String get newTransaction;

  String get titleField;

  String get enterTitle;

  String get titleRequired;

  String get description;

  String get enterDescription;

  String get amountField;

  String get enterAmount;

  String get amountRequired;

  String get amountPositive;

  String get type;

  String get income;

  String get expense;

  String get categoryField;

  String get selectCategory;

  String get save;

  String get cancel;

  String get edit;

  String get delete;

  String get deleteConfirmation;

  String get deleteConfirmationMessage;

  String get yes;

  String get no;

  String get error;

  String get loading;

  String get success;

  String get transactionSaved;

  String get transactionDeleted;

  String get errorSavingTransaction;

  String get errorDeletingTransaction;

  String get errorLoadingTransactions;

  String get unexpectedError;

  String get userNotAuthenticated;

  String get currentInstallment;

  String get ofPreposition;

  String get monthlyInformation;

  String get installmentInformation;

  String get yearlyInformation;

  String get startMonthLabel;

  String get endMonthLabel;

  String get totalAmount;

  String get installmentAmount;

  String get yearlyMonthLabel;

  String get adjustMonthlyValue;

  String get currentValue;

  String get defaultValue;

  String get notes;

  String get enterNotes;

  String get customAmount;

  String get hasAdjustment;

  String get transactionType;

  String get moneyIn;

  String get moneyOut;

  String get saving;

  String get updateTransaction;

  String get saveTransaction;

  String get additionalDetails;

  String get selectStartDate;

  String get selectEndDate;

  String get selectStartDateFirst;

  String get enterInstallments;

  String get installmentsRequiredForm;

  String get installmentsPositive;

  String get selectFirstInstallmentMonth;

  String get installmentValue;

  String get installmentValueForm;

  String get firstInstallmentMonth;

  String get titleHint;

  String get amountHint;

  String get endMonthOptional;

  String get startMonthRequiredLabel;

  String get yearlyMonthRequiredLabel;

  String get totalInstallmentsRequiredLabel;

  String get titleRequiredLabel;

  String get amountRequiredLabel;

  String get categoryRequiredLabel;

  String get dashboardTransactions;

  String get adjusted;

  String get transactionDetails;

  String get editAction;

  String get adjustMonthlyValueAction;

  String get deleteAction;

  String get generalInformation;

  String get dates;

  String get createdAt;

  String get updatedAt;

  String get tags;

  String get confirmDelete;

  String get deletedTransaction;

  String get settings;

  String get appearance;

  String get language;

  String get currency;

  String get retry;

  String get darkMode;

  String get lightMode;

  String get portuguese;

  String get english;

  String get brazilianReal;

  String get usDollar;

  String get euro;

  String get selectPeriod;

  String get confirm;

  String get transactionDeletedSuccess;

  String get transactionUpdatedSuccess;

  String adjustValue(String month, String year);

  String get removeAdjustment;

  String get editTransaction;

  String get back;

  String get notFound;

  String get backToTransactions;

  String get profile;

  String get profileComingSoon;

  String get logout;

  String get confirmLogout;

  String get confirmLogoutMessage;

  String get authErrorTitle;

  String get networkErrorTitle;

  String get databaseErrorTitle;

  String get transactionErrorTitle;

  String get budgetErrorTitle;

  String get settingsErrorTitle;

  String get validationErrorTitle;

  String get generalErrorTitle;

  String get userNotFoundError;

  String get wrongPasswordError;

  String get emailAlreadyInUseError;

  String get weakPasswordError;

  String get invalidEmailError;

  String get userDisabledError;

  String get tooManyRequestsError;

  String get operationNotAllowedError;

  String get invalidCredentialError;

  String get authenticationFailedError;

  String get userDataNotFoundError;

  String get signUpFailedError;

  String get signOutFailedError;

  String get getCurrentUserFailedError;

  String get networkError;

  String get connectionTimeoutError;

  String get serverError;

  String get noInternetConnectionError;

  String get firebaseError;

  String get firestoreError;

  String get permissionDeniedError;

  String get documentNotFoundError;

  String get collectionNotFoundError;

  String get transactionNotFoundError;

  String get transactionSaveFailedError;

  String get transactionDeleteFailedError;

  String get transactionUpdateFailedError;

  String get transactionLoadFailedError;

  String get invalidTransactionDataError;

  String get budgetCalculationFailedError;

  String get budgetDataInvalidError;

  String get settingsSaveFailedError;

  String get settingsLoadFailedError;

  String get validationError;

  String get invalidDataError;

  String get requiredFieldMissingError;

  String get unknownError;

  String get dataParsingError;

  String get cacheError;

  String get storageError;

  String get editProfile;

  String get changeName;

  String get changePassword;

  String get deleteAccount;

  String get currentName;

  String get newName;

  String get nameUpdatedSuccess;

  String get currentPassword;

  String get newPassword;

  String get confirmNewPassword;

  String get passwordUpdatedSuccess;

  String get deleteAccountConfirmation;

  String get deleteAccountWarning;

  String get enterCurrentPasswordToDelete;

  String get accountDeletedSuccess;

  String get incorrectPassword;

  String get passwordTooWeak;

  String get passwordsDoNotMatch;

  String get nameRequired;

  String get nameMinLength;

  String get currentPasswordRequired;

  String get newPasswordRequired;

  String get confirmPasswordRequired;

  String get updateName;

  String get updatePassword;

  String get deleteAccountAction;

  String get profileUpdatedError;

  String get passwordUpdateError;

  String get accountDeleteError;

  String get reauthenticationRequired;

  String get dashboard;

  String get appSubtitle;

  String get defaultUserName;

  String get goodMorning;

  String get goodAfternoon;

  String get goodEvening;

  String get systemTheme;

  String get errorLoadingTransaction;

  String get transactionNotFound;

  String get transactionNotFoundDescription;

  String get categorySalary;

  String get categoryFreelance;

  String get categoryInvestment;

  String get categoryBonus;

  String get categoryGiftIncome;

  String get categoryOtherIncome;

  String get categoryHousing;

  String get categoryUtilities;

  String get categoryGroceries;

  String get categoryTransportation;

  String get categoryInsurance;

  String get categoryHealthcare;

  String get categoryDining;

  String get categoryEntertainment;

  String get categoryShopping;

  String get categoryTravel;

  String get categoryHobbies;

  String get categoryFitness;

  String get categoryBeauty;

  String get categoryLoans;

  String get categoryCreditCard;

  String get categoryTaxes;

  String get categoryFees;

  String get categoryEducation;

  String get categoryBooks;

  String get categoryCourses;

  String get categoryChildcare;

  String get categoryPets;

  String get categoryGifts;

  String get categoryCharity;

  String get categoryEmergencyFund;

  String get categoryOther;

  String get errorLoadingData;

  String get noDataFound;

  String get addTransactionsToSeeSummary;

  String get budgetSummary;

  String get currentBalance;

  String get expenses;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'pt'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'pt': return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
