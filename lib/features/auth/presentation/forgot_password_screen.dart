import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_loader.dart';
import '../../../core_ui/ds_sheet_page.dart';
import 'auth_header.dart';
import 'auth_page_route.dart';
import 'forgot_password_cubit.dart';
import 'forgot_password_form.dart';
import 'forgot_password_sent_content.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (context, state) => DsSheetPage(
          onBack: () => context.goNamed(signInRouteName),
          header: switch (state) {
            ForgotPasswordSent() => AuthHeader(
              lead: t.auth.resetSentLead,
              highlight: t.auth.resetSentHighlight,
              subtitle: some(t.auth.resetSentSubtitle),
            ),
            ForgotPasswordEditing() ||
            ForgotPasswordSending() ||
            ForgotPasswordFailed() => AuthHeader(
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
            ForgotPasswordFailed(:final email, :final failure) =>
              ForgotPasswordForm(email: email, failure: some(failure)),
            ForgotPasswordSending() => const DsLoader(),
            ForgotPasswordSent(:final email) => ForgotPasswordSentContent(
              email: email,
            ),
          },
        ),
      );
}
