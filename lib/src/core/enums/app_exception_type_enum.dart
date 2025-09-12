import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

enum AppExceptionType {
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

  networkError,
  connectionTimeout,
  serverError,
  noInternetConnection,

  firebaseError,
  firestoreError,
  permissionDenied,
  documentNotFound,
  collectionNotFound,

  transactionNotFound,
  transactionSaveFailed,
  transactionDeleteFailed,
  transactionUpdateFailed,
  transactionLoadFailed,
  invalidTransactionData,

  budgetCalculationFailed,
  budgetDataInvalid,

  settingsSaveFailed,
  settingsLoadFailed,

  validationError,
  invalidData,
  requiredFieldMissing,

  unexpectedError,
  unknownError,
  dataParsingError,
  cacheError,
  storageError;

  String getTitle(BuildContext context) {
    switch (this) {
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

      case AppExceptionType.networkError:
      case AppExceptionType.connectionTimeout:
      case AppExceptionType.serverError:
      case AppExceptionType.noInternetConnection:
        return context.strings.networkErrorTitle;

      case AppExceptionType.firebaseError:
      case AppExceptionType.firestoreError:
      case AppExceptionType.permissionDenied:
      case AppExceptionType.documentNotFound:
      case AppExceptionType.collectionNotFound:
        return context.strings.databaseErrorTitle;

      case AppExceptionType.transactionNotFound:
      case AppExceptionType.transactionSaveFailed:
      case AppExceptionType.transactionDeleteFailed:
      case AppExceptionType.transactionUpdateFailed:
      case AppExceptionType.transactionLoadFailed:
      case AppExceptionType.invalidTransactionData:
        return context.strings.transactionErrorTitle;

      case AppExceptionType.budgetCalculationFailed:
      case AppExceptionType.budgetDataInvalid:
        return context.strings.budgetErrorTitle;

      case AppExceptionType.settingsSaveFailed:
      case AppExceptionType.settingsLoadFailed:
        return context.strings.settingsErrorTitle;

      case AppExceptionType.validationError:
      case AppExceptionType.invalidData:
      case AppExceptionType.requiredFieldMissing:
        return context.strings.validationErrorTitle;

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

      case AppExceptionType.networkError:
        return context.strings.networkError;
      case AppExceptionType.connectionTimeout:
        return context.strings.connectionTimeoutError;
      case AppExceptionType.serverError:
        return context.strings.serverError;
      case AppExceptionType.noInternetConnection:
        return context.strings.noInternetConnectionError;

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

      case AppExceptionType.budgetCalculationFailed:
        return context.strings.budgetCalculationFailedError;
      case AppExceptionType.budgetDataInvalid:
        return context.strings.budgetDataInvalidError;

      case AppExceptionType.settingsSaveFailed:
        return context.strings.settingsSaveFailedError;
      case AppExceptionType.settingsLoadFailed:
        return context.strings.settingsLoadFailedError;

      case AppExceptionType.validationError:
        return context.strings.validationError;
      case AppExceptionType.invalidData:
        return context.strings.invalidDataError;
      case AppExceptionType.requiredFieldMissing:
        return context.strings.requiredFieldMissingError;

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
