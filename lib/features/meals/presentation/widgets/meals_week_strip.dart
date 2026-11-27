import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/presentation/widgets/week_meal_tile.dart';

class MealsWeekStrip extends StatelessWidget {
  const MealsWeekStrip({required this.week, super.key});

  final List<WeekMeal> week;

  @override
  Widget build(BuildContext context) {
    final int portions = week.fold(0, (int total, WeekMeal meal) => total + meal.idea.servings);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MjSectionTitle(
          title: t.meals.week,
          trailing: some(
            Text(
              week.length == 1
                  ? t.meals.weekSummarySingle(portions: portions)
                  : t.meals.weekSummarySeveral(count: week.length, portions: portions),
              style: MjTextStyles.detail,
            ),
          ),
        ),
        const SizedBox(height: MjSpacing.small),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: <Widget>[for (final WeekMeal meal in week) WeekMealTile(meal: meal)],
          ),
        ),
      ],
    );
  }
}
