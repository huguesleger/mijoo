import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';

class MealIdeaTag extends StatelessWidget {
  const MealIdeaTag({required this.finishFirst, required this.missing, super.key});

  final List<FridgeItem> finishFirst;
  final int missing;

  @override
  Widget build(BuildContext context) => switch ((finishFirst.firstOrNull, missing)) {
    (final FridgeItem item?, _) => MjTag(label: item.name, tone: MjTone.peony, icon: some(LucideIcons.flame)),
    (null, 0) => MjTag(label: t.meals.nothingToBuy, tone: MjTone.green, icon: some(LucideIcons.check)),
    (null, 1) => MjTag(label: t.meals.toBuySingle, tone: MjTone.apricot, icon: some(LucideIcons.shoppingBasket)),
    (null, final int count) => MjTag(
      label: t.meals.toBuySeveral(count: count),
      tone: MjTone.apricot,
      icon: some(LucideIcons.shoppingBasket),
    ),
  };
}
