import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/core/errors/errors.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/expansion_state_provider.dart';
import 'package:stackbudget/src/features/profile/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/profile/data/models/models.dart';
import 'package:stackbudget/src/features/profile/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model_state.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/currency_provider.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/locale_provider.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/settings_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/monthly_transaction_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model.dart';

final profileViewModelProvider =
    StateNotifierProvider<ProfileViewModel, ProfileViewModelState>((ref) {
      final datasource = ProfileDatasourceImpl(
        firebaseAuth: FirebaseAuth.instance,
        firestore: FirebaseFirestore.instance,
      );
      final repository = ProfileRepositoryImpl(datasource: datasource);
      return ProfileViewModel(repository, ref);
    });

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
      (_) {
        // Limpa todos os dados locais imediatamente após deleção bem-sucedida
        _clearAllLocalData();
        state = const ProfileAccountDeletedState();
      },
    );
  }

  void _clearAllLocalData() {
    try {
      // Limpa dados do dashboard
      _ref.invalidate(dashboardViewModelProvider);

      // Limpa dados dos formulários de transação
      _ref.invalidate(transactionFormViewModelProvider);
      _ref.invalidate(monthlyTransactionViewModelProvider);

      // Limpa dados do perfil
      _ref.invalidate(profileViewModelProvider);

      // Limpa período selecionado
      _ref.invalidate(selectedPeriodProvider);

      // Limpa dados do expansion state
      _ref.invalidate(expansionStateProvider);

      // Limpa dados dos providers de configurações
      _ref.invalidate(settingsViewModelProvider);
      _ref.invalidate(currencyProvider);
      _ref.invalidate(localeProvider);
      _ref.invalidate(themeModeProvider);
    } catch (e) {
      // Em caso de erro, apenas loga, não interrompe o processo
      print('Erro ao limpar dados locais após deleção: $e');
    }
  }

  void resetState() {
    state = const ProfileInitialState();
  }
}
