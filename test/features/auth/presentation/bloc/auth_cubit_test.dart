import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/auth/domain/auth_failure.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_mode.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const draft = (
    name: ' Camille ',
    email: ' camille@example.test ',
    password: 'Password-test1',
    confirmation: 'Password-test1',
  );
  const account = Account(
    id: AccountId('example'),
    email: 'camille@example.test',
    name: Some('Camille'),
  );
  late MockAuthRepository repository;

  setUp(() => repository = MockAuthRepository());

  blocTest<AuthCubit, AuthState>(
    'registers with trimmed name and email and emits the authenticated account',
    build: () {
      when(
        () => repository.register(
          'Camille',
          'camille@example.test',
          'Password-test1',
        ),
      ).thenReturn(TaskEither.right(account));
      return AuthCubit(
        mode: const RegisterMode(),
        repository: repository,
        minimalLoading: Duration.zero,
      );
    },
    act: (cubit) => cubit.submit(draft),
    expect: () => [
      isA<AuthSubmitting>(),
      isA<Authenticated>().having((state) => state.account, 'account', account),
    ],
    verify: (_) => verify(
      () => repository.register(
        'Camille',
        'camille@example.test',
        'Password-test1',
      ),
    ).called(1),
  );

  blocTest<AuthCubit, AuthState>(
    'keeps form entries when Firebase rejects a sign-in',
    build: () {
      when(
        () => repository.signIn('camille@example.test', 'Password-test1'),
      ).thenReturn(TaskEither.left(const InvalidCredentials()));
      return AuthCubit(
        mode: const SignInMode(),
        repository: repository,
        minimalLoading: Duration.zero,
      );
    },
    act: (cubit) => cubit.submit(draft),
    expect: () => [
      isA<AuthSubmitting>(),
      isA<AuthFailed>()
          .having((state) => state.draft, 'draft', draft)
          .having(
            (state) => state.failure,
            'failure',
            const InvalidCredentials(),
          ),
    ],
  );

  blocTest<AuthCubit, AuthState>(
    'does not register without a name',
    build: () => AuthCubit(
      mode: const RegisterMode(),
      repository: repository,
      minimalLoading: Duration.zero,
    ),
    act: (cubit) => cubit.submit((
      name: '',
      email: draft.email,
      password: draft.password,
      confirmation: draft.confirmation,
    )),
    expect: () => <AuthState>[],
    verify: (_) => verifyZeroInteractions(repository),
  );
  blocTest<AuthCubit, AuthState>(
    'does not register when the confirmation differs',
    build: () => AuthCubit(
      mode: const RegisterMode(),
      repository: repository,
      minimalLoading: Duration.zero,
    ),
    act: (cubit) => cubit.submit((
      name: draft.name,
      email: draft.email,
      password: draft.password,
      confirmation: 'Password-test2',
    )),
    expect: () => <AuthState>[],
    verify: (_) => verifyZeroInteractions(repository),
  );

  blocTest<AuthCubit, AuthState>(
    'does not register when a password rule is missing',
    build: () => AuthCubit(
      mode: const RegisterMode(),
      repository: repository,
      minimalLoading: Duration.zero,
    ),
    act: (cubit) => cubit.submit((
      name: draft.name,
      email: draft.email,
      password: 'password-test',
      confirmation: 'password-test',
    )),
    expect: () => <AuthState>[],
    verify: (_) => verifyZeroInteractions(repository),
  );
}
