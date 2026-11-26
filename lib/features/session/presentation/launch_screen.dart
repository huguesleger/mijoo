import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) => MjHeroPage(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExcludeSemantics(
          child: Assets.logo.mijooLogo.svg(width: MjSpacing.logoWidth),
        ),
        const SizedBox(height: MjSpacing.extraLarge),
        const MjLoader(),
      ],
    ),
  );
}
