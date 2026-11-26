import 'package:flutter/material.dart';

import 'package:mijoo/core_ui/core_ui.dart';

class WelcomeHeroImage extends StatelessWidget {
  const WelcomeHeroImage({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: DsColors.lavenderStrong.withValues(alpha: 0.28),
            blurRadius: 36,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: Assets.images.bolBleu.image(
        width: DsSpacing.heroImageWidth,
        excludeFromSemantics: true,
      ),
    ),
  );
}
