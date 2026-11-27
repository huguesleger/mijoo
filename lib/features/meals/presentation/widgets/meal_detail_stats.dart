import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_labels.dart';

class MealDetailStats extends StatelessWidget {
  const MealDetailStats({required this.idea, super.key});

  final MealIdea idea;

  @override
  Widget build(BuildContext context) => Row(
    spacing: MjSpacing.small,
    children: <Widget>[
      for (final (IconData icon, String label, String value, MjTone tone) in <(IconData, String, String, MjTone)>[
        (LucideIcons.utensilsCrossed, t.meals.prep, t.meals.minutes(count: idea.prepMinutes), MjTone.lavender),
        (LucideIcons.flame, t.meals.cook, t.meals.minutes(count: idea.cookMinutes), MjTone.apricot),
        (LucideIcons.users, t.meals.people, '${idea.servings}', MjTone.green),
        (LucideIcons.chartNoAxesColumn, t.meals.level, mealDifficultyLabel(idea.difficulty), MjTone.peony),
      ])
        Expanded(
          child: MjInfoTile(icon: icon, label: label, value: value, tone: tone),
        ),
    ],
  );
}
