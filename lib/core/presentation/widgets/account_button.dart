import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class AccountButton extends StatelessWidget {
  const AccountButton({super.key});

  @override
  Widget build(BuildContext context) => MjRoundIconButton(
    icon: LucideIcons.userRound,
    tooltip: t.shell.account,
    onPressed: () => const AccountPageRoute().push<void>(context),
  );
}
