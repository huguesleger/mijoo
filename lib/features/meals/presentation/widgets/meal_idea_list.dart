import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_idea_card.dart';
import 'package:mijoo/features/shopping/domain/entities/price_book.dart';
import 'package:mijoo/features/shopping/domain/rules/meal_cost.dart';

class MealIdeaList extends StatelessWidget {
  const MealIdeaList({
    required this.ideas,
    required this.items,
    required this.today,
    required this.prices,
    required this.remainingCents,
    this.planned = const <MealIdeaId>{},
    super.key,
  });

  final List<MealIdea> ideas;
  final List<FridgeItem> items;
  final DateTime today;
  final Set<MealIdeaId> planned;
  final PriceBook prices;
  final Option<double> remainingCents;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: MjSpacing.fieldGap,
    children: <Widget>[
      for (final MealIdea idea in ideas)
        if (mealCost(idea, items, prices) case final MealCost cost)
          MealIdeaCard(
            idea: idea,
            items: items,
            today: today,
            planned: planned.contains(idea.id),
            cost: cost,
            overBudget: remainingCents.match(
              () => false,
              (double remaining) => cost.cents > 0 && cost.cents > remaining,
            ),
          ),
    ],
  );
}
