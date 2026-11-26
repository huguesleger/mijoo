import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:fpdart/fpdart.dart';
import 'package:get_it/get_it.dart';

import '../../../core/presentation/safe_cubit.dart';
import '../../auth/domain/account.dart';
import '../../auth/domain/auth_repository.dart';

part 'session_state.dart';

final class SessionCubit extends SafeCubit<SessionState> {
  SessionCubit({AuthRepository? repository}) : super(const SessionUnknown()) {
    _subscription = (repository ?? GetIt.I.get<AuthRepository>())
        .watchSession()
        .listen(
          (account) => emit(
            account.match<SessionState>(() => const SignedOut(), SignedIn.new),
          ),
        );
  }

  late final StreamSubscription<Option<Account>> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
