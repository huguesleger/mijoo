import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/fridge_navigation.dart';

class FridgeEmptyView extends StatelessWidget {
  const FridgeEmptyView({super.key});

  @override
  Widget build(BuildContext context) => MjMessageView(
    title: some(t.fridge.emptyTitle),
    message: t.fridge.emptyMessage,
    icon: some(LucideIcons.refrigerator),
    action: some(MjMessageAction(label: t.fridge.add, onPressed: () => openFridgeAddChoice(context))),
    placement: MjMessagePlacement.tab,
  );
}
