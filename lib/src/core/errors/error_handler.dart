import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:stackbudget/src/core/core.dart';

class ErrorHandler {
  static Future<Either<AppException, T>> handle<T>(
    String identifier, {
    required Future<T> Function() onTry,
    Future<AppException> Function(Object error, StackTrace? stackTrace)?
    onCatch,
  }) async {
    try {
      final result = await onTry();
      return Right(result);
    } catch (e, stackTrace) {
      AppException exception;

      if (e is AppException) {
        exception = e;
      } else if (onCatch != null) {
        exception = await onCatch(e, stackTrace);
      } else {
        exception = AppException.fromException(e, stackTrace);
      }

      developer.log(
        exception.toString(),
        name: identifier,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      return Left(exception);
    }
  }

  /// Handle synchronous operations
  static Either<AppException, T> handleSync<T>(
    String identifier, {
    required T Function() onTry,
    AppException Function(Object error, StackTrace? stackTrace)? onCatch,
  }) {
    try {
      final result = onTry();
      return Right(result);
    } catch (e, stackTrace) {
      AppException exception;

      if (e is AppException) {
        exception = e;
      } else if (onCatch != null) {
        exception = onCatch(e, stackTrace);
      } else {
        exception = AppException.fromException(e, stackTrace);
      }

      developer.log(
        exception.toString(),
        name: identifier,
        stackTrace: stackTrace,
        time: DateTime.now(),
      );

      return Left(exception);
    }
  }
}
