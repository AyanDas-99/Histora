import 'package:dartz/dartz.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/core/error/failure.dart';
import 'package:histora/core/usecase/usecase.dart';
import 'package:histora/features/auth/domain/entities/login_data.dart';
import 'package:histora/features/auth/domain/repositories/auth_repository.dart';
import 'package:histora/features/auth/domain/usecases/create_account.dart';

class LoginWithEmailPassword implements Usecase<LoginData, EmailParams> {
  final AuthRepository repository;

  LoginWithEmailPassword({required this.repository});
  @override
  Future<Either<Failure, LoginData>> call(EmailParams params) async {
    try {
      return await repository.loginWithEmailAndPassword(
          email: params.email, password: params.password);
    } on LoginException catch (e) {
      return Left(LoginFailure(message: e.message));
    } catch (e) {
      return const Left(LoginFailure());
    }
  }
}
