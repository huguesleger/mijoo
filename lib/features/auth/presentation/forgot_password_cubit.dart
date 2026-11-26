import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../../core/domain/app_failure.dart';
import '../../../core/presentation/safe_cubit.dart';
import '../domain/auth_repository.dart';

part 'forgot_password_state.dart';

final class ForgotPasswordCubit extends SafeCubit<ForgotPasswordState> {
  ForgotPasswordCubit({AuthRepository? repository})
    : _repository = repository ?? GetIt.I.get<AuthRepository>(),
      super(const ForgotPasswordEditing(''));

  final AuthRepository _repository;

  void update(String email) => switch (state) {
    ForgotPasswordEditing() ||
    ForgotPasswordFailed() => emit(ForgotPasswordEditing(email)),
    ForgotPasswordSending() || ForgotPasswordSent() => null,
  };

  bool canSubmit(String email) => email.trim().isNotEmpty;

  Future<void> submit(String email) {
    if (state is ForgotPasswordSending || !canSubmit(email)) {
      return Future.value();
    }
    final trimmed = email.trim();
    emit(ForgotPasswordSending(trimmed));
    return _repository
        .sendPasswordReset(trimmed)
        .match<ForgotPasswordState>(
          (failure) => ForgotPasswordFailed(trimmed, failure),
          (_) => ForgotPasswordSent(trimmed),
        )
        .map(emit)
        .run();
  }
}
