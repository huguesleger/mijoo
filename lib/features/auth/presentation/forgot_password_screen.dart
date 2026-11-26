import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/features/auth/presentation/bloc/forgot_password_cubit.dart';
import 'package:mijoo/features/auth/presentation/widgets/forgot_password_form.dart';
import 'package:mijoo/features/auth/presentation/widgets/forgot_password_sent_content.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
    builder: (context, state) => MjSheetPage(
      onBack: some(() => const SignInPageRoute().go(context)),
      header: switch (state) {
        ForgotPasswordSent() => MjHeader(
          lead: t.auth.resetSentLead,
          highlight: t.auth.resetSentHighlight,
          subtitle: some(t.auth.resetSentSubtitle),
        ),
        ForgotPasswordEditing() || ForgotPasswordSending() || ForgotPasswordFailed() => MjHeader(
          lead: t.auth.forgotLead,
          highlight: t.auth.forgotHighlight,
          subtitle: some(t.auth.forgotSubtitle),
        ),
      },
      child: switch (state) {
        ForgotPasswordEditing(:final email) => ForgotPasswordForm(
          email: email,
          failure: none(),
        ),
        ForgotPasswordFailed(:final email, :final failure) => ForgotPasswordForm(email: email, failure: some(failure)),
        ForgotPasswordSending() => const MjLoader(),
        ForgotPasswordSent(:final email) => ForgotPasswordSentContent(
          email: email,
        ),
      },
    ),
  );
}
