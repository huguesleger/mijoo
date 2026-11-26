part of 'account_cubit.dart';

@immutable
sealed class AccountState {
  const AccountState(this.account);
  final Account account;
}

final class AccountReady extends AccountState {
  const AccountReady(super.account);
}

final class AccountSigningOut extends AccountState {
  const AccountSigningOut(super.account);
}

final class AccountSignOutFailed extends AccountState {
  const AccountSignOutFailed(super.account, this.failure);
  final AppFailure failure;
}
