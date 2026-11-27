import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/rules/meal_servings.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';

class MealServingsStepper extends StatelessWidget {
  const MealServingsStepper({required this.servings, required this.planned, super.key});

  final int servings;
  final int planned;

  @override
  Widget build(BuildContext context) {
    final MealDetailCubit cubit = context.read<MealDetailCubit>();
    return Container(
      padding: const EdgeInsets.fromLTRB(14, MjSpacing.small, MjSpacing.small, MjSpacing.small),
      decoration: BoxDecoration(
        color: MjColors.onInk,
        borderRadius: MjRadius.item,
        border: Border.all(color: MjColors.cardBorder),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Semantics(
              liveRegion: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    servings == 1 ? t.meals.servingsTitleSingle : t.meals.servingsTitleSeveral(count: servings),
                    style: MjTextStyles.cardTitle.copyWith(fontSize: 15),
                  ),
                  Text(
                    servings == planned ? t.meals.servingsFollow : t.meals.servingsBase(count: planned),
                    style: MjTextStyles.detail.copyWith(fontSize: 11.5),
                  ),
                ],
              ),
            ),
          ),
          MjStepButton(
            icon: LucideIcons.minus,
            tooltip: t.meals.fewerPeople,
            onPressed: servings > minServings ? () => cubit.changeServings(servings - 1) : null,
          ),
          const SizedBox(width: MjSpacing.small),
          MjStepButton(
            icon: LucideIcons.plus,
            tooltip: t.meals.morePeople,
            filled: true,
            onPressed: servings < maxServings ? () => cubit.changeServings(servings + 1) : null,
          ),
        ],
      ),
    );
  }
}
