import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/presentation/meals_bone_mock.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_idea_list.dart';
import 'package:mijoo/features/shopping/presentation/shopping_bone_mock.dart';

class MealsGeneratingView extends StatelessWidget {
  const MealsGeneratingView({required this.itemCount, super.key});

  final int itemCount;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Semantics(
        liveRegion: true,
        child: MjMessageView(
          title: some(t.meals.generatingTitle),
          icon: some(LucideIcons.chefHat),
          message: switch (itemCount) {
            0 => t.meals.generatingEmptyFridge,
            1 => t.meals.generatingSingle,
            final int count => t.meals.generatingSeveral(count: count),
          },
        ),
      ),
      const SizedBox(height: MjSpacing.fieldGap),
      MjSkeletonizer(
        child: MealIdeaList(
          ideas: mealsBoneMock,
          items: const [],
          today: DateTime(2000),
          prices: shoppingWeekBoneMock.prices,
          remainingCents: none(),
        ),
      ),
    ],
  );
}
