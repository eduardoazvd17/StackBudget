import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';

// Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(datasource: ref.read(authDatasourceProvider));
});

abstract class AuthRepository {
  Future<Either<AppException, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<AppException, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<AppException, void>> signOut();

  Future<Either<AppException, UserModel?>> getCurrentUser();

  Stream<User?> get authStateChanges;
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  const AuthRepositoryImpl({required AuthDatasource datasource})
    : _datasource = datasource;

  @override
  Stream<User?> get authStateChanges => _datasource.authStateChanges;

  @override
  Future<Either<AppException, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return ErrorHandler.handle(
      'AuthRepository.signInWithEmailAndPassword',
      onTry:
          () => _datasource.signInWithEmailAndPassword(
            email: email,
            password: password,
          ),
    );
  }

  @override
  Future<Either<AppException, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    return ErrorHandler.handle(
      'AuthRepository.signUpWithEmailAndPassword',
      onTry:
          () => _datasource.signUpWithEmailAndPassword(
            email: email,
            password: password,
            name: name,
          ),
    );
  }

  @override
  Future<Either<AppException, void>> signOut() async {
    return ErrorHandler.handle(
      'AuthRepository.signOut',
      onTry: () => _datasource.signOut(),
    );
  }

  @override
  Future<Either<AppException, UserModel?>> getCurrentUser() async {
    return ErrorHandler.handle(
      'AuthRepository.getCurrentUser',
      onTry: () => _datasource.getCurrentUser(),
    );
  }
}
