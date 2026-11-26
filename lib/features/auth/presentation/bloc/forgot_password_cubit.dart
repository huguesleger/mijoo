import 'package:flutter/foundation.dart';
import 'package:mijoo/config/setup_get_it.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';

part 'package:mijoo/features/auth/presentation/bloc/forgot_password_state.dart';

final class ForgotPasswordCubit extends SafeCubit<ForgotPasswordState> {
  ForgotPasswordCubit({AuthRepository? repository})
    : _repository = repository ?? getIt.get<AuthRepository>(),
      super(const ForgotPasswordEditing(''));

  final AuthRepository _repository;

  void update(String email) => switch (state) {
    ForgotPasswordEditing() || ForgotPasswordFailed() => emit(ForgotPasswordEditing(email)),
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
