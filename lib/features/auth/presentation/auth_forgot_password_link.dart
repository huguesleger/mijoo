import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_tokens.dart';
import 'auth_page_route.dart';

class AuthForgotPasswordLink extends StatelessWidget {
  const AuthForgotPasswordLink({super.key});

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      style: TextButton.styleFrom(
        minimumSize: const Size(0, DsSpacing.tapTarget),
        textStyle: DsTextStyles.button.copyWith(fontSize: 15),
      ),
      onPressed: () => context.pushNamed(forgotPasswordRouteName),
      child: Text(t.auth.forgotPassword),
    ),
  );
}
