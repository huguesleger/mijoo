part of 'package:mijoo/features/account/presentation/bloc/household_members_cubit.dart';

@immutable
sealed class HouseholdMembersState {
  const HouseholdMembersState();
}

final class MembersLoading extends HouseholdMembersState {
  const MembersLoading();
}

final class MembersFailed extends HouseholdMembersState {
  const MembersFailed(this.failure);

  final AppFailure failure;
}

final class MembersLoaded extends HouseholdMembersState {
  const MembersLoaded({required this.members, required this.me, required this.invite, required this.leaving});

  final List<HouseholdMember> members;
  final AccountId me;
  final InviteStatus invite;
  final LeaveStatus leaving;

  MembersLoaded copyWith({List<HouseholdMember>? members, InviteStatus? invite, LeaveStatus? leaving}) => MembersLoaded(
    members: members ?? this.members,
    me: me,
    invite: invite ?? this.invite,
    leaving: leaving ?? this.leaving,
  );
}

@immutable
sealed class InviteStatus {
  const InviteStatus();
}

final class InviteIdle extends InviteStatus {
  const InviteIdle();
}

final class InviteCreating extends InviteStatus {
  const InviteCreating();
}

final class InviteReady extends InviteStatus {
  const InviteReady(this.code);

  final InviteCode code;
}

final class InviteFailed extends InviteStatus {
  const InviteFailed(this.failure);

  final AppFailure failure;
}

@immutable
sealed class LeaveStatus {
  const LeaveStatus();
}

final class LeaveIdle extends LeaveStatus {
  const LeaveIdle();
}

final class Leaving extends LeaveStatus {
  const Leaving();
}

final class LeaveFailed extends LeaveStatus {
  const LeaveFailed(this.failure);

  final AppFailure failure;
}
