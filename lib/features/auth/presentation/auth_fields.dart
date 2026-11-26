import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_password_field.dart';
import '../../../core_ui/ds_text_field.dart';
import '../../../core_ui/ds_tokens.dart';
import 'auth_cubit.dart';
import 'auth_mode.dart';
import 'auth_password_rules.dart';

class AuthFields extends StatelessWidget {
  const AuthFields({required this.draft, super.key});

  final AuthDraft draft;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final mismatch =
        draft.confirmation.isNotEmpty &&
        !draft.password.startsWith(draft.confirmation);
    final gap = const SizedBox(height: DsSpacing.fieldGap);
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ...switch (cubit.mode) {
            SignInMode() => const <Widget>[],
            RegisterMode() => [
              DsTextField(
                label: t.auth.name,
                hint: t.auth.nameHint,
                icon: Icons.person_outline_rounded,
                initialValue: draft.name,
                autofillHints: const [AutofillHints.name],
                onChanged: (name) => cubit.update(name: some(name)),
              ),
              gap,
            ],
          },
          DsTextField(
            label: t.auth.email,
            hint: t.auth.emailHint,
            icon: Icons.mail_outline_rounded,
            initialValue: draft.email,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            autocorrect: false,
            onChanged: (email) => cubit.update(email: some(email)),
          ),
          gap,
          DsPasswordField(
            label: t.auth.password,
            hint: t.auth.passwordHint,
            showLabel: t.auth.showPassword,
            hideLabel: t.auth.hidePassword,
            initialValue: draft.password,
            autofillHints: switch (cubit.mode) {
              SignInMode() => const [AutofillHints.password],
              RegisterMode() => const [AutofillHints.newPassword],
            },
            onChanged: (password) => cubit.update(password: some(password)),
          ),
          ...switch (cubit.mode) {
            SignInMode() => const <Widget>[],
            RegisterMode() => [
              AuthPasswordRules(password: draft.password),
              gap,
              DsPasswordField(
                label: t.auth.confirmPassword,
                hint: t.auth.confirmPasswordHint,
                showLabel: t.auth.showPassword,
                hideLabel: t.auth.hidePassword,
                initialValue: draft.confirmation,
                autofillHints: const [AutofillHints.newPassword],
                error: mismatch ? some(t.auth.passwordMismatch) : none(),
                onChanged: (confirmation) =>
                    cubit.update(confirmation: some(confirmation)),
              ),
            ],
          },
        ],
      ),
    );
  }
}
