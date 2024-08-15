import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  const Failure({this.message});

  @override
  List<Object?> get props => [message];
}

class LoginFailure extends Failure {
  const LoginFailure({super.message});
}

class UserLoadingFailure extends Failure {
  const UserLoadingFailure({super.message});
}

class AccountCreationFailure extends Failure {
  const AccountCreationFailure({super.message});
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure({super.message});
}
