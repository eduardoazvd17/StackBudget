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
  String get startMonthField => 'Start Month';

  @override
  String get endMonthField => 'End Month';

  @override
  String get selectStartMonth => 'Select start month';

  @override
  String get selectEndMonth => 'Select end month';

  @override
  String get yearlySettings => 'Yearly Settings';

  @override
  String get yearlyMonthField => 'Yearly Month';

  @override
  String get selectYearlyMonth => 'Select the month it occurs yearly';

  @override
  String get selectMonthRequired => 'Please select a month';

  @override
  String get selectMonth => 'Select Month';

  @override
  String get installmentSettings => 'Installment Settings';

  @override
  String get totalInstallmentsField => 'Total Installments';

  @override
  String get enterTotalInstallments => 'Enter total number of installments';

  @override
  String get installmentsRequired => 'Please enter the number of installments';

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
  String get addFirstTransaction => 'Add your first transaction to get started';

  @override
  String get newTransaction => 'New Transaction';

  @override
  String get titleField => 'Title';

  @override
  String get enterTitle => 'Enter transaction title';

  @override
  String get titleRequired => 'Please enter a title';

  @override
  String get enterDescription => 'Enter description (optional)';

  @override
  String get amountField => 'Amount';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get amountRequired => 'Please enter an amount';

  @override
  String get amountPositive => 'Amount must be greater than zero';

  @override
  String get type => 'Type';

  @override
  String get income => 'Income';

  @override
  String get expense => 'Expense';

  @override
  String get categoryField => 'Category';

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
  String get ofPreposition => 'of';

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
  String get adjustMonthlyValue => 'Adjust Monthly Value';

  @override
  String get currentValue => 'Current Value';

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
  String get installmentsRequiredForm => 'Number of installments is required';

  @override
  String get installmentsPositive => 'Must be a number greater than zero';

  @override
  String get selectFirstInstallmentMonth => 'Select the month of the first installment';

  @override
  String get installmentValueForm => 'Installment value';

  @override
  String get titleHint => 'Ex: Salary, Rent, Groceries...';

  @override
  String get endMonthOptional => 'End Month (optional)';

  @override
  String get startMonthRequiredLabel => 'Start Month *';

  @override
  String get yearlyMonthRequiredLabel => 'Yearly Month *';

  @override
  String get totalInstallmentsRequiredLabel => 'Total Installments *';

  @override
  String get titleRequiredLabel => 'Title *';

  @override
  String get amountRequiredLabel => 'Amount *';

  @override
  String get categoryRequiredLabel => 'Category *';

  @override
  String get dashboardTransactions => 'Transactions';

  @override
  String get adjusted => 'Adjusted';

  @override
  String get transactionDetails => 'Transaction Details';

  @override
  String get editAction => 'Edit';

  @override
  String get adjustMonthlyValueAction => 'Adjust this month\'s value';

  @override
  String get deleteAction => 'Delete';

  @override
  String get generalInformation => 'General Information';

  @override
  String get dates => 'Dates';

  @override
  String get createdAt => 'Created at';

  @override
  String get updatedAt => 'Updated at';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get deletedTransaction => 'Deleted transaction';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get currency => 'Currency';

  @override
  String get retry => 'Retry';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get portuguese => 'Portuguese';

  @override
  String get english => 'English';

  @override
  String get brazilianReal => 'Brazilian Real (R\$)';

  @override
  String get usDollar => 'US Dollar (\$)';

  @override
  String get euro => 'Euro (€)';

  @override
  String get selectPeriod => 'Select Period';

  @override
  String get confirm => 'Confirm';

  @override
  String get transactionDeletedSuccess => 'Transaction deleted successfully!';

  @override
  String get transactionUpdatedSuccess => 'Transaction updated successfully!';

  @override
  String adjustValue(String month, String year) {
    return 'Adjust Value - $month/$year';
  }

  @override
  String get removeAdjustment => 'Remove Adjustment';

  @override
  String get editTransaction => 'Edit Transaction';

  @override
  String get back => 'Back';

  @override
  String get notFound => 'Not Found';

  @override
  String get backToTransactions => 'Back to Transactions';

  @override
  String get profileComingSoon => 'Profile - Coming soon!';

  @override
  String get logout => 'Logout';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String get confirmLogoutMessage => 'Are you sure you want to logout from your account?\n\nYou will need to login again to access the app.';

  @override
  String get authErrorTitle => 'Authentication Error';

  @override
  String get networkErrorTitle => 'Connection Error';

  @override
  String get databaseErrorTitle => 'Database Error';

  @override
  String get transactionErrorTitle => 'Transaction Error';

  @override
  String get budgetErrorTitle => 'Budget Error';

  @override
  String get settingsErrorTitle => 'Settings Error';

  @override
  String get validationErrorTitle => 'Validation Error';

  @override
  String get generalErrorTitle => 'Error';

  @override
  String get userNotFoundError => 'User not found. Please check your email and try again.';

  @override
  String get wrongPasswordError => 'Wrong password. Please check your password and try again.';

  @override
  String get emailAlreadyInUseError => 'This email is already being used by another account.';

  @override
  String get weakPasswordError => 'Password must be at least 6 characters long.';

  @override
  String get invalidEmailError => 'The email provided is not valid.';

  @override
  String get userDisabledError => 'This account has been disabled. Please contact support.';

  @override
  String get tooManyRequestsError => 'Too many login attempts. Please try again in a few minutes.';

  @override
  String get operationNotAllowedError => 'Operation not allowed. Please check your settings.';

  @override
  String get invalidCredentialError => 'Invalid credentials. Please check your information and try again.';

  @override
  String get authenticationFailedError => 'Authentication failed. Please try again.';

  @override
  String get userDataNotFoundError => 'User data not found.';

  @override
  String get signUpFailedError => 'Failed to create account. Please try again.';

  @override
  String get signOutFailedError => 'Error signing out. Please try again.';

  @override
  String get getCurrentUserFailedError => 'Error retrieving user data.';

  @override
  String get networkError => 'Connection error. Please check your internet and try again.';

  @override
  String get connectionTimeoutError => 'Connection timeout. Please try again.';

  @override
  String get serverError => 'Server error. Please try again in a few minutes.';

  @override
  String get noInternetConnectionError => 'No internet connection. Please check your connection.';

  @override
  String get firebaseError => 'Service error. Please try again in a few minutes.';

  @override
  String get firestoreError => 'Database error. Please try again.';

  @override
  String get permissionDeniedError => 'Access denied. Please check your permissions.';

  @override
  String get documentNotFoundError => 'Document not found.';

  @override
  String get collectionNotFoundError => 'Collection not found.';

  @override
  String get transactionNotFoundError => 'Transaction not found.';

  @override
  String get transactionSaveFailedError => 'Error saving transaction. Please try again.';

  @override
  String get transactionDeleteFailedError => 'Error deleting transaction. Please try again.';

  @override
  String get transactionUpdateFailedError => 'Error updating transaction. Please try again.';

  @override
  String get transactionLoadFailedError => 'Error loading transactions. Please try again.';

  @override
  String get invalidTransactionDataError => 'Invalid transaction data.';

  @override
  String get budgetCalculationFailedError => 'Error calculating budget. Please try again.';

  @override
  String get budgetDataInvalidError => 'Invalid budget data.';

  @override
  String get settingsSaveFailedError => 'Error saving settings. Please try again.';

  @override
  String get settingsLoadFailedError => 'Error loading settings. Please try again.';

  @override
  String get validationError => 'Invalid data. Please check the fields and try again.';

  @override
  String get invalidDataError => 'Invalid data provided.';

  @override
  String get requiredFieldMissingError => 'Required field not filled.';

  @override
  String get unknownError => 'Unknown error. Please try again or contact support.';

  @override
  String get dataParsingError => 'Error processing data. Please try again.';

  @override
  String get cacheError => 'Cache error. Please try again.';

  @override
  String get storageError => 'Storage error. Please try again.';

  @override
  String get profile => 'Profile';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get changeName => 'Change Name';

  @override
  String get changePassword => 'Change Password';

  @override
  String get deleteAccount => 'Delete Account';

  @override
  String get currentName => 'Current Name';

  @override
  String get newName => 'New Name';

  @override
  String get nameUpdatedSuccess => 'Name updated successfully!';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get passwordUpdatedSuccess => 'Password changed successfully!';

  @override
  String get deleteAccountConfirmation => 'Delete Account Permanently';

  @override
  String get deleteAccountWarning => 'This action is irreversible!\n\nAll your data will be permanently deleted:\n• Transactions\n• Settings\n• Financial history\n\nAre you sure you want to continue?';

  @override
  String get enterCurrentPasswordToDelete => 'Enter your current password to confirm deletion:';

  @override
  String get accountDeletedSuccess => 'Account deleted successfully!';

  @override
  String get incorrectPassword => 'Current password is incorrect';

  @override
  String get passwordTooWeak => 'Password must contain at least 8 characters, including: 1 uppercase letter, 1 lowercase letter, and 1 special character';

  @override
  String get nameRequired => 'Name is required';

  @override
  String get nameMinLength => 'Name must have at least 2 characters';

  @override
  String get currentPasswordRequired => 'Current password is required';

  @override
  String get updateName => 'Update Name';

  @override
  String get updatePassword => 'Update Password';

  @override
  String get deleteAccountAction => 'Delete Account';

  @override
  String get profileUpdatedError => 'Error updating profile';

  @override
  String get passwordUpdateError => 'Error changing password';

  @override
  String get accountDeleteError => 'Error deleting account';

  @override
  String get reauthenticationRequired => 'Identity confirmation is required for this action';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get appSubtitle => 'Smart Financial Planning';

  @override
  String get defaultUserName => 'User';

  @override
  String get goodMorning => 'Good morning!';

  @override
  String get goodAfternoon => 'Good afternoon!';

  @override
  String get goodEvening => 'Good evening!';

  @override
  String get systemTheme => 'System';

  @override
  String get errorLoadingTransaction => 'Error loading transaction';

  @override
  String get transactionNotFound => 'Transaction not found';

  @override
  String get transactionNotFoundDescription => 'The transaction may have been deleted or the ID is incorrect.';

  @override
  String get categorySalary => 'Salary';

  @override
  String get categoryFreelance => 'Freelance';

  @override
  String get categoryInvestment => 'Investments';

  @override
  String get categoryBonus => 'Bonus';

  @override
  String get categoryGiftIncome => 'Gift Received';

  @override
  String get categoryOtherIncome => 'Other Income';

  @override
  String get categoryHousing => 'Housing';

  @override
  String get categoryUtilities => 'Utilities';

  @override
  String get categoryGroceries => 'Groceries';

  @override
  String get categoryTransportation => 'Transportation';

  @override
  String get categoryInsurance => 'Insurance';

  @override
  String get categoryHealthcare => 'Healthcare';

  @override
  String get categoryDining => 'Dining';

  @override
  String get categoryEntertainment => 'Entertainment';

  @override
  String get categoryShopping => 'Shopping';

  @override
  String get categoryTravel => 'Travel';

  @override
  String get categoryHobbies => 'Hobbies';

  @override
  String get categoryFitness => 'Gym/Sports';

  @override
  String get categoryBeauty => 'Beauty';

  @override
  String get categoryLoans => 'Loans';

  @override
  String get categoryCreditCard => 'Credit Card';

  @override
  String get categoryTaxes => 'Taxes';

  @override
  String get categoryFees => 'Fees';

  @override
  String get categoryEducation => 'Education';

  @override
  String get categoryBooks => 'Books';

  @override
  String get categoryCourses => 'Courses';

  @override
  String get categoryChildcare => 'Childcare';

  @override
  String get categoryPets => 'Pets';

  @override
  String get categoryGifts => 'Gifts';

  @override
  String get categoryCharity => 'Charity';

  @override
  String get categoryEmergencyFund => 'Emergency Fund';

  @override
  String get categoryOther => 'Other';

  @override
  String get errorLoadingData => 'Error loading data';

  @override
  String get noDataFound => 'No data found';

  @override
  String get addTransactionsToSeeSummary => 'Add transactions to see the summary';

  @override
  String get budgetSummary => 'Budget Summary';

  @override
  String get currentBalance => 'Current Balance';

  @override
  String get expenses => 'Expenses';

  @override
  String get endDateRemoved => 'End date removed - must be after start date';

  @override
  String get defaultAmount => 'Default amount';

  @override
  String get amountMustBePositive => 'Amount must be greater than zero';

  @override
  String get customAmountThisMonth => 'This month has custom amount';

  @override
  String get valueForThisMonth => 'Value for this month';

  @override
  String get restoreDefaultValue => 'Restore default value';

  @override
  String get monthJanuary => 'January';

  @override
  String get monthFebruary => 'February';

  @override
  String get monthMarch => 'March';

  @override
  String get monthApril => 'April';

  @override
  String get monthMayExt => 'May';

  @override
  String get monthJune => 'June';

  @override
  String get monthJuly => 'July';

  @override
  String get monthAugust => 'August';

  @override
  String get monthSeptember => 'September';

  @override
  String get monthOctober => 'October';

  @override
  String get monthNovember => 'November';

  @override
  String get monthDecember => 'December';

  @override
  String get installmentsMustBeGreaterThanZero => 'Number of installments must be greater than zero';

  @override
  String get startDateRequiredForInstallments => 'Start date is required for installment transactions';

  @override
  String get startDateRequiredForMonthly => 'Start date is required for monthly transactions';

  @override
  String get yearlyMonthRequiredForYearly => 'Yearly month is required for yearly transactions';

  @override
  String get fieldRequired => 'This field is required';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Invalid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMinLength => 'Password must be at least 6 characters long';

  @override
  String get newPasswordRequired => 'New password is required';

  @override
  String get confirmPasswordRequired => 'Password confirmation is required';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get actionCannotBeUndone => 'This action cannot be undone';

  @override
  String get monthlyInformation => 'Monthly Information';

  @override
  String get installmentInformation => 'Installment Information';

  @override
  String get yearlyInformation => 'Yearly Information';

  @override
  String get startMonth => 'Start Month';

  @override
  String get endMonth => 'End Month';

  @override
  String get totalInstallments => 'Total Installments';

  @override
  String get currentInstallment => 'Current Installment';

  @override
  String get firstInstallmentMonth => '1st Installment Month';

  @override
  String get yearlyMonth => 'Yearly Month';

  @override
  String get tags => 'Tags';

  @override
  String get installmentValue => 'Installment value';

  @override
  String get totalValue => 'Total value';

  @override
  String get adjustedValue => 'Adjusted value for';

  @override
  String get defaultInstallmentValue => 'Default installment value';

  @override
  String get defaultValue => 'Default value';

  @override
  String get noTransactionsFound => 'No transactions found';

  @override
  String get period => 'Period';

  @override
  String get previousMonth => 'Previous month';

  @override
  String get nextMonth => 'Next month';

  @override
  String get selectDate => 'Select date';

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';

  @override
  String get appName => 'StackBudget';

  @override
  String get appDescription => 'Your smart financial planning';
}
