import 'package:flutter/material.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_tokens.dart';

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({super.key});

  @override
  Widget build(BuildContext context) => Text.rich(
    TextSpan(
      text: t.welcome.titleLead,
      children: [
        TextSpan(
          text: t.welcome.titleHighlight,
          style: const TextStyle(color: DsColors.primary),
        ),
      ],
    ),
    textAlign: TextAlign.center,
    style: DsTextStyles.display,
  );
}
