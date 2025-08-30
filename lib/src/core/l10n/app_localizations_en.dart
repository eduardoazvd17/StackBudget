// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get frequencyOneTime => 'One-time';

  @override
  String get frequencyMonthly => 'Monthly';

  @override
  String get frequencyYearly => 'Yearly';

  @override
  String get frequencyInstallment => 'Installment';

  @override
  String get frequency => 'Frequency';

  @override
  String get selectFrequency => 'Select frequency';

  @override
  String get selectFrequencyRequired => 'Please select a frequency';

  @override
  String get monthlySettings => 'Monthly Settings';

  @override
  String get startMonth => 'Start Month';

  @override
  String get endMonth => 'End Month';

  @override
  String get selectStartMonth => 'Select start month';

  @override
  String get selectEndMonth => 'Select end month';

  @override
  String get yearlySettings => 'Yearly Settings';

  @override
  String get yearlyMonth => 'Yearly Month';

  @override
  String get selectYearlyMonth => 'Select the month it occurs yearly';

  @override
  String get selectMonthRequired => 'Please select a month';

  @override
  String get installmentSettings => 'Installment Settings';

  @override
  String get totalInstallments => 'Total Installments';

  @override
  String get enterTotalInstallments => 'Enter total number of installments';

  @override
  String get installmentsRequired => 'Number of installments is required';

  @override
  String get installmentsMinValue => 'Must be at least 2 installments';

  @override
  String get startDateRequired => 'Please select a start date';

  @override
  String get endDateAfterStart => 'End date must be after start date';

  @override
  String endDateAfterStartSpecific(String startMonth, String startYear) {
    return 'Must be after $startMonth/$startYear';
  }

  @override
  String get transactions => 'Transactions';

  @override
  String get recurringTransactions => 'Recurring Transactions';

  @override
  String get installments => 'Installments';

  @override
  String get monthlyTransactions => 'Monthly Transactions';

  @override
  String get noTransactionsFound => 'No transactions found';

  @override
  String get addFirstTransaction => 'Add your first transaction to get started';

  @override
  String get newTransaction => 'New Transaction';

  @override
  String get title => 'Title';

  @override
  String get enterTitle => 'Enter transaction title';

  @override
  String get titleRequired => 'Title *';

  @override
  String get description => 'Description';

  @override
  String get enterDescription => 'Enter description (optional)';

  @override
  String get amount => 'Amount';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get amountRequired => 'Amount *';

  @override
  String get amountPositive => 'Amount must be greater than zero';

  @override
  String get type => 'Type';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get category => 'Category';

  @override
  String get selectCategory => 'Select category (optional)';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get edit => 'Edit';

  @override
  String get delete => 'Delete';

  @override
  String get deleteConfirmation => 'Delete Transaction';

  @override
  String get deleteConfirmationMessage => 'Are you sure you want to delete this transaction? This action cannot be undone.';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get error => 'Error';

  @override
  String get loading => 'Loading...';

  @override
  String get success => 'Success';

  @override
  String get transactionSaved => 'Transaction saved successfully';

  @override
  String get transactionDeleted => 'Transaction deleted successfully';

  @override
  String get errorSavingTransaction => 'Error saving transaction';

  @override
  String get errorDeletingTransaction => 'Error deleting transaction';

  @override
  String get errorLoadingTransactions => 'Error loading transactions';

  @override
  String get unexpectedError => 'Unexpected error';

  @override
  String get userNotAuthenticated => 'User not authenticated';

  @override
  String get currentInstallment => 'Current Installment';

  @override
  String get ofPreposition => 'of';

  @override
  String get monthlyInformation => 'Monthly Information';

  @override
  String get installmentInformation => 'Installment Information';

  @override
  String get yearlyInformation => 'Yearly Information';

  @override
  String get startMonthLabel => 'Start Month';

  @override
  String get endMonthLabel => 'End Month';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get installmentAmount => 'Installment Amount';

  @override
  String get yearlyMonthLabel => 'Yearly Month';

  @override
  String get adjustMonthlyValue => 'Adjust this month\'s value';

  @override
  String get currentValue => 'Current Value';

  @override
  String get defaultValue => 'Default Value';

  @override
  String get notes => 'Notes';

  @override
  String get enterNotes => 'Enter notes (optional)';

  @override
  String get customAmount => 'Custom Amount';

  @override
  String get hasAdjustment => 'Has adjustment';

  @override
  String get transactionType => 'Transaction Type';

  @override
  String get moneyIn => 'Money coming in';

  @override
  String get moneyOut => 'Money going out';

  @override
  String get saving => 'Saving...';

  @override
  String get updateTransaction => 'Update Transaction';

  @override
  String get saveTransaction => 'Save Transaction';

  @override
  String get additionalDetails => 'Additional details (optional)';

  @override
  String get selectStartDate => 'Select when to start';

  @override
  String get selectEndDate => 'Select end date';

  @override
  String get selectStartDateFirst => 'Select start date first';

  @override
  String get enterInstallments => 'Enter number of installments';

  @override
  String get installmentsPositive => 'Must be a number greater than zero';

  @override
  String get selectFirstInstallmentMonth => 'Select the month of the first installment';

  @override
  String get installmentValue => 'Installment value';

  @override
  String get firstInstallmentMonth => '1st Installment Month';

  @override
  String get titleHint => 'Ex: Salary, Rent, Groceries...';

  @override
  String get amountHint => 'R\$ 0.00';

  @override
  String get endMonthOptional => 'End Month (optional)';

  @override
  String get startMonthRequired => 'Start Month *';

  @override
  String get yearlyMonthRequired => 'Yearly Month *';

  @override
  String get totalInstallmentsRequired => 'Total Installments *';

  @override
  String get categoryRequired => 'Category *';

  @override
  String get dashboardTransactions => 'Transactions';

  @override
  String get adjusted => 'Adjusted';

  @override
  String get transactionDetails => 'Transaction Details';

  @override
  String get generalInformation => 'General Information';

  @override
  String get dates => 'Dates';

  @override
  String get createdAt => 'Created at';

  @override
  String get updatedAt => 'Updated at';

  @override
  String get tags => 'Tags';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get deletedTransaction => 'Deleted transaction';
}
