class CreateAccountException implements Exception {
  final String? message;
  const CreateAccountException(this.message);
}

class InvalidInputException implements Exception {
  final String? message;

  const InvalidInputException(this.message);
}

class LoginException implements Exception {
  final String? message;

  const LoginException(this.message);
}
