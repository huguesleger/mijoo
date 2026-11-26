import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/account/presentation/account_cubit.dart';
import 'package:mijoo/features/auth/domain/account.dart';
import 'package:mijoo/features/auth/domain/auth_failure.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
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

  blocTest<AccountCubit, AccountState>(
    'shows the failure when signing out fails',
    build: () {
      when(
        () => repository.signOut(),
      ).thenReturn(TaskEither.left(const AuthNetworkFailure()));
      return AccountCubit(account: account, repository: repository);
    },
    act: (cubit) => cubit.signOut(),
    expect: () => [
      isA<AccountSigningOut>(),
      isA<AccountSignOutFailed>().having(
        (state) => state.failure,
        'failure',
        const AuthNetworkFailure(),
      ),
    ],
  );
}
