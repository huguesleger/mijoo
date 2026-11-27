import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';
import 'package:mijoo/core/core.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household_member.dart';
import 'package:mijoo/features/household/domain/entities/invite_code.dart';
import 'package:mijoo/features/household/domain/household_failure.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';
import 'package:mijoo/features/household/domain/rules/invite_codes.dart';

part 'package:mijoo/features/setup/presentation/bloc/join_state.dart';

final class JoinCubit extends SafeCubit<JoinState> {
  JoinCubit({required HouseholdMember me, HouseholdRepository? repository, Duration? minimalLoading})
    : _me = me,
      _repository = repository ?? getIt.get<HouseholdRepository>(),
      _minimalLoading = minimalLoading ?? MjLoader.minDuration,
      super(JoinEditing(code: '', failure: none()));

  final HouseholdMember _me;
  final HouseholdRepository _repository;
  final Duration _minimalLoading;

  void change(String code) => switch (state) {
    JoinEditing() => emit(JoinEditing(code: code, failure: none())),
    JoinSending() || JoinDone() => null,
  };

  Future<void> join() => switch (state) {
    JoinEditing(:final String code) => parseInviteCode(code).match(
      () => Future<void>.sync(() => emit(JoinEditing(code: code, failure: some(const InviteNotFound())))),
      (InviteCode invite) => _join(code, invite),
    ),
    JoinSending() || JoinDone() => Future<void>.value(),
  };

  Future<void> _join(String code, InviteCode invite) {
    emit(JoinSending(code));
    return _repository
        .joinHousehold(_me, invite)
        .withMinimalDelay(_minimalLoading)
        .match<JoinState>(
          (AppFailure failure) => JoinEditing(code: code, failure: some(failure)),
          (_) => const JoinDone(),
        )
        .map(emit)
        .run();
  }
}
