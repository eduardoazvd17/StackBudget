import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/features/auth/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/auth/data/models/models.dart';
import 'package:stackbudget/src/features/auth/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';
import 'package:stackbudget/src/features/settings/ui/view_models/settings_view_model.dart';

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
        result.fold(
          (exception) => state = AuthErrorState(exception: exception),
          (userModel) {
            if (userModel != null) {
              state = AuthenticatedState(user: userModel);
              // Sincronizar configurações do Firebase após login bem-sucedido
              _syncUserSettings();
            } else {
              state = const UnauthenticatedState();
            }
          },
        );
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
      // Sincronizar configurações do Firebase após login bem-sucedido
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
      // Sincronizar configurações do Firebase após cadastro bem-sucedido
      _syncUserSettings();
    });
  }

  Future<void> signOut() async {
    state = const AuthLoadingState();

    final result = await _repository.signOut();

    result.fold(
      (exception) => state = AuthErrorState(exception: exception),
      (_) => state = const UnauthenticatedState(),
    );
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

  /// Sincroniza as configurações do usuário do Firebase
  void _syncUserSettings() {
    try {
      _ref.read(settingsViewModelProvider.notifier).syncSettingsFromFirebase();
    } catch (e) {
      // Ignora erros de sincronização para não interromper o fluxo de login
    }
  }
}

// Providers
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
