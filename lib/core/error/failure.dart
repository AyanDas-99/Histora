import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class LoginFailure extends Failure {
  const LoginFailure({this.message});
  final String? message;

  @override
  List<Object?> get props => [message];
}

class AccountCreationFailure extends Failure {
  final String? message;

  const AccountCreationFailure({this.message});

  @override
  List<Object?> get props => [message];
}

class InvalidInputFailure extends Failure {
  final String? message;

  const InvalidInputFailure({this.message});

  @override
  List<Object?> get props => [message];
}
