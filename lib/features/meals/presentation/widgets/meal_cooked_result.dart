import 'package:flutter/foundation.dart';
import 'package:mijoo/features/meals/domain/entities/meal_deduction.dart';

@immutable
sealed class MealCookedResult {
  const MealCookedResult();
}

final class MealCookedUpdateFridge extends MealCookedResult {
  const MealCookedUpdateFridge(this.deductions);

  final List<MealDeduction> deductions;
}

final class MealCookedKeepFridge extends MealCookedResult {
  const MealCookedKeepFridge();
}
