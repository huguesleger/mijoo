import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';

part 'package:mijoo/features/account/presentation/bloc/household_members_state.dart';

final class HouseholdMembersCubit extends SafeCubit<HouseholdMembersState> {
  HouseholdMembersCubit({
    required HouseholdId household,
    required HouseholdMember me,
    HouseholdRepository? repository,
    Duration? minimalLoading,
  }) : _household = household,
       _me = me,
       _repository = repository ?? getIt.get<HouseholdRepository>(),
       _minimalLoading = minimalLoading ?? MjLoader.minDuration,
       super(const MembersLoading());

  final HouseholdId _household;
  final HouseholdMember _me;
  final HouseholdRepository _repository;
  final Duration _minimalLoading;
  StreamSubscription<Either<AppFailure, List<HouseholdMember>>>? _members;

  void watch() {
    unawaited(_members?.cancel());
    emit(const MembersLoading());
    _members = _repository
        .watchMembers(_household)
        .listen(
          (Either<AppFailure, List<HouseholdMember>> result) => emit(
            result.match<HouseholdMembersState>(
              MembersFailed.new,
              (List<HouseholdMember> members) => switch (state) {
                final MembersLoaded loaded => loaded.copyWith(members: members),
                MembersLoading() || MembersFailed() => MembersLoaded(
                  members: members,
                  me: _me.id,
                  invite: const InviteIdle(),
                  leaving: const LeaveIdle(),
                ),
              },
            ),
          ),
        );
  }

  Future<void> introduceMe() => _repository.saveMember(_household, _me).match((_) => null, (_) => null).run();

  Future<void> createInvite() => switch (state) {
    MembersLoaded(invite: InviteCreating()) => Future<void>.value(),
    final MembersLoaded loaded => _createInvite(loaded),
    MembersLoading() || MembersFailed() => Future<void>.value(),
  };

  Future<void> _createInvite(MembersLoaded loaded) {
    emit(loaded.copyWith(invite: const InviteCreating()));
    return _repository
        .createInvite(_household, _me.id)
        .withMinimalDelay(_minimalLoading)
        .match<InviteStatus>(InviteFailed.new, InviteReady.new)
        .map(
          (InviteStatus invite) => switch (state) {
            final MembersLoaded current => emit(current.copyWith(invite: invite)),
            MembersLoading() || MembersFailed() => null,
          },
        )
        .run();
  }

  Future<void> leave() => switch (state) {
    MembersLoaded(leaving: Leaving()) => Future<void>.value(),
    final MembersLoaded loaded => _leave(loaded),
    MembersLoading() || MembersFailed() => Future<void>.value(),
  };

  Future<void> _leave(MembersLoaded loaded) {
    emit(loaded.copyWith(leaving: const Leaving()));
    unawaited(_members?.cancel());
    return _repository
        .leaveHousehold(_household, _me.id)
        .withMinimalDelay(_minimalLoading)
        .match<LeaveStatus>(LeaveFailed.new, (_) => const Leaving())
        .map(
          (LeaveStatus leaving) => switch (state) {
            final MembersLoaded current => emit(current.copyWith(leaving: leaving)),
            MembersLoading() || MembersFailed() => null,
          },
        )
        .run();
  }

  @override
  Future<void> close() async {
    await _members?.cancel();
    return super.close();
  }
}
