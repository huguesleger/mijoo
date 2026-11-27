part of 'package:mijoo/features/setup/presentation/bloc/join_cubit.dart';

@immutable
sealed class JoinState {
  const JoinState();
}

final class JoinEditing extends JoinState {
  const JoinEditing({required this.code, required this.failure});

  final String code;
  final Option<AppFailure> failure;
}

final class JoinSending extends JoinState {
  const JoinSending(this.code);

  final String code;
}

final class JoinDone extends JoinState {
  const JoinDone();
}
