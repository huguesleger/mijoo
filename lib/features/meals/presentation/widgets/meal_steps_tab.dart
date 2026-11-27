import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_step.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_step_card.dart';

class MealStepsTab extends StatelessWidget {
  const MealStepsTab({required this.meal, super.key});

  final MealIdea meal;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: 10,
    children: <Widget>[
      Wrap(
        spacing: MjSpacing.small,
        runSpacing: MjSpacing.small,
        children: <Widget>[
          for (final String tool in meal.equipment)
            MjTag(label: tool, tone: MjTone.lavender, icon: some(LucideIcons.cookingPot)),
          MjTag(
            label: meal.steps.length == 1
                ? t.meals.stepCountSingle
                : t.meals.stepCountSeveral(count: meal.steps.length),
            tone: MjTone.lavender,
            icon: some(LucideIcons.listOrdered),
          ),
        ],
      ),
      for (final (int index, MealStep step) in meal.steps.indexed) MealStepCard(number: index + 1, step: step),
    ],
  );
}
