import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/account.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/session/presentation/session_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  const account = Account(
    id: AccountId('example'),
    email: 'camille@example.test',
    name: Some('Camille'),
  );
  late MockAuthRepository repository;

  setUp(() => repository = MockAuthRepository());

  blocTest<SessionCubit, SessionState>(
    'follows the Firebase session',
    build: () {
      when(
        () => repository.watchSession(),
      ).thenAnswer((_) => Stream.fromIterable([none(), some(account), none()]));
      return SessionCubit(repository: repository);
    },
    expect: () => [
      isA<SignedOut>(),
      isA<SignedIn>().having((state) => state.account, 'account', account),
      isA<SignedOut>(),
    ],
  );
}
