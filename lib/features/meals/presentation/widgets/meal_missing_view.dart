import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';

class MealMissingView extends StatelessWidget {
  const MealMissingView({super.key});

  @override
  Widget build(BuildContext context) => MjMessageView(
    title: some(t.meals.missingTitle),
    icon: some(LucideIcons.chefHat),
    message: t.meals.missingMessage,
    action: some(MjMessageAction(label: t.meals.back, onPressed: context.pop)),
    placement: MjMessagePlacement.tab,
  );
}
