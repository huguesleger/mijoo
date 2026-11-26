import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../../core/domain/app_failure.dart';
import '../../../core/presentation/safe_cubit.dart';
import '../../auth/domain/account.dart';
import '../../auth/domain/auth_repository.dart';

part 'account_state.dart';

final class AccountCubit extends SafeCubit<AccountState> {
  AccountCubit({required Account account, AuthRepository? repository})
    : _repository = repository ?? GetIt.I.get<AuthRepository>(),
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
