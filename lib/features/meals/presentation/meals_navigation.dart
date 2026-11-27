import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';
import 'package:mijoo/features/meals/domain/rules/meal_deductions.dart';
import 'package:mijoo/features/meals/presentation/bloc/meal_detail_cubit.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_cooked_result.dart';
import 'package:mijoo/features/meals/presentation/widgets/meal_cooked_sheet.dart';

Future<void> openMealCookedSheet(BuildContext context, MealDetailReady ready) async {
  final MealDetailCubit cubit = context.read<MealDetailCubit>();
  final MealCookedResult? result = await MjBottomSheet.show<MealCookedResult>(
    context,
    builder: (_) => MealCookedSheet(proposed: proposedDeductions(ready.meal, ready.items)),
  );
  await switch (result) {
    MealCookedUpdateFridge(:final List<MealDeduction> deductions) => cubit.cook(deductions),
    MealCookedKeepFridge() => cubit.cook(const <MealDeduction>[]),
    null => Future<void>.value(),
  };
}
