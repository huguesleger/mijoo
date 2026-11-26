import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_tokens.dart';
import '../../auth/presentation/auth_page_route.dart';

class WelcomeActions extends StatelessWidget {
  const WelcomeActions({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      FilledButton(
        onPressed: () => context.pushNamed(registerRouteName),
        child: Text(t.auth.register),
      ),
      const SizedBox(height: DsSpacing.small),
      TextButton(
        onPressed: () => context.pushNamed(signInRouteName),
        child: Text(t.auth.signIn),
      ),
    ],
  );
}
