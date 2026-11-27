import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core/i18n/translations.g.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/presentation/bloc/meals_cubit.dart';

class MealsEmptyView extends StatelessWidget {
  const MealsEmptyView({super.key});

  @override
  Widget build(BuildContext context) => MjMessageView(
    title: some(t.meals.emptyTitle),
    icon: some(LucideIcons.chefHat),
    message: t.meals.emptyMessage,
    action: some(MjMessageAction(label: t.meals.find, onPressed: context.read<MealsCubit>().generate)),
  );
}
