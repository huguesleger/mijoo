import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_labels.dart';

class MealMetaRow extends StatelessWidget {
  const MealMetaRow({required this.idea, this.cost = const None(), super.key});

  final MealIdea idea;
  final Option<String> cost;

  @override
  Widget build(BuildContext context) => Wrap(
    spacing: MjSpacing.fieldGap,
    runSpacing: MjSpacing.extraSmall,
    children: <Widget>[
      for (final (IconData icon, String label) in <(IconData, String)>[
        (LucideIcons.clock3, t.meals.minutes(count: idea.minutes)),
        (LucideIcons.users, t.meals.servingsShort(count: idea.servings)),
        (LucideIcons.chartNoAxesColumn, mealDifficultyLabel(idea.difficulty)),
        ...cost.match(
          () => const <(IconData, String)>[],
          (String cost) => <(IconData, String)>[(LucideIcons.wallet, cost)],
        ),
      ])
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: MjSpacing.extraSmall,
          children: <Widget>[
            Icon(icon, size: 14, color: MjColors.secondaryText),
            Text(label, style: MjTextStyles.detail),
          ],
        ),
    ],
  );
}
