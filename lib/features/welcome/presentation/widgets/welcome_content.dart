import 'package:flutter/material.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/welcome/presentation/widgets/welcome_actions.dart';
import 'package:mijoo/features/welcome/presentation/widgets/welcome_hero_image.dart';
import 'package:mijoo/features/welcome/presentation/widgets/welcome_title.dart';

class WelcomeContent extends StatelessWidget {
  const WelcomeContent({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Center(
        child: Assets.logo.mijooLogo.svg(
          width: DsSpacing.logoWidth,
          semanticsLabel: t.welcome.appName,
        ),
      ),
      const Spacer(),
      const SizedBox(height: DsSpacing.extraLarge),
      const WelcomeHeroImage(),
      const SizedBox(height: DsSpacing.extraLarge),
      const Spacer(),
      const WelcomeTitle(),
      const SizedBox(height: DsSpacing.medium),
      Text(
        t.welcome.subtitle,
        textAlign: TextAlign.center,
        style: DsTextStyles.body,
      ),
      const SizedBox(height: DsSpacing.extraLarge),
      const WelcomeActions(),
    ],
  );
}
