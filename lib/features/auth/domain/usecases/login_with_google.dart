import 'package:dartz/dartz.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/core/error/failure.dart';
import 'package:histora/core/usecase/usecase.dart';
import 'package:histora/features/auth/domain/entities/login_data.dart';
import 'package:histora/features/auth/domain/repositories/auth_repository.dart';

class LoginWithGoogle implements Usecase<LoginData, NoParams> {
  final AuthRepository repository;

  LoginWithGoogle({required this.repository});
  @override
  Future<Either<Failure, LoginData>> call(NoParams params) async {
    try {
      return await repository.loginWithGoogle();
    } on LoginException catch (e) {
      return Left(LoginFailure(message: e.message));
    } catch (e) {
      return const Left(LoginFailure());
    }
  }
}

class NoParams {}
