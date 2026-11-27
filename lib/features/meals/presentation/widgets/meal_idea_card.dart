import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/router/routes.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_idea_tag.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_meta_row.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_photo.dart';
import 'package:mijoo/features/shopping/domain/rules/meal_cost.dart';
import 'package:mijoo/features/shopping/presentation/widgets/money_labels.dart';

class MealIdeaCard extends StatelessWidget {
  const MealIdeaCard({
    required this.idea,
    required this.items,
    required this.today,
    required this.planned,
    required this.cost,
    required this.overBudget,
    super.key,
  });

  final MealIdea idea;
  final List<FridgeItem> items;
  final DateTime today;
  final bool planned;
  final MealCost cost;
  final bool overBudget;

  @override
  Widget build(BuildContext context) {
    final MealCoverage coverage = mealCoverage(idea, items);
    final String coverageLabel = coverage.inFridge == coverage.total
        ? t.meals.coverageAll
        : t.meals.coverage(count: coverage.inFridge, total: coverage.total);
    return MjPhotoCard(
      onTap: () => MealDetailPageRoute(id: idea.id.value).push<void>(context),
      photo: MealPhoto(idea: idea),
      badge: some(
        switch ((planned, overBudget)) {
          (true, _) => MjTag(label: t.meals.inWeek, tone: MjTone.lavender, icon: some(LucideIcons.calendarCheck)),
          (false, true) => MjTag(label: t.meals.overBudget, tone: MjTone.peony, icon: some(LucideIcons.wallet)),
          (false, false) => MealIdeaTag(
            finishFirst: finishFirstUsed(idea, items, today),
            missing: coverage.total - coverage.inFridge,
          ),
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(idea.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: MjTextStyles.cardTitle),
          const SizedBox(height: 6),
          MealMetaRow(
            idea: idea,
            cost: some(
              cost.cents == 0 && cost.unpriced == 0
                  ? t.meals.costNothing
                  : t.meals.costToBuy(amount: euros(cost.cents)),
            ),
          ),
          const SizedBox(height: MjSpacing.small),
          Text(coverageLabel, style: MjTextStyles.detail),
        ],
      ),
    );
  }
}
