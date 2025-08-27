import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stackbudget/src/features/auth/data/datasources/datasources.dart';
import 'package:stackbudget/src/features/auth/data/repositories/repositories.dart';
import 'package:stackbudget/src/features/auth/ui/view_models/auth_view_model_state.dart';

class AuthViewModel extends StateNotifier<AuthViewModelState> {
  final AuthRepository _repository;

  AuthViewModel(this._repository) : super(const AuthInitialState()) {
    _listenToAuthChanges();
  }

  void _listenToAuthChanges() {
    _repository.authStateChanges.listen((user) async {
      if (user != null) {
        final result = await _repository.getCurrentUser();
        result.fold(
          (failure) => state = AuthErrorState(message: failure.message),
          (userModel) {
            if (userModel != null) {
              state = AuthenticatedState(user: userModel);
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

    result.fold(
      (failure) => state = AuthErrorState(message: failure.message),
      (user) => state = AuthenticatedState(user: user),
    );
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

    result.fold(
      (failure) => state = AuthErrorState(message: failure.message),
      (user) => state = AuthenticatedState(user: user),
    );
  }

  Future<void> signOut() async {
    state = const AuthLoadingState();

    final result = await _repository.signOut();

    result.fold(
      (failure) => state = AuthErrorState(message: failure.message),
      (_) => state = const UnauthenticatedState(),
    );
  }

  void clearError() {
    if (state is AuthErrorState) {
      state = const UnauthenticatedState();
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
      (ref) => AuthViewModel(ref.read(authRepositoryProvider)),
    );
