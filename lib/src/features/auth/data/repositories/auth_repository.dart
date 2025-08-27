import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, UserModel?>> getCurrentUser();

  Stream<User?> get authStateChanges;
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _datasource;

  const AuthRepositoryImpl({required AuthDatasource datasource})
    : _datasource = datasource;

  @override
  Stream<User?> get authStateChanges => _datasource.authStateChanges;

  @override
  Future<Either<Failure, UserModel>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _datasource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(user);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserModel>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await _datasource.signUpWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      return Right(user);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await _datasource.signOut();
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, UserModel?>> getCurrentUser() async {
    try {
      final user = await _datasource.getCurrentUser();
      return Right(user);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(Failure(message: 'Erro inesperado: ${e.toString()}'));
    }
  }
}
