import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../core/i18n/translations.g.dart';
import '../../../core_ui/ds_message_view.dart';
import '../../../core_ui/ds_page.dart';
import '../../../core_ui/ds_tokens.dart';
import '../../account/presentation/account_page_route.dart';

class ShellTabScreen extends StatelessWidget {
  const ShellTabScreen({required this.title, super.key});

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
              onPressed: () => context.pushNamed(accountRouteName),
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
