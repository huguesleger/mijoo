part of 'forgot_password_cubit.dart';

@immutable
sealed class ForgotPasswordState {
  const ForgotPasswordState(this.email);
  final String email;
}

final class ForgotPasswordEditing extends ForgotPasswordState {
  const ForgotPasswordEditing(super.email);
}

final class ForgotPasswordSending extends ForgotPasswordState {
  const ForgotPasswordSending(super.email);
}

final class ForgotPasswordSent extends ForgotPasswordState {
  const ForgotPasswordSent(super.email);
}

final class ForgotPasswordFailed extends ForgotPasswordState {
  const ForgotPasswordFailed(super.email, this.failure);
  final AppFailure failure;
}
