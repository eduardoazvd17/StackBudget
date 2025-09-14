import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/features/auth/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';
import 'package:stackbudget/src/features/auth/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/dashboard_view_model.dart';
import 'package:stackbudget/src/features/dashboard/ui/view_models/expansion_state_provider.dart';
import 'package:stackbudget/src/features/profile/ui/view_models/profile_view_model.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/currency_provider.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/locale_provider.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/settings_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/monthly_transaction_view_model.dart';
import 'package:stackbudget/src/features/transactions/ui/view_models/transaction_form_view_model.dart';
import 'package:stackbudget/src/features/settings/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/settings/data/models/settings_model.dart';

final authDatasourceProvider = Provider<AuthDatasource>((ref) {
  return AuthDatasourceImpl(
    firebaseAuth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  );
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(datasource: ref.read(authDatasourceProvider));
});

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthViewModelState>(
      (ref) => AuthViewModel(ref.read(authRepositoryProvider), ref),
    );

class AuthViewModel extends StateNotifier<AuthViewModelState> {
  final AuthRepository _repository;
  final Ref _ref;

  AuthViewModel(this._repository, this._ref) : super(const AuthInitialState()) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _repository.authStateChanges.listen((user) async {
      if (user != null) {
        final result = await _repository.getCurrentUser();
        result.fold((exception) => state = AuthErrorState(exception: exception), (
          userModel,
        ) {
          if (userModel != null) {
            // Se havia um usuário anterior, limpa os dados antes de carregar os novos
            final wasAuthenticated = state is AuthenticatedState;
            if (wasAuthenticated) {
              _clearAllUserData();
            }

            state = AuthenticatedState(user: userModel);
            _syncUserSettings();
          } else {
            state = const UnauthenticatedState();
          }
        });
      } else {
        state = const UnauthenticatedState();
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AuthLoadingState();

    final result = await _repository.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.fold((exception) => state = AuthErrorState(exception: exception), (
      user,
    ) {
      state = AuthenticatedState(user: user);
      _syncUserSettings();
    });
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AuthLoadingState();

    final result = await _repository.signUpWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );

    result.fold((exception) => state = AuthErrorState(exception: exception), (
      user,
    ) {
      state = AuthenticatedState(user: user);
      _syncUserSettings();
    });
  }

  Future<void> signOut() async {
    state = const AuthLoadingState();

    final result = await _repository.signOut();

    result.fold((exception) => state = AuthErrorState(exception: exception), (
      _,
    ) {
      _clearAllUserData();
      state = const UnauthenticatedState();
    });
  }

  void clearError() {
    if (state is AuthErrorState) {
      state = const UnauthenticatedState();
    }
  }

  void updateUserData(UserModel updatedUser) {
    if (state is AuthenticatedState) {
      state = AuthenticatedState(user: updatedUser);
    }
  }

  void _syncUserSettings() {
    try {
      _ref.read(settingsViewModelProvider.notifier).syncSettingsFromFirebase();
    } catch (_) {}
  }

  void _clearAllUserData() {
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

      // Limpa cache local de configurações (exceto preferências da UI)
      _clearLocalSettingsCache();
    } catch (e) {
      // Em caso de erro, apenas loga, não interrompe o logout
      print('Erro ao limpar dados do usuário: $e');
    }
  }

  Future<void> _clearLocalSettingsCache() async {
    try {
      // Limpa apenas as configurações específicas do usuário no SharedPreferences
      // Mantém as preferências de UI como expansão de listas
      final settingsDataSource = _ref.read(settingsDataSourceProvider);
      // Como não temos acesso direto ao SharedPreferences aqui,
      // vamos usar o método existente que limpa as configurações específicas
      final currentSettings = await settingsDataSource.getSettings();
      await settingsDataSource.saveSettings(
        currentSettings.copyWith(
          currency: 'BRL', // Valores padrão
          themeMode: ThemeModeType.system,
          language: 'pt',
        ),
      );
    } catch (e) {
      print('Erro ao limpar cache de configurações: $e');
    }
  }
}
