import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/setup/presentation/bloc/join_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

void main() {
  const me = HouseholdMember(id: AccountId('camille'), name: 'Camille');
  late MockHouseholdRepository repository;

  setUpAll(() {
    registerFallbackValue(me);
    registerFallbackValue(const InviteCode('AAAAAA'));
  });
  setUp(() => repository = MockHouseholdRepository());

  JoinCubit build() => JoinCubit(me: me, repository: repository, minimalLoading: Duration.zero);

  blocTest<JoinCubit, JoinState>(
    'joins the household with a code typed loosely',
    build: () {
      when(() => repository.joinHousehold(me, const InviteCode('MJ4K7Q'))).thenReturn(TaskEither.right(unit));
      return build();
    },
    act: (cubit) async {
      cubit.change('mj-4k7q');
      await cubit.join();
    },
    expect: () => [isA<JoinEditing>(), isA<JoinSending>(), isA<JoinDone>()],
  );

  blocTest<JoinCubit, JoinState>(
    'refuses a code with the wrong shape without asking Firestore',
    build: build,
    act: (cubit) async {
      cubit.change('123');
      await cubit.join();
    },
    expect: () => [
      isA<JoinEditing>(),
      isA<JoinEditing>().having((it) => it.failure, 'failure', some(const InviteNotFound())),
    ],
    verify: (_) => verifyNever(() => repository.joinHousehold(any(), any())),
  );

  blocTest<JoinCubit, JoinState>(
    'keeps the code and explains an expired invitation',
    build: () {
      when(() => repository.joinHousehold(me, any())).thenReturn(TaskEither.left(const InviteExpired()));
      return build();
    },
    act: (cubit) async {
      cubit.change('MJ4K7Q');
      await cubit.join();
    },
    skip: 2,
    expect: () => [
      isA<JoinEditing>()
          .having((it) => it.code, 'code', 'MJ4K7Q')
          .having((it) => it.failure, 'failure', some(const InviteExpired())),
    ],
  );
}
