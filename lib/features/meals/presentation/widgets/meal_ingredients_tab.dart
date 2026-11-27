import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_ingredient_row.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_label_note.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_servings_stepper.dart';

class MealIngredientsTab extends StatelessWidget {
  const MealIngredientsTab({required this.ready, super.key});

  final MealDetailReady ready;

  @override
  Widget build(BuildContext context) {
    final MealIdea meal = ready.meal;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        MealServingsStepper(servings: ready.servings, planned: ready.idea.servings),
        const SizedBox(height: 10),
        MjListCard(
          child: Column(
            children: <Widget>[
              for (final (int index, MealIngredient ingredient) in meal.ingredients.indexed) ...<Widget>[
                if (index > 0) const Divider(height: 1, color: MjColors.cardBorder),
                MealIngredientRow(
                  ingredient: ingredient,
                  availability: ingredientAvailability(ingredient, ready.items),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: MjSpacing.fieldGap),
        MealLabelNote(allergies: ready.profile.allergies),
      ],
    );
  }
}
