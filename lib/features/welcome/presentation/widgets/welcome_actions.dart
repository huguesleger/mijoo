import 'package:flutter/material.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/router/routes.dart';

class WelcomeActions extends StatelessWidget {
  const WelcomeActions({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FilledButton(
        onPressed: () => const RegisterPageRoute().push<void>(context),
        child: Text(t.auth.register),
      ),
      const SizedBox(height: DsSpacing.small),
      TextButton(
        onPressed: () => const SignInPageRoute().push<void>(context),
        child: Text(t.auth.signIn),
      ),
    ],
  );
}
