import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';
import 'package:stackbudget/src/features/profile/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/profile/data/models/models.dart';

// Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(datasource: ref.read(profileDatasourceProvider));
});

abstract class ProfileRepository {
  Future<Either<AppException, UserModel>> updateName(UpdateNameRequest request);
  Future<Either<AppException, void>> updatePassword(
    UpdatePasswordRequest request,
  );
  Future<Either<AppException, void>> deleteAccount(
    DeleteAccountRequest request,
  );
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _datasource;

  const ProfileRepositoryImpl({required ProfileDatasource datasource})
    : _datasource = datasource;

  @override
  Future<Either<AppException, UserModel>> updateName(
    UpdateNameRequest request,
  ) async {
    return ErrorHandler.handle(
      'ProfileRepository.updateName',
      onTry: () => _datasource.updateName(request),
    );
  }

  @override
  Future<Either<AppException, void>> updatePassword(
    UpdatePasswordRequest request,
  ) async {
    return ErrorHandler.handle(
      'ProfileRepository.updatePassword',
      onTry: () => _datasource.updatePassword(request),
    );
  }

  @override
  Future<Either<AppException, void>> deleteAccount(
    DeleteAccountRequest request,
  ) async {
    return ErrorHandler.handle(
      'ProfileRepository.deleteAccount',
      onTry: () => _datasource.deleteAccount(request),
    );
  }
}
