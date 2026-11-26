import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/auth/domain/rules/password_rule.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_mode.dart';

part 'package:mijoo/features/auth/presentation/bloc/auth_state.dart';

final class AuthCubit extends SafeCubit<AuthState> {
  AuthCubit({
    required this.mode,
    AuthRepository? repository,
    Duration? minimalLoading,
  }) : _repository = repository ?? getIt.get<AuthRepository>(),
       _minimalLoading = minimalLoading ?? MjLoader.minDuration,
       super(const AuthEditing(_emptyDraft));

  static const _emptyDraft = (
    name: '',
    email: '',
    password: '',
    confirmation: '',
  );

  final AuthMode mode;
  final AuthRepository _repository;
  final Duration _minimalLoading;

  void update({
    Option<String> name = const None(),
    Option<String> email = const None(),
    Option<String> password = const None(),
    Option<String> confirmation = const None(),
  }) {
    final draft = switch (state) {
      AuthEditing(:final draft) || AuthFailed(:final draft) => some(draft),
      AuthSubmitting() || Authenticated() => none<AuthDraft>(),
    };
    draft.match(() {}, (draft) {
      emit(
        AuthEditing((
          name: name.getOrElse(() => draft.name),
          email: email.getOrElse(() => draft.email),
          password: password.getOrElse(() => draft.password),
          confirmation: confirmation.getOrElse(() => draft.confirmation),
        )),
      );
    });
  }

  Future<void> submit(AuthDraft draft) {
    if (state is AuthSubmitting || !canSubmit(draft)) {
      return Future.value();
    }
    emit(const AuthSubmitting());
    final operation = switch (mode) {
      SignInMode() => _repository.signIn(draft.email.trim(), draft.password),
      RegisterMode() => _repository.register(
        draft.name.trim(),
        draft.email.trim(),
        draft.password,
      ),
    };
    return operation
        .withMinimalDelay(_minimalLoading)
        .match<AuthState>((AppFailure failure) => AuthFailed(draft, failure), Authenticated.new)
        .map(emit)
        .run();
  }

  bool canSubmit(AuthDraft draft) =>
      draft.email.trim().isNotEmpty &&
      draft.password.isNotEmpty &&
      switch (mode) {
        SignInMode() => true,
        RegisterMode() =>
          draft.name.trim().isNotEmpty && PasswordRule.allMetBy(draft.password) && draft.confirmation == draft.password,
      };
}
