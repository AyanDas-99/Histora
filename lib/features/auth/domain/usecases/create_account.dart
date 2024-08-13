import 'package:dartz/dartz.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/core/error/failure.dart';
import 'package:histora/core/usecase/usecase.dart';
import 'package:histora/features/auth/domain/entities/login_data.dart';
import 'package:histora/features/auth/domain/repositories/auth_repository.dart';

class CreateAccount implements Usecase<LoginData, EmailParams> {
  final AuthRepository repository;

  CreateAccount({required this.repository});

  @override
  Future<Either<Failure, LoginData>> call(EmailParams params) async {
    try {
      return await repository.createAccountWithEmailAndPassword(
          email: params.email, password: params.password);
    } on CreateAccountException catch (e) {
      return Left(AccountCreationFailure(message: e.message));
    } on InvalidInputException catch (e) {
      return Left(InvalidInputFailure(message: e.message));
    } catch (e) {
      return const Left(AccountCreationFailure());
    }
  }
}

class EmailParams {
  final String email;
  final String password;

  EmailParams({required this.email, required this.password});
}
