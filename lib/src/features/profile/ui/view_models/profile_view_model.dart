import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/profile/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/profile/data/models/models.dart';
import 'package:stackbudget/src/features/profile/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model_state.dart';

class ProfileViewModel extends StateNotifier<ProfileViewModelState> {
  final ProfileRepository _repository;
  final Ref _ref;

  ProfileViewModel(this._repository, this._ref)
    : super(const ProfileInitialState());

  Future<void> loadUserProfile() async {
    state = const ProfileLoadingState();

    final authState = _ref.read(authViewModelProvider);
    if (authState is! AuthenticatedState) {
      state = ProfileErrorState(
        exception: AppException.userNotAuthenticated('User not authenticated'),
      );
      return;
    }

    state = ProfileLoadedState(user: authState.user);
  }

  Future<void> updateName(String newName) async {
    if (state is! ProfileLoadedState) return;

    state = const ProfileNameUpdatingState();

    final request = UpdateNameRequest(newName: newName);
    final result = await _repository.updateName(request);

    result.fold(
      (exception) => state = ProfileErrorState(exception: exception),
      (updatedUser) {
        state = ProfileNameUpdatedState(updatedUser: updatedUser);
        // Atualizar o estado de autenticação também
        _ref.read(authViewModelProvider.notifier).updateUserData(updatedUser);
      },
    );
  }

  Future<void> updatePassword(
    String currentPassword,
    String newPassword,
  ) async {
    state = const ProfilePasswordUpdatingState();

    final request = UpdatePasswordRequest(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );

    final result = await _repository.updatePassword(request);

    result.fold(
      (exception) => state = ProfileErrorState(exception: exception),
      (_) => state = const ProfilePasswordUpdatedState(),
    );
  }

  Future<void> deleteAccount(String currentPassword) async {
    state = const ProfileDeletingAccountState();

    final request = DeleteAccountRequest(currentPassword: currentPassword);
    final result = await _repository.deleteAccount(request);

    result.fold(
      (exception) => state = ProfileErrorState(exception: exception),
      (_) => state = const ProfileAccountDeletedState(),
    );
  }

  void resetState() {
    state = const ProfileInitialState();
  }
}

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileViewModelState>((ref) {
      final datasource = ProfileDatasourceImpl(
        firebaseAuth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      );
      final repository = ProfileRepositoryImpl(datasource: datasource);
      return ProfileViewModel(repository, ref);
    });
