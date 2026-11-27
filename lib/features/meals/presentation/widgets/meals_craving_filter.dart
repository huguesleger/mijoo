import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_kind_style.dart';

class MealsCravingFilter extends StatelessWidget {
  const MealsCravingFilter({required this.selected, super.key});

  final MealCraving selected;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    clipBehavior: Clip.none,
    child: Row(
      spacing: MjSpacing.small,
      children: <Widget>[
        for (final MealCraving craving in MealCraving.values)
          MjChoiceChip(
            label: t.meals.cravings[craving.name] ?? craving.name,
            icon: some(mealCravingIcon(craving)),
            selected: craving == selected,
            onTap: () => context.read<MealsCubit>().choose(craving),
          ),
      ],
    ),
  );
}
