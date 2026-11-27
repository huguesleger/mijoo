import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';

class MealDetailTags extends StatelessWidget {
  const MealDetailTags({required this.finishFirst, required this.coverage, super.key});

  final List<FridgeItem> finishFirst;
  final MealCoverage coverage;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: MjSpacing.small,
    runSpacing: MjSpacing.small,
    children: <Widget>[
      for (final FridgeItem item in finishFirst)
        MjTag(
          label: t.meals.finishFirst(name: item.name),
          tone: MjTone.peony,
          icon: some(LucideIcons.flame),
        ),
      MjTag(
        label: t.meals.inFridgeCount(count: coverage.inFridge, total: coverage.total),
        tone: MjTone.green,
        icon: some(LucideIcons.refrigerator),
      ),
    ],
  );
}
