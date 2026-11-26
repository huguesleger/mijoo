import 'package:flutter/material.dart';

import '../../../core_ui/assets/assets.gen.dart';
import '../../../core_ui/ds_hero_page.dart';
import '../../../core_ui/ds_loader.dart';
import '../../../core_ui/ds_tokens.dart';

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
