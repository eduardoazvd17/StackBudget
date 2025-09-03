import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';

abstract class ProfileViewModelState {
  const ProfileViewModelState();
}

class ProfileInitialState extends ProfileViewModelState {
  const ProfileInitialState();
}

class ProfileLoadingState extends ProfileViewModelState {
  const ProfileLoadingState();
}

class ProfileLoadedState extends ProfileViewModelState {
  final UserModel user;

  const ProfileLoadedState({required this.user});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileLoadedState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class ProfileErrorState extends ProfileViewModelState {
  final AppException exception;

  const ProfileErrorState({required this.exception});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileErrorState && other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;
}

class ProfileNameUpdatingState extends ProfileViewModelState {
  const ProfileNameUpdatingState();
}

class ProfileNameUpdatedState extends ProfileViewModelState {
  final UserModel updatedUser;

  const ProfileNameUpdatedState({required this.updatedUser});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileNameUpdatedState && other.updatedUser == updatedUser;
  }

  @override
  int get hashCode => updatedUser.hashCode;
}

class ProfilePasswordUpdatingState extends ProfileViewModelState {
  const ProfilePasswordUpdatingState();
}

class ProfilePasswordUpdatedState extends ProfileViewModelState {
  const ProfilePasswordUpdatedState();
}

class ProfileDeletingAccountState extends ProfileViewModelState {
  const ProfileDeletingAccountState();
}

class ProfileAccountDeletedState extends ProfileViewModelState {
  const ProfileAccountDeletedState();
}
