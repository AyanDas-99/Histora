part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthStateLoggedIn extends AuthState {
  final User user;
  const AuthStateLoggedIn({required this.user});
}

class AuthStateLoggedOut extends AuthState {}

class AuthStateUnknown extends AuthState {}

class AuthStateLoading extends AuthState {}

class AuthStateError extends AuthState {
  final Failure failure;

  const AuthStateError({required this.failure});
}
