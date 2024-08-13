import 'package:dartz/dartz.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/core/error/failure.dart';
import 'package:histora/features/auth/domain/entities/login_data.dart';
import 'package:histora/features/auth/domain/repositories/auth_repository.dart';
import 'package:histora/features/auth/domain/usecases/create_account.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([AuthRepository])
import 'create_account_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late CreateAccount createAccount;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    createAccount = CreateAccount(repository: mockAuthRepository);
  });

  const tLoginData = LoginData(uid: 'test_id');

  void repositoryReturnsSuccess() {
    when(mockAuthRepository.createAccountWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenAnswer((_) async => const Right(tLoginData));
  }

  test('should call AuthRepository, ', () async {
    // arrange
    repositoryReturnsSuccess();
    // act
    createAccount(EmailParams(email: 'email', password: 'password'));
    // assert
    verify(mockAuthRepository.createAccountWithEmailAndPassword(
        email: 'email', password: 'password'));
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should returns LoginData when repository returns success, ', () async {
    // arrange
    repositoryReturnsSuccess();
    // act
    final result =
        await createAccount(EmailParams(email: 'email', password: 'password'));
    // assert
    expect(result, const Right(tLoginData));
  });

  test(
      'should return AccountCreationFailure when repository throws CreateAccountException, ',
      () async {
    // arrange
    when(mockAuthRepository.createAccountWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenThrow(CreateAccountException('failure'));
    // act
    final result =
        await createAccount(EmailParams(email: 'email', password: 'password'));
    // assert
    expect(result, const Left(AccountCreationFailure(message: 'failure')));
  });

  test(
      'should return AccountCreationFailure when repository throws CreateAccountException, ',
      () async {
    // arrange
    when(mockAuthRepository.createAccountWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenThrow(InvalidInputException('failure'));
    // act
    final result =
        await createAccount(EmailParams(email: 'email', password: 'password'));
    // assert
    expect(result, const Left(InvalidInputFailure(message: 'failure')));
  });

  test('should return AccountCreationFailure when repository throws Exception, ',
      () async {
    // arrange
    when(mockAuthRepository.createAccountWithEmailAndPassword(
            email: anyNamed('email'), password: anyNamed('password')))
        .thenThrow(Exception());
    // act
    final result = await createAccount(
        EmailParams(email: 'email', password: 'password'));
    // assert
    expect(result, const Left(AccountCreationFailure()));
  });
}
