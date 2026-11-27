import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/account_button.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class ShoppingHeader extends StatelessWidget {
  const ShoppingHeader({required this.onStore, super.key});

  final VoidCallback? onStore;

  @override
  Widget build(BuildContext context) => MjTabHeader(
    title: t.shopping.title,
    actions: <Widget>[
      MjRoundIconButton(
        icon: LucideIcons.refrigerator,
        tooltip: t.shopping.store,
        highlighted: true,
        onPressed: onStore,
      ),
      const AccountButton(),
    ],
  );
}
