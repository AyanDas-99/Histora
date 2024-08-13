import 'package:dartz/dartz.dart';
import 'package:histora/core/error/failure.dart';
import 'package:histora/features/auth/domain/entities/login_data.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginData>> createAccountWithEmailAndPassword(
      {required String email, required String password});
  Future<Either<Failure, LoginData>> loginWithEmailAndPassword(
      {required String email, required String password});

  Future<Either<Failure, LoginData>> loginWithGoogle();
  Future<Either<Failure, void>> logout();
}
