import 'package:flutter/material.dart';
import 'package:stackbudget/src/core/core.dart';

class AppException implements Exception {
  final AppExceptionType type;
  final String? debugMessage;
  final Object? originalException;
  final StackTrace? stackTrace;

  const AppException({
    required this.type,
    this.debugMessage,
    this.originalException,
    this.stackTrace,
  });

  /// Factory constructors for common exception types
  factory AppException.userNotFound([String? debugMessage]) => AppException(
    type: AppExceptionType.userNotFound,
    debugMessage: debugMessage,
  );

  factory AppException.wrongPassword([String? debugMessage]) => AppException(
    type: AppExceptionType.wrongPassword,
    debugMessage: debugMessage,
  );

  factory AppException.emailAlreadyInUse([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.emailAlreadyInUse,
        debugMessage: debugMessage,
      );

  factory AppException.weakPassword([String? debugMessage]) => AppException(
    type: AppExceptionType.weakPassword,
    debugMessage: debugMessage,
  );

  factory AppException.invalidEmail([String? debugMessage]) => AppException(
    type: AppExceptionType.invalidEmail,
    debugMessage: debugMessage,
  );

  factory AppException.userDisabled([String? debugMessage]) => AppException(
    type: AppExceptionType.userDisabled,
    debugMessage: debugMessage,
  );

  factory AppException.tooManyRequests([String? debugMessage]) => AppException(
    type: AppExceptionType.tooManyRequests,
    debugMessage: debugMessage,
  );

  factory AppException.operationNotAllowed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.operationNotAllowed,
        debugMessage: debugMessage,
      );

  factory AppException.invalidCredential([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.invalidCredential,
        debugMessage: debugMessage,
      );

  factory AppException.authenticationFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.authenticationFailed,
        debugMessage: debugMessage,
      );

  factory AppException.signUpFailed([String? debugMessage]) => AppException(
    type: AppExceptionType.signUpFailed,
    debugMessage: debugMessage,
  );

  factory AppException.signOutFailed([String? debugMessage]) => AppException(
    type: AppExceptionType.signOutFailed,
    debugMessage: debugMessage,
  );

