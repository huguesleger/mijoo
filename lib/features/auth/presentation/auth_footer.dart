import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_tokens.dart';
import 'auth_cubit.dart';
import 'auth_mode.dart';
import 'auth_page_route.dart';

class AuthFooter extends StatelessWidget {
  const AuthFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final (prompt, action, route) = switch (context.read<AuthCubit>().mode) {
      SignInMode() => (t.auth.noAccount, t.auth.register, registerRouteName),
      RegisterMode() => (t.auth.haveAccount, t.auth.signIn, signInRouteName),
    };
    return TextButton(
      onPressed: () => context.pushReplacementNamed(route),
      child: Text.rich(
        TextSpan(
          text: prompt,
          style: DsTextStyles.caption,
          children: [
            TextSpan(
              text: action,
              style: DsTextStyles.button.copyWith(
                fontSize: 15,
                color: DsColors.ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
