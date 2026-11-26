import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:mijoo/features/auth/presentation/widgets/auth_fields.dart';
import 'package:mijoo/features/auth/presentation/widgets/auth_footer.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_mode.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({required this.draft, required this.failure, super.key});

  final AuthDraft draft;
  final Option<AppFailure> failure;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthFields(draft: draft),
        ...failure.match(
          () => const <Widget>[],
          (failure) => [
            const SizedBox(height: DsSpacing.medium),
            FailureView(failure: failure),
          ],
        ),
        const Spacer(),
        const SizedBox(height: DsSpacing.large),
        FilledButton(
          onPressed: cubit.canSubmit(draft) ? () => cubit.submit(draft) : null,
          child: Text(switch (cubit.mode) {
            SignInMode() => t.auth.signIn,
            RegisterMode() => t.auth.registerSubmit,
          }),
        ),
        const SizedBox(height: DsSpacing.small),
        const AuthFooter(),
      ],
    );
  }
}
