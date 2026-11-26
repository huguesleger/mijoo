import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/core/router/routes.dart';

class TabPlaceholder extends StatelessWidget {
  const TabPlaceholder({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) => DsPage(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: Semantics(
                header: true,
                child: Text(title, style: DsTextStyles.headline),
              ),
            ),
            IconButton(
              tooltip: t.shell.account,
              onPressed: () => const AccountPageRoute().push<void>(context),
              icon: const Icon(LucideIcons.userRound),
              style: IconButton.styleFrom(
                backgroundColor: DsColors.surface,
                foregroundColor: DsColors.ink,
                fixedSize: const Size.square(DsSpacing.tapTarget),
              ),
            ),
          ],
        ),
        const SizedBox(height: DsSpacing.large),
        DsMessageView(message: t.shell.comingSoon),
      ],
    ),
  );
}
