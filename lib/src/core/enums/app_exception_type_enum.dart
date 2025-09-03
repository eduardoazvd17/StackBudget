import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/l10n/l10n.dart';

enum AppExceptionType {
  // Auth Errors
  userNotFound,
  wrongPassword,
  emailAlreadyInUse,
  weakPassword,
  invalidEmail,
  userDisabled,
  tooManyRequests,
  operationNotAllowed,
  invalidCredential,
  authenticationFailed,
  userDataNotFound,
  userNotAuthenticated,
  signUpFailed,
  signOutFailed,
  getCurrentUserFailed,

  // Network Errors
  networkError,
  connectionTimeout,
  serverError,
  noInternetConnection,

  // Firebase Errors
  firebaseError,
  firestoreError,
  permissionDenied,
  documentNotFound,
  collectionNotFound,

  // Transaction Errors
  transactionNotFound,
  transactionSaveFailed,
  transactionDeleteFailed,
  transactionUpdateFailed,
  transactionLoadFailed,
  invalidTransactionData,

  // Budget Errors
  budgetCalculationFailed,
  budgetDataInvalid,

  // Settings Errors
  settingsSaveFailed,
  settingsLoadFailed,

  // Validation Errors
  validationError,
  invalidData,
  requiredFieldMissing,

  // General Errors
  unexpectedError,
  unknownError,
  dataParsingError,
  cacheError,
  storageError;

  String getTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      // Auth Errors
      case AppExceptionType.userNotFound:
      case AppExceptionType.wrongPassword:
      case AppExceptionType.emailAlreadyInUse:
      case AppExceptionType.weakPassword:
      case AppExceptionType.invalidEmail:
      case AppExceptionType.userDisabled:
      case AppExceptionType.tooManyRequests:
      case AppExceptionType.operationNotAllowed:
      case AppExceptionType.invalidCredential:
      case AppExceptionType.authenticationFailed:
      case AppExceptionType.userDataNotFound:
      case AppExceptionType.userNotAuthenticated:
      case AppExceptionType.signUpFailed:
      case AppExceptionType.signOutFailed:
      case AppExceptionType.getCurrentUserFailed:
        return l10n.authErrorTitle;

      // Network Errors
      case AppExceptionType.networkError:
      case AppExceptionType.connectionTimeout:
      case AppExceptionType.serverError:
      case AppExceptionType.noInternetConnection:
        return l10n.networkErrorTitle;

      // Firebase Errors
      case AppExceptionType.firebaseError:
      case AppExceptionType.firestoreError:
      case AppExceptionType.permissionDenied:
      case AppExceptionType.documentNotFound:
      case AppExceptionType.collectionNotFound:
        return l10n.databaseErrorTitle;

      // Transaction Errors
      case AppExceptionType.transactionNotFound:
      case AppExceptionType.transactionSaveFailed:
      case AppExceptionType.transactionDeleteFailed:
      case AppExceptionType.transactionUpdateFailed:
      case AppExceptionType.transactionLoadFailed:
      case AppExceptionType.invalidTransactionData:
        return l10n.transactionErrorTitle;

      // Budget Errors
      case AppExceptionType.budgetCalculationFailed:
      case AppExceptionType.budgetDataInvalid:
        return l10n.budgetErrorTitle;

      // Settings Errors
      case AppExceptionType.settingsSaveFailed:
      case AppExceptionType.settingsLoadFailed:
        return l10n.settingsErrorTitle;

      // Validation Errors
      case AppExceptionType.validationError:
      case AppExceptionType.invalidData:
      case AppExceptionType.requiredFieldMissing:
        return l10n.validationErrorTitle;

