import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockHouseholdRepository extends Mock implements HouseholdRepository {}

void main() {
  const household = HouseholdId('h1');
  const me = HouseholdMember(id: AccountId('hugues'), name: 'Hugues');
  late MockHouseholdRepository repository;

  setUp(() {
    repository = MockHouseholdRepository();
    when(() => repository.watchMembers(household)).thenAnswer((_) => Stream.value(right([me])));
    when(() => repository.saveMember(household, me)).thenReturn(TaskEither.right(unit));
  });

  HouseholdMembersCubit build() =>
      HouseholdMembersCubit(household: household, me: me, repository: repository, minimalLoading: Duration.zero);

  blocTest<HouseholdMembersCubit, HouseholdMembersState>(
    'lists the members and introduces the parent to the household',
    build: build,
    act: (cubit) async {
      cubit.watch();
      await cubit.introduceMe();
    },
    expect: () => [
      isA<MembersLoading>(),
      isA<MembersLoaded>().having((it) => it.members.single.name, 'name', 'Hugues'),
    ],
    verify: (_) => verify(() => repository.saveMember(household, me)).called(1),
  );

  blocTest<HouseholdMembersCubit, HouseholdMembersState>(
    'creates an invitation code',
    build: () {
      when(() => repository.createInvite(household, me.id)).thenReturn(TaskEither.right(const InviteCode('MJ4K7Q')));
      return build();
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.createInvite();
    },
    skip: 2,
    expect: () => [
      isA<MembersLoaded>().having((it) => it.invite, 'invite', isA<InviteCreating>()),
      isA<MembersLoaded>().having(
        (it) => it.invite,
        'invite',
        isA<InviteReady>().having((it) => it.code, 'code', const InviteCode('MJ4K7Q')),
      ),
    ],
  );

  blocTest<HouseholdMembersCubit, HouseholdMembersState>(
    'leaves the household, or says why it failed',
    build: () {
      when(
        () => repository.leaveHousehold(household, me.id),
      ).thenReturn(TaskEither.left(const HouseholdNetworkFailure()));
      return build();
    },
    act: (cubit) async {
      cubit.watch();
      await pumpEventQueue();
      await cubit.leave();
    },
    skip: 2,
    expect: () => [
      isA<MembersLoaded>().having((it) => it.leaving, 'leaving', isA<Leaving>()),
      isA<MembersLoaded>().having((it) => it.leaving, 'leaving', isA<LeaveFailed>()),
    ],
  );
}
