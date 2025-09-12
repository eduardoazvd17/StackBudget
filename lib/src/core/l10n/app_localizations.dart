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

  /// No description provided for @frequencyOneTime.
  ///
  /// In en, this message translates to:
  /// **'One-time'**
  String get frequencyOneTime;

  /// No description provided for @frequencyMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get frequencyMonthly;

  /// No description provided for @frequencyYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get frequencyYearly;

  /// No description provided for @frequencyInstallment.
  ///
  /// In en, this message translates to:
  /// **'Installment'**
  String get frequencyInstallment;

  /// No description provided for @frequency.
  ///
  /// In en, this message translates to:
  /// **'Frequency'**
  String get frequency;

  /// No description provided for @selectFrequency.
  ///
  /// In en, this message translates to:
  /// **'Select frequency'**
  String get selectFrequency;

  /// No description provided for @selectFrequencyRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a frequency'**
  String get selectFrequencyRequired;

  /// No description provided for @monthlySettings.
  ///
  /// In en, this message translates to:
  /// **'Monthly Settings'**
  String get monthlySettings;

  /// No description provided for @startMonthField.
  ///
  /// In en, this message translates to:
  /// **'Start Month'**
  String get startMonthField;

  /// No description provided for @endMonthField.
  ///
  /// In en, this message translates to:
  /// **'End Month'**
  String get endMonthField;

  /// No description provided for @selectStartMonth.
  ///
  /// In en, this message translates to:
  /// **'Select start month'**
  String get selectStartMonth;

  /// No description provided for @selectEndMonth.
  ///
  /// In en, this message translates to:
  /// **'Select end month'**
  String get selectEndMonth;

  /// No description provided for @yearlySettings.
  ///
  /// In en, this message translates to:
  /// **'Yearly Settings'**
  String get yearlySettings;

  /// No description provided for @yearlyMonthField.
  ///
  /// In en, this message translates to:
  /// **'Yearly Month'**
  String get yearlyMonthField;

  /// No description provided for @selectYearlyMonth.
  ///
  /// In en, this message translates to:
  /// **'Select the month it occurs yearly'**
  String get selectYearlyMonth;

  /// No description provided for @selectMonthRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a month'**
  String get selectMonthRequired;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get selectMonth;

  /// No description provided for @installmentSettings.
  ///
  /// In en, this message translates to:
  /// **'Installment Settings'**
  String get installmentSettings;

  /// No description provided for @totalInstallmentsField.
  ///
  /// In en, this message translates to:
  /// **'Total Installments'**
  String get totalInstallmentsField;

  /// No description provided for @enterTotalInstallments.
  ///
  /// In en, this message translates to:
  /// **'Enter total number of installments'**
  String get enterTotalInstallments;

  /// No description provided for @installmentsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter the number of installments'**
  String get installmentsRequired;

  /// No description provided for @installmentsMinValue.
  ///
  /// In en, this message translates to:
  /// **'Must be at least 2 installments'**
  String get installmentsMinValue;

  /// No description provided for @startDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a start date'**
  String get startDateRequired;

  /// No description provided for @endDateAfterStart.
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get endDateAfterStart;

  /// No description provided for @endDateAfterStartSpecific.
  ///
  /// In en, this message translates to:
  /// **'Must be after {startMonth}/{startYear}'**
  String endDateAfterStartSpecific(String startMonth, String startYear);

  /// No description provided for @transactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get transactions;

  /// No description provided for @recurringTransactions.
  ///
  /// In en, this message translates to:
  /// **'Recurring Transactions'**
  String get recurringTransactions;

  /// No description provided for @installments.
  ///
  /// In en, this message translates to:
  /// **'Installments'**
  String get installments;

  /// No description provided for @monthlyTransactions.
  ///
  /// In en, this message translates to:
  /// **'Monthly Transactions'**
  String get monthlyTransactions;

  /// No description provided for @addFirstTransaction.
  ///
  /// In en, this message translates to:
  /// **'Add your first transaction to get started'**
  String get addFirstTransaction;

  /// No description provided for @newTransaction.
  ///
  /// In en, this message translates to:
  /// **'New Transaction'**
  String get newTransaction;

  /// No description provided for @titleField.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get titleField;

  /// No description provided for @enterTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter transaction title'**
  String get enterTitle;

  /// No description provided for @titleRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a title'**
  String get titleRequired;

  /// No description provided for @enterDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter description (optional)'**
  String get enterDescription;

  /// No description provided for @amountField.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amountField;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @amountRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get amountRequired;

  /// No description provided for @amountPositive.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than zero'**
  String get amountPositive;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @income.
  ///
  /// In en, this message translates to:
  /// **'Income'**
  String get income;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @categoryField.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryField;

  /// No description provided for @selectCategory.
  ///
  /// In en, this message translates to:
  /// **'Select category (optional)'**
  String get selectCategory;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete Transaction'**
  String get deleteConfirmation;

  /// No description provided for @deleteConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this transaction? This action cannot be undone.'**
  String get deleteConfirmationMessage;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @transactionSaved.
  ///
  /// In en, this message translates to:
  /// **'Transaction saved successfully'**
  String get transactionSaved;

  /// No description provided for @transactionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted successfully'**
  String get transactionDeleted;

  /// No description provided for @errorSavingTransaction.
  ///
  /// In en, this message translates to:
  /// **'Error saving transaction'**
  String get errorSavingTransaction;

  /// No description provided for @errorDeletingTransaction.
  ///
  /// In en, this message translates to:
  /// **'Error deleting transaction'**
  String get errorDeletingTransaction;

  /// No description provided for @errorLoadingTransactions.
  ///
  /// In en, this message translates to:
  /// **'Error loading transactions'**
  String get errorLoadingTransactions;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'Unexpected error'**
  String get unexpectedError;

  /// No description provided for @userNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'User not authenticated'**
  String get userNotAuthenticated;

  /// No description provided for @ofPreposition.
  ///
  /// In en, this message translates to:
  /// **'of'**
  String get ofPreposition;

  /// No description provided for @startMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Month'**
  String get startMonthLabel;

  /// No description provided for @endMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'End Month'**
  String get endMonthLabel;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @installmentAmount.
  ///
  /// In en, this message translates to:
  /// **'Installment Amount'**
  String get installmentAmount;

  /// No description provided for @yearlyMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'Yearly Month'**
  String get yearlyMonthLabel;

  /// No description provided for @adjustMonthlyValue.
  ///
  /// In en, this message translates to:
  /// **'Adjust Monthly Value'**
  String get adjustMonthlyValue;

  /// No description provided for @currentValue.
  ///
  /// In en, this message translates to:
  /// **'Current Value'**
  String get currentValue;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @enterNotes.
  ///
  /// In en, this message translates to:
  /// **'Enter notes (optional)'**
  String get enterNotes;

  /// No description provided for @customAmount.
  ///
  /// In en, this message translates to:
  /// **'Custom Amount'**
  String get customAmount;

  /// No description provided for @hasAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Has adjustment'**
  String get hasAdjustment;

  /// No description provided for @transactionType.
  ///
  /// In en, this message translates to:
  /// **'Transaction Type'**
  String get transactionType;

  /// No description provided for @moneyIn.
  ///
  /// In en, this message translates to:
  /// **'Money coming in'**
  String get moneyIn;

  /// No description provided for @moneyOut.
  ///
  /// In en, this message translates to:
  /// **'Money going out'**
  String get moneyOut;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @updateTransaction.
  ///
  /// In en, this message translates to:
  /// **'Update Transaction'**
  String get updateTransaction;

  /// No description provided for @saveTransaction.
  ///
  /// In en, this message translates to:
  /// **'Save Transaction'**
  String get saveTransaction;

  /// No description provided for @additionalDetails.
  ///
  /// In en, this message translates to:
  /// **'Additional details (optional)'**
  String get additionalDetails;

  /// No description provided for @selectStartDate.
  ///
  /// In en, this message translates to:
  /// **'Select when to start'**
  String get selectStartDate;

  /// No description provided for @selectEndDate.
  ///
  /// In en, this message translates to:
  /// **'Select end date'**
  String get selectEndDate;

  /// No description provided for @selectStartDateFirst.
  ///
  /// In en, this message translates to:
  /// **'Select start date first'**
  String get selectStartDateFirst;

  /// No description provided for @enterInstallments.
  ///
  /// In en, this message translates to:
  /// **'Enter number of installments'**
  String get enterInstallments;

  /// No description provided for @installmentsRequiredForm.
  ///
  /// In en, this message translates to:
  /// **'Number of installments is required'**
  String get installmentsRequiredForm;

  /// No description provided for @installmentsPositive.
  ///
  /// In en, this message translates to:
  /// **'Must be a number greater than zero'**
  String get installmentsPositive;

  /// No description provided for @selectFirstInstallmentMonth.
  ///
  /// In en, this message translates to:
  /// **'Select the month of the first installment'**
  String get selectFirstInstallmentMonth;

  /// No description provided for @installmentValueForm.
  ///
  /// In en, this message translates to:
  /// **'Installment value'**
  String get installmentValueForm;

  /// No description provided for @titleHint.
  ///
  /// In en, this message translates to:
  /// **'Ex: Salary, Rent, Groceries...'**
  String get titleHint;

  /// No description provided for @endMonthOptional.
  ///
  /// In en, this message translates to:
  /// **'End Month (optional)'**
  String get endMonthOptional;

  /// No description provided for @startMonthRequiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Start Month *'**
  String get startMonthRequiredLabel;

  /// No description provided for @yearlyMonthRequiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Yearly Month *'**
  String get yearlyMonthRequiredLabel;

  /// No description provided for @totalInstallmentsRequiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Installments *'**
  String get totalInstallmentsRequiredLabel;

  /// No description provided for @titleRequiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Title *'**
  String get titleRequiredLabel;

  /// No description provided for @amountRequiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount *'**
  String get amountRequiredLabel;

  /// No description provided for @categoryRequiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Category *'**
  String get categoryRequiredLabel;

  /// No description provided for @dashboardTransactions.
  ///
  /// In en, this message translates to:
  /// **'Transactions'**
  String get dashboardTransactions;

  /// No description provided for @adjusted.
  ///
  /// In en, this message translates to:
  /// **'Adjusted'**
  String get adjusted;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// No description provided for @editAction.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editAction;

  /// No description provided for @adjustMonthlyValueAction.
  ///
  /// In en, this message translates to:
  /// **'Adjust this month\'s value'**
  String get adjustMonthlyValueAction;

  /// No description provided for @deleteAction.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAction;

  /// No description provided for @generalInformation.
  ///
  /// In en, this message translates to:
  /// **'General Information'**
  String get generalInformation;

  /// No description provided for @dates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dates;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created at'**
  String get createdAt;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated at'**
  String get updatedAt;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// No description provided for @deletedTransaction.
  ///
  /// In en, this message translates to:
  /// **'Deleted transaction'**
  String get deletedTransaction;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @currency.
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get currency;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @portuguese.
  ///
  /// In en, this message translates to:
  /// **'Portuguese'**
  String get portuguese;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @brazilianReal.
  ///
  /// In en, this message translates to:
  /// **'Brazilian Real (R\$)'**
  String get brazilianReal;

  /// No description provided for @usDollar.
  ///
  /// In en, this message translates to:
  /// **'US Dollar (\$)'**
  String get usDollar;

  /// No description provided for @euro.
  ///
  /// In en, this message translates to:
  /// **'Euro (€)'**
  String get euro;

  /// No description provided for @selectPeriod.
  ///
  /// In en, this message translates to:
  /// **'Select Period'**
  String get selectPeriod;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @transactionDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction deleted successfully!'**
  String get transactionDeletedSuccess;

  /// No description provided for @transactionUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Transaction updated successfully!'**
  String get transactionUpdatedSuccess;

  /// No description provided for @adjustValue.
  ///
  /// In en, this message translates to:
  /// **'Adjust Value - {month}/{year}'**
  String adjustValue(String month, String year);

  /// No description provided for @removeAdjustment.
  ///
  /// In en, this message translates to:
  /// **'Remove Adjustment'**
  String get removeAdjustment;

  /// No description provided for @editTransaction.
  ///
  /// In en, this message translates to:
  /// **'Edit Transaction'**
  String get editTransaction;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @backToTransactions.
  ///
  /// In en, this message translates to:
  /// **'Back to Transactions'**
  String get backToTransactions;

  /// No description provided for @profileComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Profile - Coming soon!'**
  String get profileComingSoon;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @confirmLogoutMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout from your account?\n\nYou will need to login again to access the app.'**
  String get confirmLogoutMessage;

  /// No description provided for @authErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Authentication Error'**
  String get authErrorTitle;

  /// No description provided for @networkErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Connection Error'**
  String get networkErrorTitle;

  /// No description provided for @databaseErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Database Error'**
  String get databaseErrorTitle;

  /// No description provided for @transactionErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction Error'**
  String get transactionErrorTitle;

  /// No description provided for @budgetErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Budget Error'**
  String get budgetErrorTitle;

  /// No description provided for @settingsErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings Error'**
  String get settingsErrorTitle;

  /// No description provided for @validationErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Validation Error'**
  String get validationErrorTitle;

  /// No description provided for @generalErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get generalErrorTitle;

  /// No description provided for @userNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'User not found. Please check your email and try again.'**
  String get userNotFoundError;

  /// No description provided for @wrongPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Wrong password. Please check your password and try again.'**
  String get wrongPasswordError;

  /// No description provided for @emailAlreadyInUseError.
  ///
  /// In en, this message translates to:
  /// **'This email is already being used by another account.'**
  String get emailAlreadyInUseError;

  /// No description provided for @weakPasswordError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long.'**
  String get weakPasswordError;

  /// No description provided for @invalidEmailError.
  ///
  /// In en, this message translates to:
  /// **'The email provided is not valid.'**
  String get invalidEmailError;

  /// No description provided for @userDisabledError.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled. Please contact support.'**
  String get userDisabledError;

  /// No description provided for @tooManyRequestsError.
  ///
  /// In en, this message translates to:
  /// **'Too many login attempts. Please try again in a few minutes.'**
  String get tooManyRequestsError;

  /// No description provided for @operationNotAllowedError.
  ///
  /// In en, this message translates to:
  /// **'Operation not allowed. Please check your settings.'**
  String get operationNotAllowedError;

  /// No description provided for @invalidCredentialError.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Please check your information and try again.'**
  String get invalidCredentialError;

  /// No description provided for @authenticationFailedError.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed. Please try again.'**
  String get authenticationFailedError;

  /// No description provided for @userDataNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'User data not found.'**
  String get userDataNotFoundError;

  /// No description provided for @signUpFailedError.
  ///
  /// In en, this message translates to:
  /// **'Failed to create account. Please try again.'**
  String get signUpFailedError;

  /// No description provided for @signOutFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error signing out. Please try again.'**
  String get signOutFailedError;

  /// No description provided for @getCurrentUserFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error retrieving user data.'**
  String get getCurrentUserFailedError;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your internet and try again.'**
  String get networkError;

  /// No description provided for @connectionTimeoutError.
  ///
  /// In en, this message translates to:
  /// **'Connection timeout. Please try again.'**
  String get connectionTimeoutError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again in a few minutes.'**
  String get serverError;

  /// No description provided for @noInternetConnectionError.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your connection.'**
  String get noInternetConnectionError;

  /// No description provided for @firebaseError.
  ///
  /// In en, this message translates to:
  /// **'Service error. Please try again in a few minutes.'**
  String get firebaseError;

  /// No description provided for @firestoreError.
  ///
  /// In en, this message translates to:
  /// **'Database error. Please try again.'**
  String get firestoreError;

  /// No description provided for @permissionDeniedError.
  ///
  /// In en, this message translates to:
  /// **'Access denied. Please check your permissions.'**
  String get permissionDeniedError;

  /// No description provided for @documentNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'Document not found.'**
  String get documentNotFoundError;

  /// No description provided for @collectionNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'Collection not found.'**
  String get collectionNotFoundError;

  /// No description provided for @transactionNotFoundError.
  ///
  /// In en, this message translates to:
  /// **'Transaction not found.'**
  String get transactionNotFoundError;

  /// No description provided for @transactionSaveFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error saving transaction. Please try again.'**
  String get transactionSaveFailedError;

  /// No description provided for @transactionDeleteFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting transaction. Please try again.'**
  String get transactionDeleteFailedError;

  /// No description provided for @transactionUpdateFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error updating transaction. Please try again.'**
  String get transactionUpdateFailedError;

  /// No description provided for @transactionLoadFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error loading transactions. Please try again.'**
  String get transactionLoadFailedError;

  /// No description provided for @invalidTransactionDataError.
  ///
  /// In en, this message translates to:
  /// **'Invalid transaction data.'**
  String get invalidTransactionDataError;

  /// No description provided for @budgetCalculationFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error calculating budget. Please try again.'**
  String get budgetCalculationFailedError;

  /// No description provided for @budgetDataInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Invalid budget data.'**
  String get budgetDataInvalidError;

  /// No description provided for @settingsSaveFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error saving settings. Please try again.'**
  String get settingsSaveFailedError;

  /// No description provided for @settingsLoadFailedError.
  ///
  /// In en, this message translates to:
  /// **'Error loading settings. Please try again.'**
  String get settingsLoadFailedError;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Invalid data. Please check the fields and try again.'**
  String get validationError;

  /// No description provided for @invalidDataError.
  ///
  /// In en, this message translates to:
  /// **'Invalid data provided.'**
  String get invalidDataError;

  /// No description provided for @requiredFieldMissingError.
  ///
  /// In en, this message translates to:
  /// **'Required field not filled.'**
  String get requiredFieldMissingError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown error. Please try again or contact support.'**
  String get unknownError;

  /// No description provided for @dataParsingError.
  ///
  /// In en, this message translates to:
  /// **'Error processing data. Please try again.'**
  String get dataParsingError;

  /// No description provided for @cacheError.
  ///
  /// In en, this message translates to:
  /// **'Cache error. Please try again.'**
  String get cacheError;

  /// No description provided for @storageError.
  ///
  /// In en, this message translates to:
  /// **'Storage error. Please try again.'**
  String get storageError;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @changeName.
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeName;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @currentName.
  ///
  /// In en, this message translates to:
  /// **'Current Name'**
  String get currentName;

  /// No description provided for @newName.
  ///
  /// In en, this message translates to:
  /// **'New Name'**
  String get newName;

  /// No description provided for @nameUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Name updated successfully!'**
  String get nameUpdatedSuccess;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @passwordUpdatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully!'**
  String get passwordUpdatedSuccess;

  /// No description provided for @deleteAccountConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete Account Permanently'**
  String get deleteAccountConfirmation;

  /// No description provided for @deleteAccountWarning.
  ///
  /// In en, this message translates to:
  /// **'This action is irreversible!\n\nAll your data will be permanently deleted:\n• Transactions\n• Settings\n• Financial history\n\nAre you sure you want to continue?'**
  String get deleteAccountWarning;

  /// No description provided for @enterCurrentPasswordToDelete.
  ///
  /// In en, this message translates to:
  /// **'Enter your current password to confirm deletion:'**
  String get enterCurrentPasswordToDelete;

  /// No description provided for @accountDeletedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully!'**
  String get accountDeletedSuccess;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Current password is incorrect'**
  String get incorrectPassword;

  /// No description provided for @passwordTooWeak.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least 8 characters, including: 1 uppercase letter, 1 lowercase letter, and 1 special character'**
  String get passwordTooWeak;

  /// No description provided for @nameRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameRequired;

  /// No description provided for @nameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name must have at least 2 characters'**
  String get nameMinLength;

  /// No description provided for @currentPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Current password is required'**
  String get currentPasswordRequired;

  /// No description provided for @updateName.
  ///
  /// In en, this message translates to:
  /// **'Update Name'**
  String get updateName;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'Update Password'**
  String get updatePassword;

  /// No description provided for @deleteAccountAction.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccountAction;

  /// No description provided for @profileUpdatedError.
  ///
  /// In en, this message translates to:
  /// **'Error updating profile'**
  String get profileUpdatedError;

  /// No description provided for @passwordUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Error changing password'**
  String get passwordUpdateError;

  /// No description provided for @accountDeleteError.
  ///
  /// In en, this message translates to:
  /// **'Error deleting account'**
  String get accountDeleteError;

  /// No description provided for @reauthenticationRequired.
  ///
  /// In en, this message translates to:
  /// **'Identity confirmation is required for this action'**
  String get reauthenticationRequired;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @appSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Smart Financial Planning'**
  String get appSubtitle;

  /// No description provided for @defaultUserName.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get defaultUserName;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning!'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon!'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening!'**
  String get goodEvening;

  /// No description provided for @systemTheme.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemTheme;

  /// No description provided for @errorLoadingTransaction.
  ///
  /// In en, this message translates to:
  /// **'Error loading transaction'**
  String get errorLoadingTransaction;

  /// No description provided for @transactionNotFound.
  ///
  /// In en, this message translates to:
  /// **'Transaction not found'**
  String get transactionNotFound;

  /// No description provided for @transactionNotFoundDescription.
  ///
  /// In en, this message translates to:
  /// **'The transaction may have been deleted or the ID is incorrect.'**
  String get transactionNotFoundDescription;

  /// No description provided for @categorySalary.
  ///
  /// In en, this message translates to:
  /// **'Salary'**
  String get categorySalary;

  /// No description provided for @categoryFreelance.
  ///
  /// In en, this message translates to:
  /// **'Freelance'**
  String get categoryFreelance;

  /// No description provided for @categoryInvestment.
  ///
  /// In en, this message translates to:
  /// **'Investments'**
  String get categoryInvestment;

  /// No description provided for @categoryBonus.
  ///
  /// In en, this message translates to:
  /// **'Bonus'**
  String get categoryBonus;

  /// No description provided for @categoryGiftIncome.
  ///
  /// In en, this message translates to:
  /// **'Gift Received'**
  String get categoryGiftIncome;

  /// No description provided for @categoryOtherIncome.
  ///
  /// In en, this message translates to:
  /// **'Other Income'**
  String get categoryOtherIncome;

  /// No description provided for @categoryHousing.
  ///
  /// In en, this message translates to:
  /// **'Housing'**
  String get categoryHousing;

  /// No description provided for @categoryUtilities.
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get categoryUtilities;

  /// No description provided for @categoryGroceries.
  ///
  /// In en, this message translates to:
  /// **'Groceries'**
  String get categoryGroceries;

  /// No description provided for @categoryTransportation.
  ///
  /// In en, this message translates to:
  /// **'Transportation'**
  String get categoryTransportation;

  /// No description provided for @categoryInsurance.
  ///
  /// In en, this message translates to:
  /// **'Insurance'**
  String get categoryInsurance;

  /// No description provided for @categoryHealthcare.
  ///
  /// In en, this message translates to:
  /// **'Healthcare'**
  String get categoryHealthcare;

  /// No description provided for @categoryDining.
  ///
  /// In en, this message translates to:
  /// **'Dining'**
  String get categoryDining;

  /// No description provided for @categoryEntertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get categoryEntertainment;

  /// No description provided for @categoryShopping.
  ///
  /// In en, this message translates to:
  /// **'Shopping'**
  String get categoryShopping;

  /// No description provided for @categoryTravel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get categoryTravel;

  /// No description provided for @categoryHobbies.
  ///
  /// In en, this message translates to:
  /// **'Hobbies'**
  String get categoryHobbies;

  /// No description provided for @categoryFitness.
  ///
  /// In en, this message translates to:
  /// **'Gym/Sports'**
  String get categoryFitness;

  /// No description provided for @categoryBeauty.
  ///
  /// In en, this message translates to:
  /// **'Beauty'**
  String get categoryBeauty;

  /// No description provided for @categoryLoans.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get categoryLoans;

  /// No description provided for @categoryCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get categoryCreditCard;

  /// No description provided for @categoryTaxes.
  ///
  /// In en, this message translates to:
  /// **'Taxes'**
  String get categoryTaxes;

  /// No description provided for @categoryFees.
  ///
  /// In en, this message translates to:
  /// **'Fees'**
  String get categoryFees;

  /// No description provided for @categoryEducation.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get categoryEducation;

  /// No description provided for @categoryBooks.
  ///
  /// In en, this message translates to:
  /// **'Books'**
  String get categoryBooks;

  /// No description provided for @categoryCourses.
  ///
  /// In en, this message translates to:
  /// **'Courses'**
  String get categoryCourses;

  /// No description provided for @categoryChildcare.
  ///
  /// In en, this message translates to:
  /// **'Childcare'**
  String get categoryChildcare;

  /// No description provided for @categoryPets.
  ///
  /// In en, this message translates to:
  /// **'Pets'**
  String get categoryPets;

  /// No description provided for @categoryGifts.
  ///
  /// In en, this message translates to:
  /// **'Gifts'**
  String get categoryGifts;

  /// No description provided for @categoryCharity.
  ///
  /// In en, this message translates to:
  /// **'Charity'**
  String get categoryCharity;

  /// No description provided for @categoryEmergencyFund.
  ///
  /// In en, this message translates to:
  /// **'Emergency Fund'**
  String get categoryEmergencyFund;

  /// No description provided for @categoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get categoryOther;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noDataFound;

  /// No description provided for @addTransactionsToSeeSummary.
  ///
  /// In en, this message translates to:
  /// **'Add transactions to see the summary'**
  String get addTransactionsToSeeSummary;

  /// No description provided for @budgetSummary.
  ///
  /// In en, this message translates to:
  /// **'Budget Summary'**
  String get budgetSummary;

  /// No description provided for @currentBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Balance'**
  String get currentBalance;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @endDateRemoved.
  ///
  /// In en, this message translates to:
  /// **'End date removed - must be after start date'**
  String get endDateRemoved;

  /// No description provided for @defaultAmount.
  ///
  /// In en, this message translates to:
  /// **'Default amount'**
  String get defaultAmount;

  /// No description provided for @amountMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'Amount must be greater than zero'**
  String get amountMustBePositive;

  /// No description provided for @customAmountThisMonth.
  ///
  /// In en, this message translates to:
  /// **'This month has custom amount'**
  String get customAmountThisMonth;

  /// No description provided for @valueForThisMonth.
  ///
  /// In en, this message translates to:
  /// **'Value for this month'**
  String get valueForThisMonth;

  /// No description provided for @restoreDefaultValue.
  ///
  /// In en, this message translates to:
  /// **'Restore default value'**
  String get restoreDefaultValue;

  /// No description provided for @monthJanuary.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get monthJanuary;

  /// No description provided for @monthFebruary.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get monthFebruary;

  /// No description provided for @monthMarch.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get monthMarch;

  /// No description provided for @monthApril.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get monthApril;

  /// No description provided for @monthMayExt.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMayExt;

  /// No description provided for @monthJune.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get monthJune;

  /// No description provided for @monthJuly.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get monthJuly;

  /// No description provided for @monthAugust.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get monthAugust;

  /// No description provided for @monthSeptember.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get monthSeptember;

  /// No description provided for @monthOctober.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get monthOctober;

  /// No description provided for @monthNovember.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get monthNovember;

  /// No description provided for @monthDecember.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get monthDecember;

  /// No description provided for @installmentsMustBeGreaterThanZero.
  ///
  /// In en, this message translates to:
  /// **'Number of installments must be greater than zero'**
  String get installmentsMustBeGreaterThanZero;

  /// No description provided for @startDateRequiredForInstallments.
  ///
  /// In en, this message translates to:
  /// **'Start date is required for installment transactions'**
  String get startDateRequiredForInstallments;

  /// No description provided for @startDateRequiredForMonthly.
  ///
  /// In en, this message translates to:
  /// **'Start date is required for monthly transactions'**
  String get startDateRequiredForMonthly;

  /// No description provided for @yearlyMonthRequiredForYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly month is required for yearly transactions'**
  String get yearlyMonthRequiredForYearly;

  /// No description provided for @fieldRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @emailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid email'**
  String get emailInvalid;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordMinLength;

  /// No description provided for @newPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'New password is required'**
  String get newPasswordRequired;

  /// No description provided for @confirmPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password confirmation is required'**
  String get confirmPasswordRequired;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @actionCannotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone'**
  String get actionCannotBeUndone;

  /// No description provided for @monthlyInformation.
  ///
  /// In en, this message translates to:
  /// **'Monthly Information'**
  String get monthlyInformation;

  /// No description provided for @installmentInformation.
  ///
  /// In en, this message translates to:
  /// **'Installment Information'**
  String get installmentInformation;

  /// No description provided for @yearlyInformation.
  ///
  /// In en, this message translates to:
  /// **'Yearly Information'**
  String get yearlyInformation;

  /// No description provided for @startMonth.
  ///
  /// In en, this message translates to:
  /// **'Start Month'**
  String get startMonth;

  /// No description provided for @endMonth.
  ///
  /// In en, this message translates to:
  /// **'End Month'**
  String get endMonth;

  /// No description provided for @totalInstallments.
  ///
  /// In en, this message translates to:
  /// **'Total Installments'**
  String get totalInstallments;

  /// No description provided for @currentInstallment.
  ///
  /// In en, this message translates to:
  /// **'Current Installment'**
  String get currentInstallment;

  /// No description provided for @firstInstallmentMonth.
  ///
  /// In en, this message translates to:
  /// **'1st Installment Month'**
  String get firstInstallmentMonth;

  /// No description provided for @yearlyMonth.
  ///
  /// In en, this message translates to:
  /// **'Yearly Month'**
  String get yearlyMonth;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @installmentValue.
  ///
  /// In en, this message translates to:
  /// **'Installment value'**
  String get installmentValue;

  /// No description provided for @totalValue.
  ///
  /// In en, this message translates to:
  /// **'Total value'**
  String get totalValue;

  /// No description provided for @adjustedValue.
  ///
  /// In en, this message translates to:
  /// **'Adjusted value for'**
  String get adjustedValue;

  /// No description provided for @defaultInstallmentValue.
  ///
  /// In en, this message translates to:
  /// **'Default installment value'**
  String get defaultInstallmentValue;

  /// No description provided for @defaultValue.
  ///
  /// In en, this message translates to:
  /// **'Default value'**
  String get defaultValue;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @previousMonth.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get previousMonth;

  /// No description provided for @nextMonth.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get nextMonth;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get monthDec;

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'StackBudget'**
  String get appName;

  /// No description provided for @appDescription.
  ///
  /// In en, this message translates to:
  /// **'Your smart financial planning'**
  String get appDescription;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;
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
