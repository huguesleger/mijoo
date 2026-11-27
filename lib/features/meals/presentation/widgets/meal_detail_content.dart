import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/rules/meal_stock.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_detail_stats.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_detail_tags.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_ingredients_tab.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_steps_tab.dart';

class MealDetailContent extends StatelessWidget {
  const MealDetailContent({required this.ready, super.key});

  final MealDetailReady ready;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Semantics(header: true, child: Text(ready.idea.title, style: MjTextStyles.sheetTitle.copyWith(fontSize: 25))),
      if (ready.idea.description.isNotEmpty) ...<Widget>[
        const SizedBox(height: 6),
        Text(ready.idea.description, style: MjTextStyles.detail),
      ],
      const SizedBox(height: MjSpacing.medium),
      MealDetailStats(idea: ready.meal),
      const SizedBox(height: MjSpacing.fieldGap),
      MealDetailTags(
        finishFirst: finishFirstUsed(ready.idea, ready.items, ready.today),
        coverage: mealCoverage(ready.idea, ready.items),
      ),
      const SizedBox(height: MjSpacing.medium),
      MjSegmentedControl<MealDetailTab>(
        options: <(MealDetailTab, String)>[
          (MealDetailTab.ingredients, t.meals.tabIngredients),
          (MealDetailTab.steps, t.meals.tabSteps),
        ],
        selected: ready.tab,
        onChanged: context.read<MealDetailCubit>().showTab,
      ),
      const SizedBox(height: MjSpacing.fieldGap),
      switch (ready.tab) {
        MealDetailTab.ingredients => MealIngredientsTab(ready: ready),
        MealDetailTab.steps => MealStepsTab(meal: ready.meal),
      },
    ],
  );
}