      // General Errors
      case AppExceptionType.unexpectedError:
      case AppExceptionType.unknownError:
      case AppExceptionType.dataParsingError:
      case AppExceptionType.cacheError:
      case AppExceptionType.storageError:
        return l10n.generalErrorTitle;
    }
  }

  String getMessage(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      // Auth Errors
      case AppExceptionType.userNotFound:
        return l10n.userNotFoundError;
      case AppExceptionType.wrongPassword:
        return l10n.wrongPasswordError;
      case AppExceptionType.emailAlreadyInUse:
        return l10n.emailAlreadyInUseError;
      case AppExceptionType.weakPassword:
        return l10n.weakPasswordError;
      case AppExceptionType.invalidEmail:
        return l10n.invalidEmailError;
      case AppExceptionType.userDisabled:
        return l10n.userDisabledError;
      case AppExceptionType.tooManyRequests:
        return l10n.tooManyRequestsError;
      case AppExceptionType.operationNotAllowed:
        return l10n.operationNotAllowedError;
      case AppExceptionType.invalidCredential:
        return l10n.invalidCredentialError;
      case AppExceptionType.authenticationFailed:
        return l10n.authenticationFailedError;
      case AppExceptionType.userDataNotFound:
        return l10n.userDataNotFoundError;
      case AppExceptionType.userNotAuthenticated:
        return l10n.userNotAuthenticated;
      case AppExceptionType.signUpFailed:
        return l10n.signUpFailedError;
      case AppExceptionType.signOutFailed:
        return l10n.signOutFailedError;
      case AppExceptionType.getCurrentUserFailed:
        return l10n.getCurrentUserFailedError;

      // Network Errors
      case AppExceptionType.networkError:
        return l10n.networkError;
      case AppExceptionType.connectionTimeout:
        return l10n.connectionTimeoutError;
      case AppExceptionType.serverError:
        return l10n.serverError;
      case AppExceptionType.noInternetConnection:
        return l10n.noInternetConnectionError;

      // Firebase Errors
      case AppExceptionType.firebaseError:
        return l10n.firebaseError;
      case AppExceptionType.firestoreError:
        return l10n.firestoreError;
      case AppExceptionType.permissionDenied:
        return l10n.permissionDeniedError;
      case AppExceptionType.documentNotFound:
        return l10n.documentNotFoundError;
      case AppExceptionType.collectionNotFound:
        return l10n.collectionNotFoundError;

      // Transaction Errors
      case AppExceptionType.transactionNotFound:
        return l10n.transactionNotFoundError;
      case AppExceptionType.transactionSaveFailed:
        return l10n.transactionSaveFailedError;
      case AppExceptionType.transactionDeleteFailed:
        return l10n.transactionDeleteFailedError;
      case AppExceptionType.transactionUpdateFailed:
        return l10n.transactionUpdateFailedError;
      case AppExceptionType.transactionLoadFailed:
        return l10n.transactionLoadFailedError;
      case AppExceptionType.invalidTransactionData:
        return l10n.invalidTransactionDataError;

      // Budget Errors
      case AppExceptionType.budgetCalculationFailed:
        return l10n.budgetCalculationFailedError;
      case AppExceptionType.budgetDataInvalid:
        return l10n.budgetDataInvalidError;

      // Settings Errors
      case AppExceptionType.settingsSaveFailed:
        return l10n.settingsSaveFailedError;
      case AppExceptionType.settingsLoadFailed:
        return l10n.settingsLoadFailedError;

      // Validation Errors
      case AppExceptionType.validationError:
        return l10n.validationError;
      case AppExceptionType.invalidData:
        return l10n.invalidDataError;
      case AppExceptionType.requiredFieldMissing:
        return l10n.requiredFieldMissingError;

      // General Errors
      case AppExceptionType.unexpectedError:
        return l10n.unexpectedError;
      case AppExceptionType.unknownError:
        return l10n.unknownError;
      case AppExceptionType.dataParsingError:
        return l10n.dataParsingError;
      case AppExceptionType.cacheError:
        return l10n.cacheError;
      case AppExceptionType.storageError:
        return l10n.storageError;
    }
  }
}
