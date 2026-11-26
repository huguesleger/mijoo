import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

import '../../../core/domain/app_failure.dart';
import '../../../core/presentation/safe_cubit.dart';
import '../../../core_ui/ds_loader.dart';
import '../domain/account.dart';
import '../domain/auth_repository.dart';
import '../domain/password_rule.dart';
import 'auth_mode.dart';

part 'auth_state.dart';

final class AuthCubit extends SafeCubit<AuthState> {
  AuthCubit({
    required this.mode,
    AuthRepository? repository,
    Duration? minimalLoading,
  }) : _repository = repository ?? GetIt.I.get<AuthRepository>(),
       _minimalLoading = minimalLoading ?? DsLoader.minDuration,
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
    return _finish(
      operation.match<AuthState>(
        (failure) => AuthFailed(draft, failure),
        Authenticated.new,
      ),
    );
  }

  bool canSubmit(AuthDraft draft) =>
      draft.email.trim().isNotEmpty &&
      draft.password.isNotEmpty &&
      switch (mode) {
        SignInMode() => true,
        RegisterMode() =>
          draft.name.trim().isNotEmpty &&
              PasswordRule.allMetBy(draft.password) &&
              draft.confirmation == draft.password,
      };

  Future<void> _finish(Task<AuthState> outcome) {
    final loading = Stopwatch()..start();
    return outcome
        .flatMap((result) {
          final remaining = _minimalLoading - loading.elapsed;
          final task = Task.of(result);
          return remaining > Duration.zero ? task.delay(remaining) : task;
        })
        .map(emit)
        .run();
  }
}