  factory AppException.getCurrentUserFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.getCurrentUserFailed,
        debugMessage: debugMessage,
      );

  factory AppException.userDataNotFound([String? debugMessage]) => AppException(
    type: AppExceptionType.userDataNotFound,
    debugMessage: debugMessage,
  );

  factory AppException.userNotAuthenticated([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.userNotAuthenticated,
        debugMessage: debugMessage,
      );

  factory AppException.reauthenticationRequired([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.authenticationFailed,
        debugMessage: debugMessage,
      );

  factory AppException.networkError([String? debugMessage]) => AppException(
    type: AppExceptionType.networkError,
    debugMessage: debugMessage,
  );

  factory AppException.connectionTimeout([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.connectionTimeout,
        debugMessage: debugMessage,
      );

  factory AppException.serverError([String? debugMessage]) => AppException(
    type: AppExceptionType.serverError,
    debugMessage: debugMessage,
  );

  factory AppException.noInternetConnection([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.noInternetConnection,
        debugMessage: debugMessage,
      );

  factory AppException.firebaseError([String? debugMessage]) => AppException(
    type: AppExceptionType.firebaseError,
    debugMessage: debugMessage,
  );

  factory AppException.firestoreError([String? debugMessage]) => AppException(
    type: AppExceptionType.firestoreError,
    debugMessage: debugMessage,
  );

  factory AppException.permissionDenied([String? debugMessage]) => AppException(
    type: AppExceptionType.permissionDenied,
    debugMessage: debugMessage,
  );

  factory AppException.documentNotFound([String? debugMessage]) => AppException(
    type: AppExceptionType.documentNotFound,
    debugMessage: debugMessage,
  );

  factory AppException.transactionNotFound([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.transactionNotFound,
        debugMessage: debugMessage,
      );

  factory AppException.transactionSaveFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.transactionSaveFailed,
        debugMessage: debugMessage,
      );

  factory AppException.transactionDeleteFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.transactionDeleteFailed,
        debugMessage: debugMessage,
      );

  factory AppException.transactionUpdateFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.transactionUpdateFailed,
        debugMessage: debugMessage,
      );

  factory AppException.transactionLoadFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.transactionLoadFailed,
        debugMessage: debugMessage,
      );

  factory AppException.invalidTransactionData([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.invalidTransactionData,
        debugMessage: debugMessage,
      );

  factory AppException.budgetCalculationFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.budgetCalculationFailed,
        debugMessage: debugMessage,
      );

  factory AppException.budgetDataInvalid([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.budgetDataInvalid,
        debugMessage: debugMessage,
      );

  factory AppException.settingsSaveFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.settingsSaveFailed,
        debugMessage: debugMessage,
      );

  factory AppException.settingsLoadFailed([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.settingsLoadFailed,
        debugMessage: debugMessage,
      );

  factory AppException.validationError([String? debugMessage]) => AppException(
    type: AppExceptionType.validationError,
    debugMessage: debugMessage,
  );

  factory AppException.invalidData([String? debugMessage]) => AppException(
    type: AppExceptionType.invalidData,
    debugMessage: debugMessage,
  );

  factory AppException.requiredFieldMissing([String? debugMessage]) =>
      AppException(
        type: AppExceptionType.requiredFieldMissing,
        debugMessage: debugMessage,
      );

  factory AppException.unexpectedError([String? debugMessage]) => AppException(
    type: AppExceptionType.unexpectedError,
    debugMessage: debugMessage,
  );

  factory AppException.unknownError([String? debugMessage]) => AppException(
    type: AppExceptionType.unknownError,
    debugMessage: debugMessage,
  );

  factory AppException.dataParsingError([String? debugMessage]) => AppException(
    type: AppExceptionType.dataParsingError,
    debugMessage: debugMessage,
  );

  factory AppException.cacheError([String? debugMessage]) => AppException(
    type: AppExceptionType.cacheError,
    debugMessage: debugMessage,
  );

  factory AppException.storageError([String? debugMessage]) => AppException(
    type: AppExceptionType.storageError,
    debugMessage: debugMessage,
  );

  /// Get user-friendly title for this exception
  String getTitle(BuildContext context) => type.getTitle(context);

  /// Get user-friendly message for this exception
  String getMessage(BuildContext context) => type.getMessage(context);

  /// Create AppException from Firebase Auth error code
  factory AppException.fromFirebaseAuthError(
    String code, [
    String? debugMessage,
  ]) {
    switch (code) {
      case 'user-not-found':
        return AppException.userNotFound(debugMessage);
      case 'wrong-password':
        return AppException.wrongPassword(debugMessage);
      case 'email-already-in-use':
        return AppException.emailAlreadyInUse(debugMessage);
      case 'weak-password':
        return AppException.weakPassword(debugMessage);
      case 'invalid-email':
        return AppException.invalidEmail(debugMessage);
      case 'user-disabled':
        return AppException.userDisabled(debugMessage);
      case 'too-many-requests':
        return AppException.tooManyRequests(debugMessage);
      case 'operation-not-allowed':
        return AppException.operationNotAllowed(debugMessage);
      case 'invalid-credential':
        return AppException.invalidCredential(debugMessage);
      default:
        return AppException.authenticationFailed(debugMessage ?? code);
    }
  }

  /// Create AppException from any other exception
  factory AppException.fromException(
    Object exception, [
    StackTrace? stackTrace,
  ]) {
    if (exception is AppException) {
      return exception;
    }

    return AppException(
      type: AppExceptionType.unexpectedError,
      debugMessage: exception.toString(),
      originalException: exception,
      stackTrace: stackTrace,
    );
  }

  @override
  String toString() {
    final buffer = StringBuffer('AppException: ${type.name}');
    if (debugMessage != null) {
      buffer.write(' - $debugMessage');
    }
    if (originalException != null) {
      buffer.write('\nOriginal: $originalException');
    }
    return buffer.toString();
  }
}
