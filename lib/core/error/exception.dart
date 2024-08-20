class CreateAccountException implements Exception {
  final String? message;
  const CreateAccountException(this.message);
}

class InvalidInputException implements Exception {
  final String message;

  const InvalidInputException(this.message);
}

class LoginException implements Exception {
  final String message;

  const LoginException(this.message);
}

class StructureMetaException implements Exception {
  final String message;

  StructureMetaException(this.message);
}

class StructureException implements Exception {
  final String message;

  StructureException(this.message);
}

class AssetException implements Exception {
  final String message;

  AssetException(this.message);
}

class GpsException implements Exception {
  final String message;

  GpsException(this.message);
}

class AiException implements Exception {
  final String message;

  AiException(this.message);
}
