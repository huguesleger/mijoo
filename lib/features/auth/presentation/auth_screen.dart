import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_loader.dart';
import '../../../core_ui/ds_sheet_page.dart';
import 'auth_account_content.dart';
import 'auth_cubit.dart';
import 'auth_form.dart';
import 'auth_header.dart';
import 'auth_mode.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => DsSheetPage(
        onBack: () => context.go('/'),
        header: switch (state) {
          Authenticated() || AuthSigningOut() || AuthSignOutFailed() =>
            AuthHeader(lead: t.auth.account, highlight: '', subtitle: none()),
          AuthEditing() ||
          AuthFailed() ||
          AuthSubmitting() => switch (cubit.mode) {
            SignInMode() => AuthHeader(
              lead: t.auth.signInLead,
              highlight: t.auth.signInHighlight,
              subtitle: some(t.auth.signInSubtitle),
            ),
            RegisterMode() => AuthHeader(
              lead: t.auth.registerLead,
              highlight: t.auth.registerHighlight,
              subtitle: some(t.auth.registerSubtitle),
            ),
          },
        },
        child: switch (state) {
          AuthEditing(:final draft) => AuthForm(draft: draft, failure: none()),
          AuthFailed(:final draft, :final failure) => AuthForm(
            draft: draft,
            failure: some(failure),
          ),
          AuthSubmitting() || AuthSigningOut() => const DsLoader(),
          Authenticated(:final account) => AuthAccountContent(
            account: account,
            failure: none(),
          ),
          AuthSignOutFailed(:final account, :final failure) =>
            AuthAccountContent(account: account, failure: some(failure)),
        },
      ),
    );
  }
}
