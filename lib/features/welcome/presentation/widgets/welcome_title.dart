import 'package:flutter/material.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      text: t.welcome.titleLead,
      children: [
        TextSpan(
          text: t.welcome.titleHighlight,
          style: const TextStyle(color: MjColors.primary),
        ),
      ],
    ),
    textAlign: TextAlign.center,
    style: MjTextStyles.display,
  );
}
