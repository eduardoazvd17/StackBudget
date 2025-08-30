import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('pt')
  ];

  /// Label for one-time transaction frequency
  ///
  /// In en, this message translates to:
  /// **'One-time'**
  String get frequencyOneTime;

  /// Label for monthly transaction frequency
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get frequencyMonthly;

  /// Label for yearly transaction frequency
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get frequencyYearly;

  /// Label for installment transaction frequency
  ///
  /// In en, this message translates to:
  /// **'Installment'**
  String get frequencyInstallment;

  /// Label for frequency field
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// Hint text for frequency dropdown
  ///
  /// In en, this message translates to:
  /// **'Select frequency'**
  String get selectFrequency;

  /// Validation message for frequency field
  ///
  /// In en, this message translates to:
  /// **'Please select a frequency'**
  String get selectFrequencyRequired;

  /// Title for monthly transaction settings
  ///
  /// In en, this message translates to:
  /// **'Monthly Settings'**
  String get monthlySettings;

  /// Label for start month field
  ///
  /// In en, this message translates to:
  /// **'Start Month'**
  String get startMonth;

  /// Label for end month field
  ///
  /// In en, this message translates to:
  /// **'End Month'**
  String get endMonth;

  /// Hint text for start month field
  ///
  /// In en, this message translates to:
  /// **'Select start month'**
  String get selectStartMonth;

  /// Hint text for end month field
  ///
  /// In en, this message translates to:
  /// **'Select end month'**
  String get selectEndMonth;

  /// Title for yearly transaction settings
  ///
  /// In en, this message translates to:
  /// **'Yearly Settings'**
  String get yearlySettings;

  /// Label for yearly month field
  ///
  /// In en, this message translates to:
  /// **'Yearly Month'**
  String get yearlyMonth;

  /// Hint text for yearly month field
  ///
  /// In en, this message translates to:
  /// **'Select the month it occurs yearly'**
  String get selectYearlyMonth;

  /// Validation message for month selection
  ///
  /// In en, this message translates to:
  /// **'Please select a month'**
  String get selectMonthRequired;

  /// Title for installment transaction settings
  ///
  /// In en, this message translates to:
  /// **'Installment Settings'**
  String get installmentSettings;

  /// Label for total installments field
  ///
  /// In en, this message translates to:
  /// **'Total Installments'**
  String get totalInstallments;

  /// Hint text for total installments field
  ///
  /// In en, this message translates to:
  /// **'Enter total number of installments'**
  String get enterTotalInstallments;

  /// Validation message for installments field
  ///
  /// In en, this message translates to:
  /// **'Number of installments is required'**
  String get installmentsRequired;

  /// Validation message for minimum installments
  ///
  /// In en, this message translates to:
  /// **'Must be at least 2 installments'**
  String get installmentsMinValue;

  /// Validation message for start date
  ///
  /// In en, this message translates to:
  /// **'Please select a start date'**
  String get startDateRequired;

  /// Validation message for end date validation
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get endDateAfterStart;

  /// Validation message for end date with specific start date
  ///
  /// In en, this message translates to:
  /// **'Must be after {startMonth}/{startYear}'**
  String endDateAfterStartSpecific(String startMonth, String startYear);

  /// Title for transactions section
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// Title for recurring transactions section
  ///
  /// In en, this message translates to:
  /// **'Recurring Transactions'**
  String get recurringTransactions;

  /// Title for installments section
  ///
  /// In en, this message translates to:
  /// **'Installments'**
  String get installments;

  /// Title for monthly transactions section
  ///
  /// In en, this message translates to:
  /// **'Monthly Transactions'**
  String get monthlyTransactions;

  /// Message when no transactions are found
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// Message encouraging user to add first transaction
  ///
  /// In en, this message translates to:
  /// **'Add your first transaction to get started'**
  String get addFirstTransaction;

  /// Label for new transaction button
  ///
  /// In en, this message translates to:
  /// **'New Transaction'**
  String get newTransaction;

  /// Label for title field
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// Hint text for title field
  ///
  /// In en, this message translates to:
  /// **'Enter transaction title'**
  String get enterTitle;

  /// Label for required title
  ///
  /// In en, this message translates to:
  /// **'Title *'**
  String get titleRequired;

  /// Label for description field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// Hint text for description field
  ///
  /// In en, this message translates to:
  /// **'Enter description (optional)'**
  String get enterDescription;

  /// Label for amount field
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// Hint text for amount field
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// Label for required amount
  ///
  /// In en, this message translates to:
  /// **'Amount *'**
  String get amountRequired;

  /// Validation message for positive amount
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than zero'**
  String get amountPositive;

  /// Label for transaction type
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// Label for income transaction type
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// Label for expense transaction type
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// Label for category field
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// Hint text for category field
  ///
  /// In en, this message translates to:
  /// **'Select category (optional)'**
  String get selectCategory;

  /// Label for save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Label for cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Label for edit action
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Label for delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Title for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get deleteConfirmation;

  /// Message for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this transaction? This action cannot be undone.'**
  String get deleteConfirmationMessage;

  /// Label for yes button
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// Label for no button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Label for error
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Label for loading state
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Label for success state
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Message when transaction is saved successfully
  ///
  /// In en, this message translates to:
  /// **'Transaction saved successfully'**
  String get transactionSaved;

  /// Message when transaction is deleted successfully
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted successfully'**
  String get transactionDeleted;

  /// Message when there's an error saving transaction
  ///
  /// In en, this message translates to:
  /// **'Error saving transaction'**
  String get errorSavingTransaction;

  /// Message when there's an error deleting transaction
  ///
  /// In en, this message translates to:
  /// **'Error deleting transaction'**
  String get errorDeletingTransaction;

  /// Error message when loading transactions fails
  ///
  /// In en, this message translates to:
  /// **'Error loading transactions'**
  String get errorLoadingTransactions;

  /// Message for unexpected errors
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get unexpectedError;

  /// Message when user is not authenticated
  ///
  /// In en, this message translates to:
  /// **'User not authenticated'**
  String get userNotAuthenticated;

  /// Label for current installment
  ///
  /// In en, this message translates to:
  /// **'Current Installment'**
  String get currentInstallment;

  /// Preposition used in installment display
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get ofPreposition;

  /// Title for monthly information section
  ///
  /// In en, this message translates to:
  /// **'Monthly Information'**
  String get monthlyInformation;

  /// Title for installment information section
  ///
  /// In en, this message translates to:
  /// **'Installment Information'**
  String get installmentInformation;

  /// Title for yearly information section
  ///
  /// In en, this message translates to:
  /// **'Yearly Information'**
  String get yearlyInformation;

  /// Label for start month in details
  ///
  /// In en, this message translates to:
  /// **'Start Month'**
  String get startMonthLabel;

  /// Label for end month in details
  ///
  /// In en, this message translates to:
  /// **'End Month'**
  String get endMonthLabel;

  /// Label for total amount
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// Label for installment amount
  ///
  /// In en, this message translates to:
  /// **'Installment Amount'**
  String get installmentAmount;

  /// Label for yearly month in details
  ///
  /// In en, this message translates to:
  /// **'Yearly Month'**
  String get yearlyMonthLabel;

  /// Label for adjust monthly value action
  ///
  /// In en, this message translates to:
  /// **'Adjust this month\'s value'**
  String get adjustMonthlyValue;

  /// Label for current value
  ///
  /// In en, this message translates to:
  /// **'Current Value'**
  String get currentValue;

  /// Label for default value
  ///
  /// In en, this message translates to:
  /// **'Default Value'**
  String get defaultValue;

  /// Label for notes field
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// Hint text for notes field
  ///
  /// In en, this message translates to:
  /// **'Enter notes (optional)'**
  String get enterNotes;

  /// Label for custom amount
  ///
  /// In en, this message translates to:
  /// **'Custom Amount'**
  String get customAmount;

  /// Label indicating transaction has monthly adjustment
  ///
  /// In en, this message translates to:
  /// **'Has adjustment'**
  String get hasAdjustment;

  /// Label for transaction type selector
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionType;

  /// Subtitle for income type
  ///
  /// In en, this message translates to:
  /// **'Money coming in'**
  String get moneyIn;

  /// Subtitle for expense type
  ///
  /// In en, this message translates to:
  /// **'Money going out'**
  String get moneyOut;

  /// Text for saving state
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// Label for update transaction button
  ///
  /// In en, this message translates to:
  /// **'Update Transaction'**
  String get updateTransaction;

  /// Label for save transaction button
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get saveTransaction;

  /// Hint text for description field
  ///
  /// In en, this message translates to:
  /// **'Additional details (optional)'**
  String get additionalDetails;

  /// Hint text for start date selection
  ///
  /// In en, this message translates to:
  /// **'Select when to start'**
  String get selectStartDate;

  /// Hint text for end date selection
  ///
  /// In en, this message translates to:
  /// **'Select end date'**
  String get selectEndDate;

  /// Message when trying to select end date without start date
  ///
  /// In en, this message translates to:
  /// **'Select start date first'**
  String get selectStartDateFirst;

  /// Hint text for installments field
  ///
  /// In en, this message translates to:
  /// **'Enter number of installments'**
  String get enterInstallments;

  /// Validation message for positive installments
  ///
  /// In en, this message translates to:
  /// **'Must be a number greater than zero'**
  String get installmentsPositive;

  /// Hint text for first installment month selection
  ///
  /// In en, this message translates to:
  /// **'Select the month of the first installment'**
  String get selectFirstInstallmentMonth;

  /// Label for installment value
  ///
  /// In en, this message translates to:
  /// **'Installment value'**
  String get installmentValue;

  /// Label for first installment month
  ///
  /// In en, this message translates to:
  /// **'1st Installment Month'**
  String get firstInstallmentMonth;

  /// Hint text for title field
  ///
  /// In en, this message translates to:
  /// **'Ex: Salary, Rent, Groceries...'**
  String get titleHint;

  /// Hint text for amount field
  ///
  /// In en, this message translates to:
  /// **'R\$ 0.00'**
  String get amountHint;

  /// Label for optional end month
  ///
  /// In en, this message translates to:
  /// **'End Month (optional)'**
  String get endMonthOptional;

  /// Label for required start month
  ///
  /// In en, this message translates to:
  /// **'Start Month *'**
  String get startMonthRequired;

  /// Label for required yearly month
  ///
  /// In en, this message translates to:
  /// **'Yearly Month *'**
  String get yearlyMonthRequired;

  /// Label for required total installments
  ///
  /// In en, this message translates to:
  /// **'Total Installments *'**
  String get totalInstallmentsRequired;

  /// Label for required category
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get categoryRequired;

  /// Title for transactions section in dashboard
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get dashboardTransactions;

  /// Label indicating transaction has been adjusted
  ///
  /// In en, this message translates to:
  /// **'Adjusted'**
  String get adjusted;

  /// Title for transaction details screen
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// Title for general information section
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInformation;

  /// Title for dates section
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dates;

  /// Label for creation date
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get createdAt;

  /// Label for update date
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get updatedAt;

  /// Label for tags
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// Title for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// Label for deleted transaction
  ///
  /// In en, this message translates to:
  /// **'Deleted transaction'**
  String get deletedTransaction;
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


  // Lookup logic when only language code is specified.
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
