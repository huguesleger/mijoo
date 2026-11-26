import 'package:flutter/foundation.dart';
import 'package:mijoo/config/setup_get_it.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/features/auth/domain/entities/account.dart';
import 'package:mijoo/features/auth/domain/auth_repository.dart';

part 'package:mijoo/features/account/presentation/bloc/account_state.dart';

final class AccountCubit extends SafeCubit<AccountState> {
  AccountCubit({required Account account, AuthRepository? repository})
    : _repository = repository ?? getIt.get<AuthRepository>(),
      super(AccountReady(account));

  final AuthRepository _repository;

  Future<void> signOut() {
    if (state is AccountSigningOut) return Future.value();
    final account = state.account;
    emit(AccountSigningOut(account));
    return _repository
        .signOut()
        .match<AccountState>(
          (failure) => AccountSignOutFailed(account, failure),
          (_) => AccountSigningOut(account),
        )
        .map(emit)
        .run();
  }
}
