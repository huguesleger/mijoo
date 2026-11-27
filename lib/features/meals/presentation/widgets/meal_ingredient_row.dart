import 'package:flutter/material.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_category_style.dart';
import 'package:mijoo/features/fridge/presentation/widgets/fridge_quantity_label.dart';
import 'package:mijoo/features/meals/domain/entities/ingredient_availability.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';

class MealIngredientRow extends StatelessWidget {
  const MealIngredientRow({required this.ingredient, required this.availability, super.key});

  final MealIngredient ingredient;
  final IngredientAvailability availability;

  @override
  Widget build(BuildContext context) {
    final (String line, MjTone tone) = switch (availability) {
      InFridge() => (t.meals.inFridgeLine, MjTone.green),
      NotEnoughInFridge(:final double missing) => (
        t.meals.missingLine(quantity: fridgeQuantityLabel(missing, ingredient.unit)),
        MjTone.apricot,
      ),
      ToBuy() => (t.meals.toBuyLine, MjTone.peony),
    };
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          MjIconTile(
            icon: fridgeCategoryIcon(ingredient.category),
            tone: fridgeCategoryTone(ingredient.category),
            size: 40,
          ),
          const SizedBox(width: MjSpacing.fieldGap),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(ingredient.name, style: MjTextStyles.itemTitle),
                const SizedBox(height: 2),
                Text(
                  switch ((availability, ingredient.substitute.toNullable())) {
                    (InFridge(), _) || (_, null) => line,
                    (_, final String substitute) => t.meals.orSubstituteLine(line: line, substitute: substitute),
                  },
                  style: MjTextStyles.detail.copyWith(fontSize: 11.5, color: tone.foreground),
                ),
              ],
            ),
          ),
          const SizedBox(width: MjSpacing.small),
          Text(
            fridgeQuantityLabel(ingredient.quantity, ingredient.unit),
            style: MjTextStyles.cardTitle.copyWith(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
