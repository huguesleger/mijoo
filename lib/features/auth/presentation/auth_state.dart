part of 'auth_cubit.dart';

typedef AuthDraft = ({
  String name,
  String email,
  String password,
  String confirmation,
});

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthEditing extends AuthState {
  const AuthEditing(this.draft);
  final AuthDraft draft;
}

final class AuthFailed extends AuthState {
  const AuthFailed(this.draft, this.failure);
  final AuthDraft draft;
  final AppFailure failure;
}

final class AuthSubmitting extends AuthState {
  const AuthSubmitting();
}

final class Authenticated extends AuthState {
  const Authenticated(this.account);
  final Account account;
}
