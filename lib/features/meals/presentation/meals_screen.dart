import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_plan.dart';
import 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:mijoo/features/meals/presentation/meals_bone_mock.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_failed_view.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_header.dart';
import 'package:mijoo/features/shopping/presentation/shopping_bone_mock.dart';
import 'package:mijoo/features/meals/presentation/widgets/meals_loaded_view.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({required this.profile, super.key});

  final HouseholdProfile profile;

  @override
  Widget build(BuildContext context) => MjPage(
    child: Padding(
      padding: const EdgeInsets.only(bottom: MjSpacing.navigationClearance),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const MealsHeader(),
          const SizedBox(height: MjSpacing.medium),
          BlocBuilder<MealsCubit, MealsState>(
            builder: (BuildContext context, MealsState state) => switch (state) {
              MealsLoading() => MjSkeletonizer(
                child: MealsLoadedView(
                  state: MealsLoaded(
                    plan: some(MealPlan(ideas: mealsBoneMock, craving: MealCraving.any, createdAt: DateTime(2000))),
                    week: const [],
                    shopping: shoppingWeekBoneMock,
                    items: const [],
                    profile: profile,
                    today: DateTime(2000),
                    craving: MealCraving.any,
                    generation: const MealsIdle(),
                  ),
                ),
              ),
              final MealsLoaded loaded => MealsLoadedView(state: loaded),
              MealsFailed(:final failure) => MealsFailedView(
                failure: failure,
                onRetry: context.read<MealsCubit>().watch,
                placement: MjMessagePlacement.tab,
              ),
            },
          ),
        ],
      ),
    ),
  );
}
