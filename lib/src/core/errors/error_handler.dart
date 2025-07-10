import 'dart:developer' as developer;

import 'package:dartz/dartz.dart';
import 'package:stackbudget/src/core/core.dart';

class ErrorHandler {
  static Future<Either<Failure, T>> handle<T>(
    String identifier, {
    required Future<T> Function() onTry,
    Future<Failure> Function(Object error)? onCatch,
  }) async {
    try {
      final result = await onTry();
      return Right(result);
    } catch (e) {
      final failure = await onCatch?.call(e) ?? Failure(message: e.toString());
      developer.log(
        onCatch == null ? '$e' : '$e\n${failure.toString()}',
        name: identifier,
        stackTrace: StackTrace.current,
        time: DateTime.now(),
      );
      return Left(failure);
    }
  }
}
