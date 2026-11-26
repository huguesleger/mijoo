import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/router/routes.dart';

class ForgotPasswordSentContent extends StatelessWidget {
  const ForgotPasswordSentContent({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const SizedBox(height: MjSpacing.large),
      Center(
        child: Container(
          width: 88,
          height: 88,
          decoration: const BoxDecoration(
            color: MjColors.lavender,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.mailCheck,
            size: 40,
            color: MjColors.ink,
          ),
        ),
      ),
      const SizedBox(height: MjSpacing.large),
      Semantics(
        liveRegion: true,
        child: Text(
          t.auth.resetSentMessage(email: email),
          textAlign: TextAlign.center,
          style: MjTextStyles.body,
        ),
      ),
      const Spacer(),
      const SizedBox(height: MjSpacing.large),
      FilledButton(
        onPressed: () => const SignInPageRoute().go(context),
        child: Text(t.auth.backToSignIn),
      ),
    ],
  );
}
