import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:mijoo/features/auth/presentation/bloc/auth_mode.dart';
import 'package:mijoo/core/router/routes.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final (String prompt, String action, VoidCallback open) = switch (context.read<AuthCubit>().mode) {
      SignInMode() => (t.auth.noAccount, t.auth.register, () => const RegisterPageRoute().pushReplacement(context)),
      RegisterMode() => (t.auth.haveAccount, t.auth.signIn, () => const SignInPageRoute().pushReplacement(context)),
    };
    return MjLinkPrompt(
      prompt: prompt,
      action: action,
      onPressed: open,
    );
  }
}
