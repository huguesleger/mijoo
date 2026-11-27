import 'package:flutter/material.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_idea_card.dart';

class MealIdeaList extends StatelessWidget {
  const MealIdeaList({
    required this.ideas,
    required this.items,
    required this.today,
    this.planned = const <MealIdeaId>{},
    super.key,
  });

  final List<MealIdea> ideas;
  final List<FridgeItem> items;
  final DateTime today;
  final Set<MealIdeaId> planned;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: MjSpacing.fieldGap,
    children: <Widget>[
      for (final MealIdea idea in ideas)
        MealIdeaCard(idea: idea, items: items, today: today, planned: planned.contains(idea.id)),
    ],
  );
}
