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
  String get startMonthField;

  /// Label for end month field
  ///
  /// In en, this message translates to:
  /// **'End Month'**
  String get endMonthField;

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
  String get yearlyMonthField;

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
  String get totalInstallmentsField;

  /// Hint text for total installments field
  ///
  /// In en, this message translates to:
  /// **'Enter total number of installments'**
  String get enterTotalInstallments;

  /// Validation message for installments field
  ///
  /// In en, this message translates to:
  /// **'Please enter the number of installments'**
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
  String get titleField;

  /// Hint text for title field
  ///
  /// In en, this message translates to:
  /// **'Enter transaction title'**
  String get enterTitle;

  /// Validation message for title field
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
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
  String get amountField;

  /// Hint text for amount field
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// Validation message for amount field
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
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
  String get categoryField;

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

  /// Label for edit button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Label for delete button
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

  /// Message when there's an error loading transactions
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

  /// Label for adjust monthly value button
  ///
  /// In en, this message translates to:
  /// **'Adjust Monthly Value'**
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

  /// Validation message for installments field in form
  ///
  /// In en, this message translates to:
  /// **'Number of installments is required'**
  String get installmentsRequiredForm;

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

  /// Label for installment value in form
  ///
  /// In en, this message translates to:
  /// **'Installment value'**
  String get installmentValueForm;

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
  String get startMonthRequiredLabel;

  /// Label for required yearly month
  ///
  /// In en, this message translates to:
  /// **'Yearly Month *'**
  String get yearlyMonthRequiredLabel;

  /// Label for required total installments
  ///
  /// In en, this message translates to:
  /// **'Total Installments *'**
  String get totalInstallmentsRequiredLabel;

  /// Label for required title
  ///
  /// In en, this message translates to:
  /// **'Title *'**
  String get titleRequiredLabel;

  /// Label for required amount
  ///
  /// In en, this message translates to:
  /// **'Amount *'**
  String get amountRequiredLabel;

  /// Label for required category
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get categoryRequiredLabel;

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

  /// Label for edit action
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// Label for adjust monthly value action
  ///
  /// In en, this message translates to:
  /// **'Adjust this month\'s value'**
  String get adjustMonthlyValueAction;

  /// Label for delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

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

  /// Title for settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Title for appearance settings section
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Title for language settings section
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Title for currency settings section
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// Label for retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Label for dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Label for light mode setting
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Label for Portuguese language
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// Label for English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Label for Brazilian Real currency
  ///
  /// In en, this message translates to:
  /// **'Brazilian Real (R\$)'**
  String get brazilianReal;

  /// Label for US Dollar currency
  ///
  /// In en, this message translates to:
  /// **'US Dollar (\$)'**
  String get usDollar;

  /// Label for Euro currency
  ///
  /// In en, this message translates to:
  /// **'Euro (€)'**
  String get euro;

  /// Title for period selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get selectPeriod;

  /// Label for confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Success message when transaction is deleted
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted successfully!'**
  String get transactionDeletedSuccess;

  /// Success message when transaction is updated
  ///
  /// In en, this message translates to:
  /// **'Transaction updated successfully!'**
  String get transactionUpdatedSuccess;

  /// Title for adjust value dialog
  ///
  /// In en, this message translates to:
  /// **'Adjust Value - {month}/{year}'**
  String adjustValue(String month, String year);

  /// Label for remove adjustment button
  ///
  /// In en, this message translates to:
  /// **'Remove Adjustment'**
  String get removeAdjustment;

  /// Title for edit transaction screen
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get editTransaction;

  /// Label for back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Label for not found state
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// Label for back to transactions button
  ///
  /// In en, this message translates to:
  /// **'Back to Transactions'**
  String get backToTransactions;

  /// Label for profile screen
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Message for profile feature coming soon
  ///
  /// In en, this message translates to:
  /// **'Profile - Coming soon!'**
  String get profileComingSoon;

  /// Label for logout option
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Title for logout confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// Message for logout confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout from your account?\n\nYou will need to login again to access the app.'**
  String get confirmLogoutMessage;

  /// Title for authentication errors
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get authErrorTitle;

  /// Title for network errors
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get networkErrorTitle;

  /// Title for database errors
  ///
  /// In en, this message translates to:
  /// **'Database Error'**
  String get databaseErrorTitle;

  /// Title for transaction errors
  ///
  /// In en, this message translates to:
  /// **'Transaction Error'**
  String get transactionErrorTitle;

  /// Title for budget errors
  ///
  /// In en, this message translates to:
  /// **'Budget Error'**
  String get budgetErrorTitle;

  /// Title for settings errors
  ///
  /// In en, this message translates to:
  /// **'Settings Error'**
  String get settingsErrorTitle;

  /// Title for validation errors
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationErrorTitle;

  /// Title for general errors
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get generalErrorTitle;

  /// Error message when user is not found
  ///
  /// In en, this message translates to:
  /// **'User not found. Please check your email and try again.'**
  String get userNotFoundError;

  /// Error message for wrong password
  ///
  /// In en, this message translates to:
  /// **'Wrong password. Please check your password and try again.'**
  String get wrongPasswordError;

  /// Error message when email is already in use
  ///
  /// In en, this message translates to:
  /// **'This email is already being used by another account.'**
  String get emailAlreadyInUseError;

  /// Error message for weak password
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long.'**
  String get weakPasswordError;

  /// Error message for invalid email
  ///
  /// In en, this message translates to:
  /// **'The email provided is not valid.'**
  String get invalidEmailError;

  /// Error message for disabled user
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Please contact support.'**
  String get userDisabledError;

  /// Error message for too many requests
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts. Please try again in a few minutes.'**
  String get tooManyRequestsError;

  /// Error message for operation not allowed
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed. Please check your settings.'**
  String get operationNotAllowedError;

  /// Error message for invalid credentials
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Please check your information and try again.'**
  String get invalidCredentialError;

  /// Error message for authentication failure
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please try again.'**
  String get authenticationFailedError;

  /// Error message when user data is not found
  ///
  /// In en, this message translates to:
  /// **'User data not found.'**
  String get userDataNotFoundError;

  /// Error message for sign up failure
  ///
  /// In en, this message translates to:
  /// **'Failed to create account. Please try again.'**
  String get signUpFailedError;

  /// Error message for sign out failure
  ///
  /// In en, this message translates to:
  /// **'Error signing out. Please try again.'**
  String get signOutFailedError;

  /// Error message for get current user failure
  ///
  /// In en, this message translates to:
  /// **'Error retrieving user data.'**
  String get getCurrentUserFailedError;

  /// Error message for network issues
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your internet and try again.'**
  String get networkError;

  /// Error message for connection timeout
  ///
  /// In en, this message translates to:
  /// **'Connection timeout. Please try again.'**
  String get connectionTimeoutError;

  /// Error message for server errors
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again in a few minutes.'**
  String get serverError;

  /// Error message for no internet connection
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your connection.'**
  String get noInternetConnectionError;

  /// Error message for Firebase errors
  ///
  /// In en, this message translates to:
  /// **'Service error. Please try again in a few minutes.'**
  String get firebaseError;

  /// Error message for Firestore errors
  ///
  /// In en, this message translates to:
  /// **'Database error. Please try again.'**
  String get firestoreError;

  /// Error message for permission denied
  ///
  /// In en, this message translates to:
  /// **'Access denied. Please check your permissions.'**
  String get permissionDeniedError;

  /// Error message for document not found
  ///
  /// In en, this message translates to:
  /// **'Document not found.'**
  String get documentNotFoundError;

  /// Error message for collection not found
  ///
  /// In en, this message translates to:
  /// **'Collection not found.'**
  String get collectionNotFoundError;

  /// Error message for transaction not found
  ///
  /// In en, this message translates to:
  /// **'Transaction not found.'**
  String get transactionNotFoundError;

  /// Error message for transaction save failure
  ///
  /// In en, this message translates to:
  /// **'Error saving transaction. Please try again.'**
  String get transactionSaveFailedError;

  /// Error message for transaction delete failure
  ///
  /// In en, this message translates to:
  /// **'Error deleting transaction. Please try again.'**
  String get transactionDeleteFailedError;

  /// Error message for transaction update failure
  ///
  /// In en, this message translates to:
  /// **'Error updating transaction. Please try again.'**
  String get transactionUpdateFailedError;

  /// Error message for transaction load failure
  ///
  /// In en, this message translates to:
  /// **'Error loading transactions. Please try again.'**
  String get transactionLoadFailedError;

  /// Error message for invalid transaction data
  ///
  /// In en, this message translates to:
  /// **'Invalid transaction data.'**
  String get invalidTransactionDataError;

  /// Error message for budget calculation failure
  ///
  /// In en, this message translates to:
  /// **'Error calculating budget. Please try again.'**
  String get budgetCalculationFailedError;

  /// Error message for invalid budget data
  ///
  /// In en, this message translates to:
  /// **'Invalid budget data.'**
  String get budgetDataInvalidError;

  /// Error message for settings save failure
  ///
  /// In en, this message translates to:
  /// **'Error saving settings. Please try again.'**
  String get settingsSaveFailedError;

  /// Error message for settings load failure
  ///
  /// In en, this message translates to:
  /// **'Error loading settings. Please try again.'**
  String get settingsLoadFailedError;

  /// Error message for validation errors
  ///
  /// In en, this message translates to:
  /// **'Invalid data. Please check the fields and try again.'**
  String get validationError;

  /// Error message for invalid data
  ///
  /// In en, this message translates to:
  /// **'Invalid data provided.'**
  String get invalidDataError;

  /// Error message for required field missing
  ///
  /// In en, this message translates to:
  /// **'Required field not filled.'**
  String get requiredFieldMissingError;

  /// Error message for unknown errors
  ///
  /// In en, this message translates to:
  /// **'Unknown error. Please try again or contact support.'**
  String get unknownError;

  /// Error message for data parsing errors
  ///
  /// In en, this message translates to:
  /// **'Error processing data. Please try again.'**
  String get dataParsingError;

  /// Error message for cache errors
  ///
  /// In en, this message translates to:
  /// **'Cache error. Please try again.'**
  String get cacheError;

  /// Error message for storage errors
  ///
  /// In en, this message translates to:
  /// **'Storage error. Please try again.'**
  String get storageError;

  /// Title for edit profile screen
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// Label for change name option
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeName;

  /// Label for change password option
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Label for delete account option
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// Label for current name field
  ///
  /// In en, this message translates to:
  /// **'Current Name'**
  String get currentName;

  /// Label for new name field
  ///
  /// In en, this message translates to:
  /// **'New Name'**
  String get newName;

  /// Success message when name is updated
  ///
  /// In en, this message translates to:
  /// **'Name updated successfully!'**
  String get nameUpdatedSuccess;

  /// Label for current password field
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// Label for new password field
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// Label for confirm new password field
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// Success message when password is updated
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get passwordUpdatedSuccess;

  /// Title for delete account confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Delete Account Permanently'**
  String get deleteAccountConfirmation;

  /// Warning message for delete account dialog
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible!\n\nAll your data will be permanently deleted:\n• Transactions\n• Settings\n• Financial history\n\nAre you sure you want to continue?'**
  String get deleteAccountWarning;

  /// Prompt for password confirmation in delete account dialog
  ///
  /// In en, this message translates to:
  /// **'Enter your current password to confirm deletion:'**
  String get enterCurrentPasswordToDelete;

  /// Success message when account is deleted
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully!'**
  String get accountDeletedSuccess;

  /// Error message for incorrect password
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get incorrectPassword;

  /// Error message for weak password
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters, including: 1 uppercase letter, 1 lowercase letter, and 1 special character'**
  String get passwordTooWeak;

  /// Error message when passwords don't match
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// Validation message for required name
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// Validation message for name minimum length
  ///
  /// In en, this message translates to:
  /// **'Name must have at least 2 characters'**
  String get nameMinLength;

  /// Validation message for required current password
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// Validation message for required new password
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get newPasswordRequired;

  /// Validation message for required password confirmation
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get confirmPasswordRequired;

  /// Label for update name button
  ///
  /// In en, this message translates to:
  /// **'Update Name'**
  String get updateName;

  /// Label for update password button
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// Label for delete account button
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountAction;

  /// Error message when profile update fails
  ///
  /// In en, this message translates to:
  /// **'Error updating profile'**
  String get profileUpdatedError;

  /// Error message when password update fails
  ///
  /// In en, this message translates to:
  /// **'Error changing password'**
  String get passwordUpdateError;

  /// Error message when account deletion fails
  ///
  /// In en, this message translates to:
  /// **'Error deleting account'**
  String get accountDeleteError;

  /// Error message when reauthentication is required
  ///
  /// In en, this message translates to:
  /// **'Identity confirmation is required for this action'**
  String get reauthenticationRequired;

  /// Label for dashboard screen
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// App subtitle
  ///
  /// In en, this message translates to:
  /// **'Smart Financial Planning'**
  String get appSubtitle;
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
