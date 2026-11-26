import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:mijoo/features/auth/presentation/widgets/auth_form.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_mode.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) => DsSheetPage(
        onBack: some(() => const WelcomePageRoute().go(context)),
        header: switch (cubit.mode) {
          SignInMode() => DsHeader(
            lead: t.auth.signInLead,
            highlight: t.auth.signInHighlight,
            subtitle: some(t.auth.signInSubtitle),
          ),
          RegisterMode() => DsHeader(
            lead: t.auth.registerLead,
            highlight: t.auth.registerHighlight,
            subtitle: some(t.auth.registerSubtitle),
          ),
        },
        child: switch (state) {
          AuthEditing(:final draft) => AuthForm(draft: draft, failure: none()),
          AuthFailed(:final draft, :final failure) => AuthForm(
            draft: draft,
            failure: some(failure),
          ),
          AuthSubmitting() || Authenticated() => const DsLoader(),
        },
      ),
    );
  }
}
