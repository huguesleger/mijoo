import 'package:flutter/material.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/router/routes.dart';

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
      onPressed: () => const ForgotPasswordPageRoute().push<void>(context),
      child: Text(t.auth.forgotPassword),
    ),
  );
}
