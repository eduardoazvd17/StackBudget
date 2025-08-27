import 'package:stackbudget/src/features/auth/data/models/models.dart';

abstract class AuthViewModelState {
  const AuthViewModelState();
}

class AuthInitialState extends AuthViewModelState {
  const AuthInitialState();
}

class AuthLoadingState extends AuthViewModelState {
  const AuthLoadingState();
}

class AuthenticatedState extends AuthViewModelState {
  final UserModel user;

  const AuthenticatedState({required this.user});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthenticatedState && other.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class UnauthenticatedState extends AuthViewModelState {
  const UnauthenticatedState();
}

class AuthErrorState extends AuthViewModelState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AuthErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
