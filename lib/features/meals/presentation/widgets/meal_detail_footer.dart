import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/failure_view.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';
import 'package:mijoo/features/meals/presentation/meals_navigation.dart';

class MealDetailFooter extends StatelessWidget {
  const MealDetailFooter({required this.ready, super.key});

  final MealDetailReady ready;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    spacing: MjSpacing.small,
    children: <Widget>[
      ...switch ((ready.cooking, ready.writeFailure)) {
        (MealCookingFailed(:final failure), _) || (_, Some(value: final failure)) => <Widget>[
          FailureView(failure: failure),
        ],
        (MealCookingIdle() || MealCookingSaving() || MealCookingDone(), None()) => const <Widget>[],
      },
      switch (ready.cooking) {
        MealCookingSaving() || MealCookingDone() => const MjLoader(),
        MealCookingIdle() || MealCookingFailed() => FilledButton.icon(
          onPressed: () => openMealCookedSheet(context, ready),
          icon: const Icon(LucideIcons.chefHat),
          label: Text(t.meals.cooked),
        ),
      },
      TextButton.icon(
        onPressed: context.read<MealDetailCubit>().toggleWeek,
        icon: Icon(ready.week.isSome() ? LucideIcons.calendarX : LucideIcons.calendarPlus, size: 18),
        label: Text(ready.week.isSome() ? t.meals.removeFromWeek : t.meals.addToWeek),
      ),
    ],
  );
}
