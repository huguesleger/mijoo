import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/domain/app_failure.dart';
import '../../../core/i18n/translations.g.dart';
import '../../../core/presentation/failure_view.dart';
import '../../../core_ui/ds_message_view.dart';
import '../../../core_ui/ds_tokens.dart';
import '../domain/account.dart';
import 'auth_cubit.dart';

class AuthAccountContent extends StatelessWidget {
  const AuthAccountContent({
    required this.account,
    required this.failure,
    super.key,
  });

  final Account account;
  final Option<AppFailure> failure;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      DsMessageView(message: t.auth.signedIn),
      const SizedBox(height: DsSpacing.medium),
      ...account.name.match(
        () => const <Widget>[],
        (name) => [Text(name, style: DsTextStyles.body)],
      ),
      Text(account.email, style: DsTextStyles.body),
      ...failure.match(
        () => const <Widget>[],
        (failure) => [
          const SizedBox(height: DsSpacing.medium),
          FailureView(failure: failure),
        ],
      ),
      const SizedBox(height: DsSpacing.large),
      OutlinedButton(
        onPressed: () => context.read<AuthCubit>().signOut(account),
        child: Text(t.auth.signOut),
      ),
    ],
  );
}
