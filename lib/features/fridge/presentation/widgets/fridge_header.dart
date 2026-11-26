import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/account_button.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/fridge_navigation.dart';

class FridgeHeader extends StatelessWidget {
  const FridgeHeader({super.key});

  @override
  Widget build(BuildContext context) => MjTabHeader(
    title: t.fridge.title,
    actions: <Widget>[
      MjRoundIconButton(
        icon: LucideIcons.plus,
        tooltip: t.fridge.add,
        highlighted: true,
        onPressed: () => openFridgeItemSheet(context, none()),
      ),
      const AccountButton(),
    ],
  );
}
