import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_photo.dart';

class WeekMealTile extends StatelessWidget {
  const WeekMealTile({required this.meal, super.key});

  static const double width = 136;

  final WeekMeal meal;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    child: Material(
      color: MjColors.onInk,
      borderRadius: MjRadius.item,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => MealDetailPageRoute(id: meal.idea.id.value).push<void>(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 76,
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  MealPhoto(idea: meal.idea),
                  if (meal.status == WeekMealStatus.cooked)
                    Positioned(
                      left: 6,
                      top: 6,
                      child: MjTag(label: t.meals.cookedTag, tone: MjTone.green, icon: some(LucideIcons.check)),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, MjSpacing.small, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    meal.idea.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: MjTextStyles.cardTitle.copyWith(fontSize: 13.5, height: 1.2),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    meal.idea.servings == 1
                        ? t.meals.servingsSingle
                        : t.meals.servingsSeveral(count: meal.idea.servings),
                    style: MjTextStyles.detail.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
