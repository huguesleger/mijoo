import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core/presentation/widgets/account_button.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';

class MealsHeader extends StatelessWidget {
  const MealsHeader({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MealsCubit, MealsState>(
    builder: (BuildContext context, MealsState state) => MjTabHeader(
      title: t.meals.title,
      actions: <Widget>[
        MjRoundIconButton(
          icon: LucideIcons.refreshCw,
          tooltip: t.meals.refresh,
          highlighted: true,
          onPressed: switch (state) {
            MealsLoaded(generation: MealsIdle() || MealsGenerationFailed()) => context.read<MealsCubit>().generate,
            MealsLoaded(generation: MealsGenerating()) || MealsLoading() || MealsFailed() => null,
          },
        ),
        const AccountButton(),
      ],
    ),
  );
}
