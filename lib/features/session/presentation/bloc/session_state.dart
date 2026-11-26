part of 'package:mijoo/features/session/presentation/bloc/session_cubit.dart';

@immutable
sealed class SessionState {
  const SessionState();
}

final class SessionUnknown extends SessionState {
  const SessionUnknown();
}

final class SignedOut extends SessionState {
  const SignedOut();
}

final class SignedIn extends SessionState {
  const SignedIn(this.account, this.household);
  final Account account;
  final HouseholdStatus household;
}

@immutable
sealed class HouseholdStatus {
  const HouseholdStatus();
}

final class HouseholdLoading extends HouseholdStatus {
  const HouseholdLoading();
}

final class HouseholdMissing extends HouseholdStatus {
  const HouseholdMissing();
}

final class HouseholdFound extends HouseholdStatus {
  const HouseholdFound(this.household);
  final Household household;
}
