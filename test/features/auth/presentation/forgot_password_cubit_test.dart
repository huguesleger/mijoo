import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/auth_failure.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/auth/presentation/forgot_password_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository repository;

  setUp(() => repository = MockAuthRepository());

  blocTest<ForgotPasswordCubit, ForgotPasswordState>(
    'sends the reset link to the trimmed address',
    build: () {
      when(
        () => repository.sendPasswordReset('camille@example.test'),
      ).thenReturn(TaskEither.right(unit));
      return ForgotPasswordCubit(repository: repository);
    },
    act: (cubit) => cubit.submit(' camille@example.test '),
    expect: () => [
      isA<ForgotPasswordSending>(),
      isA<ForgotPasswordSent>().having(
        (state) => state.email,
        'email',
        'camille@example.test',
      ),
    ],
  );

  blocTest<ForgotPasswordCubit, ForgotPasswordState>(
    'keeps the address when the request fails',
    build: () {
      when(
        () => repository.sendPasswordReset('camille'),
      ).thenReturn(TaskEither.left(const InvalidEmail()));
      return ForgotPasswordCubit(repository: repository);
    },
    act: (cubit) => cubit.submit('camille'),
    expect: () => [
      isA<ForgotPasswordSending>(),
      isA<ForgotPasswordFailed>()
          .having((state) => state.email, 'email', 'camille')
          .having((state) => state.failure, 'failure', const InvalidEmail()),
    ],
  );

  blocTest<ForgotPasswordCubit, ForgotPasswordState>(
    'does nothing without an address',
    build: () => ForgotPasswordCubit(repository: repository),
    act: (cubit) => cubit.submit('  '),
    expect: () => <ForgotPasswordState>[],
    verify: (_) => verifyZeroInteractions(repository),
  );
}
