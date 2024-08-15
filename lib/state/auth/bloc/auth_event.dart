part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginWithGoogle extends AuthEvent {}

class LoginWithEmailAndPassword extends AuthEvent {}

class CreateAccountWithEmailAndPassword extends AuthEvent {}

class Logout extends AuthEvent {}

class Listen extends AuthEvent {}
