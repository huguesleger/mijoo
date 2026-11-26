import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/domain/app_failure.dart';
import '../../../core/i18n/translations.g.dart';
import '../../../core/presentation/failure_view.dart';
import '../../../core_ui/ds_link_prompt.dart';
import '../../../core_ui/ds_text_field.dart';
import '../../../core_ui/ds_tokens.dart';
import 'auth_page_route.dart';
import 'forgot_password_cubit.dart';

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
        DsTextField(
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
            const SizedBox(height: DsSpacing.medium),
            FailureView(failure: failure),
          ],
        ),
        const Spacer(),
        const SizedBox(height: DsSpacing.large),
        FilledButton(
          onPressed: cubit.canSubmit(email) ? () => cubit.submit(email) : null,
          child: Text(t.auth.sendResetLink),
        ),
        const SizedBox(height: DsSpacing.small),
        DsLinkPrompt(
          prompt: t.auth.rememberPassword,
          action: t.auth.signIn,
          onPressed: () => context.goNamed(signInRouteName),
        ),
      ],
    );
  }
}
