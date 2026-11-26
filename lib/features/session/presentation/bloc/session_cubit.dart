import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/config/setup_get_it.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';
import 'package:mijoo/features/household/domain/entities/household.dart';
import 'package:mijoo/features/household/domain/household_repository.dart';

part 'package:mijoo/features/session/presentation/bloc/session_state.dart';

final class SessionCubit extends SafeCubit<SessionState> {
  SessionCubit({
    AuthRepository? authRepository,
    HouseholdRepository? householdRepository,
  }) : _households = householdRepository ?? getIt.get<HouseholdRepository>(),
       super(const SessionUnknown()) {
    _accounts = (authRepository ?? getIt.get<AuthRepository>()).watchSession().listen(_follow);
  }

  final HouseholdRepository _households;
  late final StreamSubscription<Option<Account>> _accounts;
  StreamSubscription<Option<Household>>? _household;

  void _follow(Option<Account> account) {
    unawaited(_household?.cancel());
    _household = null;
    account.match(() => emit(const SignedOut()), (account) {
      emit(SignedIn(account, const HouseholdLoading()));
      _household = _households
          .watchHousehold(account.id)
          .listen(
            (household) => emit(
              SignedIn(
                account,
                household.match(
                  () => const HouseholdMissing(),
                  HouseholdFound.new,
                ),
              ),
            ),
          );
    });
  }

  @override
  Future<void> close() async {
    await _accounts.cancel();
    await _household?.cancel();
    return super.close();
  }
}
