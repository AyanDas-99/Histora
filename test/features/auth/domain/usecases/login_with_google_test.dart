import 'package:dartz/dartz.dart';
import 'package:histora/core/error/exception.dart';
import 'package:histora/core/error/failure.dart';
import 'package:histora/features/auth/domain/entities/login_data.dart';
import 'package:histora/features/auth/domain/repositories/auth_repository.dart';
import 'package:histora/features/auth/domain/usecases/login_with_google.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateMocks([AuthRepository])
import 'login_with_google_test.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginWithGoogle loginWithGoogle;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginWithGoogle = LoginWithGoogle(repository: mockAuthRepository);
  });

  const tLoginData = LoginData(uid: 'test_id');

  void repositoryReturnsSuccess() {
    when(mockAuthRepository.loginWithGoogle())
        .thenAnswer((_) async => const Right(tLoginData));
  }

  test('should call AuthRepository, ', () async {
    // arrange
    repositoryReturnsSuccess();
    // act
    loginWithGoogle(NoParams());
    // assert
    verify(mockAuthRepository.loginWithGoogle());
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('should returns LoginData when repository returns success, ', () async {
    // arrange
    repositoryReturnsSuccess();
    // act
    final result = await loginWithGoogle(NoParams());
    // assert
    expect(result, const Right(tLoginData));
  });

  test('should return LoginFailure when repository throws LoginException, ',
      () async {
    // arrange
    when(mockAuthRepository.loginWithGoogle())
        .thenThrow(const LoginException('failure'));
    // act
    final result = await loginWithGoogle(NoParams());
    // assert
    expect(result, const Left(LoginFailure(message: 'failure')));
  });

  test('should return LoginFailure when repository throws Exception, ',
      () async {
    // arrange
    when(mockAuthRepository.loginWithGoogle()).thenThrow(Exception());
    // act
    final result = await loginWithGoogle(NoParams());
    // assert
    expect(result, const Left(LoginFailure()));
  });
}
