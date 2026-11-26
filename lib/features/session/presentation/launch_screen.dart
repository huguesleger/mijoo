import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class LaunchScreen extends StatelessWidget {
  const LaunchScreen({super.key});

  @override
  Widget build(BuildContext context) => DsHeroPage(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ExcludeSemantics(
          child: Assets.logo.mijooLogo.svg(width: DsSpacing.logoWidth),
        ),
        const SizedBox(height: DsSpacing.extraLarge),
        const DsLoader(),
      ],
    ),
  );
}
