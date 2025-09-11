import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

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
        return context.strings.authErrorTitle;

      // Network Errors
      case AppExceptionType.networkError:
      case AppExceptionType.connectionTimeout:
      case AppExceptionType.serverError:
      case AppExceptionType.noInternetConnection:
        return context.strings.networkErrorTitle;

      // Firebase Errors
      case AppExceptionType.firebaseError:
      case AppExceptionType.firestoreError:
      case AppExceptionType.permissionDenied:
      case AppExceptionType.documentNotFound:
      case AppExceptionType.collectionNotFound:
        return context.strings.databaseErrorTitle;

      // Transaction Errors
      case AppExceptionType.transactionNotFound:
      case AppExceptionType.transactionSaveFailed:
      case AppExceptionType.transactionDeleteFailed:
      case AppExceptionType.transactionUpdateFailed:
      case AppExceptionType.transactionLoadFailed:
      case AppExceptionType.invalidTransactionData:
        return context.strings.transactionErrorTitle;

      // Budget Errors
      case AppExceptionType.budgetCalculationFailed:
      case AppExceptionType.budgetDataInvalid:
        return context.strings.budgetErrorTitle;

      // Settings Errors
      case AppExceptionType.settingsSaveFailed:
      case AppExceptionType.settingsLoadFailed:
        return context.strings.settingsErrorTitle;

      // Validation Errors
      case AppExceptionType.validationError:
      case AppExceptionType.invalidData:
      case AppExceptionType.requiredFieldMissing:
        return context.strings.validationErrorTitle;

      // General Errors
      case AppExceptionType.unexpectedError:
      case AppExceptionType.unknownError:
      case AppExceptionType.dataParsingError:
      case AppExceptionType.cacheError:
      case AppExceptionType.storageError:
        return context.strings.generalErrorTitle;
    }
  }

  String getMessage(BuildContext context) {
    switch (this) {
      // Auth Errors
      case AppExceptionType.userNotFound:
        return context.strings.userNotFoundError;
      case AppExceptionType.wrongPassword:
        return context.strings.wrongPasswordError;
      case AppExceptionType.emailAlreadyInUse:
        return context.strings.emailAlreadyInUseError;
      case AppExceptionType.weakPassword:
        return context.strings.weakPasswordError;
      case AppExceptionType.invalidEmail:
        return context.strings.invalidEmailError;
      case AppExceptionType.userDisabled:
        return context.strings.userDisabledError;
      case AppExceptionType.tooManyRequests:
        return context.strings.tooManyRequestsError;
      case AppExceptionType.operationNotAllowed:
        return context.strings.operationNotAllowedError;
      case AppExceptionType.invalidCredential:
        return context.strings.invalidCredentialError;
      case AppExceptionType.authenticationFailed:
        return context.strings.authenticationFailedError;
      case AppExceptionType.userDataNotFound:
        return context.strings.userDataNotFoundError;
      case AppExceptionType.userNotAuthenticated:
        return context.strings.userNotAuthenticated;
      case AppExceptionType.signUpFailed:
        return context.strings.signUpFailedError;
      case AppExceptionType.signOutFailed:
        return context.strings.signOutFailedError;
      case AppExceptionType.getCurrentUserFailed:
        return context.strings.getCurrentUserFailedError;

      // Network Errors
      case AppExceptionType.networkError:
        return context.strings.networkError;
      case AppExceptionType.connectionTimeout:
        return context.strings.connectionTimeoutError;
      case AppExceptionType.serverError:
        return context.strings.serverError;
      case AppExceptionType.noInternetConnection:
        return context.strings.noInternetConnectionError;

      // Firebase Errors
      case AppExceptionType.firebaseError:
        return context.strings.firebaseError;
      case AppExceptionType.firestoreError:
        return context.strings.firestoreError;
      case AppExceptionType.permissionDenied:
        return context.strings.permissionDeniedError;
      case AppExceptionType.documentNotFound:
        return context.strings.documentNotFoundError;
      case AppExceptionType.collectionNotFound:
        return context.strings.collectionNotFoundError;

      // Transaction Errors
      case AppExceptionType.transactionNotFound:
        return context.strings.transactionNotFoundError;
      case AppExceptionType.transactionSaveFailed:
        return context.strings.transactionSaveFailedError;
      case AppExceptionType.transactionDeleteFailed:
        return context.strings.transactionDeleteFailedError;
      case AppExceptionType.transactionUpdateFailed:
        return context.strings.transactionUpdateFailedError;
      case AppExceptionType.transactionLoadFailed:
        return context.strings.transactionLoadFailedError;
      case AppExceptionType.invalidTransactionData:
        return context.strings.invalidTransactionDataError;

      // Budget Errors
      case AppExceptionType.budgetCalculationFailed:
        return context.strings.budgetCalculationFailedError;
      case AppExceptionType.budgetDataInvalid:
        return context.strings.budgetDataInvalidError;

      // Settings Errors
      case AppExceptionType.settingsSaveFailed:
        return context.strings.settingsSaveFailedError;
      case AppExceptionType.settingsLoadFailed:
        return context.strings.settingsLoadFailedError;

      // Validation Errors
      case AppExceptionType.validationError:
        return context.strings.validationError;
      case AppExceptionType.invalidData:
        return context.strings.invalidDataError;
      case AppExceptionType.requiredFieldMissing:
        return context.strings.requiredFieldMissingError;

      // General Errors
      case AppExceptionType.unexpectedError:
        return context.strings.unexpectedError;
      case AppExceptionType.unknownError:
        return context.strings.unknownError;
      case AppExceptionType.dataParsingError:
        return context.strings.dataParsingError;
      case AppExceptionType.cacheError:
        return context.strings.cacheError;
      case AppExceptionType.storageError:
        return context.strings.storageError;
    }
  }
}
