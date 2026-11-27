import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_freshness.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/domain/entities/week_meal.dart';
import 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_idea_list.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_budget_banner.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_constraints_card.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_craving_filter.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_empty_view.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_failed_view.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_generating_view.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_week_strip.dart';
import 'package:mijoo/features/shopping/domain/rules/meal_cost.dart';
import 'package:mijoo/features/shopping/domain/rules/week_budget_rules.dart';

class MealsLoadedView extends StatelessWidget {
  const MealsLoadedView({required this.state, super.key});

  final MealsLoaded state;

  @override
  Widget build(BuildContext context) {
    final Option<double> remaining = weekBudget(
      state.shopping,
      state.profile.weeklyBudgetCents,
      state.today,
    ).remainingCents;
    final int overBudget = state.plan.match(
      () => 0,
      (MealPlan plan) => remaining.match(
        () => 0,
        (double left) => plan.ideas.where((MealIdea idea) {
          final double cost = mealCost(idea, state.items, state.shopping.prices).cents;
          return cost > 0 && cost > left;
        }).length,
      ),
    );
    final Widget ideas = state.plan.match(
      () => const MealsEmptyView(),
      (MealPlan plan) => MealIdeaList(
        ideas: plan.ideas,
        items: state.items,
        today: state.today,
        planned: <MealIdeaId>{for (final WeekMeal meal in state.week) meal.idea.id},
        prices: state.shopping.prices,
        remainingCents: remaining,
      ),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (state.week.isNotEmpty) ...<Widget>[
          MealsWeekStrip(week: state.week),
          const SizedBox(height: MjSpacing.large),
          MjSectionTitle(title: t.meals.tonight),
          const SizedBox(height: MjSpacing.small),
        ],
        MealsConstraintsCard(
          profile: state.profile,
          toFinish: fridgeFreshnessSummary(state.items, state.today).toFinish,
        ),
        const SizedBox(height: MjSpacing.fieldGap),
        MealsCravingFilter(selected: state.craving),
        const SizedBox(height: MjSpacing.medium),
        ...switch (state.generation) {
          MealsGenerating() => <Widget>[MealsGeneratingView(itemCount: state.items.length)],
          MealsGenerationFailed(:final failure) => <Widget>[
            MealsFailedView(
              failure: failure,
              onRetry: context.read<MealsCubit>().generate,
              placement: MjMessagePlacement.card,
            ),
            if (state.plan.isSome()) ...<Widget>[const SizedBox(height: MjSpacing.fieldGap), ideas],
          ],
          MealsIdle() => <Widget>[
            if (remaining.toNullable() case final double left when overBudget > 0) ...<Widget>[
              MealsBudgetBanner(remainingCents: left, overBudget: overBudget),
              const SizedBox(height: MjSpacing.fieldGap),
            ],
            ideas,
          ],
        },
      ],
    );
  }
}
