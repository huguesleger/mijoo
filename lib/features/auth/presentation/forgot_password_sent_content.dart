import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_tokens.dart';
import 'auth_page_route.dart';

class ForgotPasswordSentContent extends StatelessWidget {
  const ForgotPasswordSentContent({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      const SizedBox(height: DsSpacing.large),
      Center(
        child: Container(
          width: 88,
          height: 88,
          decoration: const BoxDecoration(
            color: DsColors.lavender,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            LucideIcons.mailCheck,
            size: 40,
            color: DsColors.ink,
          ),
        ),
      ),
      const SizedBox(height: DsSpacing.large),
      Semantics(
        liveRegion: true,
        child: Text(
          t.auth.resetSentMessage(email: email),
          textAlign: TextAlign.center,
          style: DsTextStyles.body,
        ),
      ),
      const Spacer(),
      const SizedBox(height: DsSpacing.large),
      FilledButton(
        onPressed: () => context.goNamed(signInRouteName),
        child: Text(t.auth.backToSignIn),
      ),
    ],
  );
}
