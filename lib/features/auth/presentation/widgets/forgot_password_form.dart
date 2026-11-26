import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/core.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/features/auth/presentation/bloc/forgot_password_cubit.dart';

class ForgotPasswordForm extends StatelessWidget {
  const ForgotPasswordForm({
    required this.email,
    required this.failure,
    super.key,
  });

  final String email;
  final Option<AppFailure> failure;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MjTextField(
          label: t.auth.email,
          hint: t.auth.emailHint,
          icon: LucideIcons.mail,
          initialValue: email,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          autocorrect: false,
          onChanged: cubit.update,
        ),
        ...failure.match(
          () => const <Widget>[],
          (failure) => [
            const SizedBox(height: MjSpacing.medium),
            FailureView(failure: failure),
          ],
        ),
        const Spacer(),
        const SizedBox(height: MjSpacing.large),
        FilledButton(
          onPressed: cubit.canSubmit(email) ? () => cubit.submit(email) : null,
          child: Text(t.auth.sendResetLink),
        ),
        const SizedBox(height: MjSpacing.small),
        MjLinkPrompt(
          prompt: t.auth.rememberPassword,
          action: t.auth.signIn,
          onPressed: () => const SignInPageRoute().go(context),
        ),
      ],
    );
  }
}
