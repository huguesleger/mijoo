import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_kind.dart';

IconData mealKindIcon(MealKind kind) => switch (kind) {
  MealKind.salad => LucideIcons.salad,
  MealKind.pasta => LucideIcons.cookingPot,
  MealKind.rice => LucideIcons.wheat,
  MealKind.soup => LucideIcons.soup,
  MealKind.oven => LucideIcons.flame,
  MealKind.pan => LucideIcons.chefHat,
  MealKind.other => LucideIcons.utensils,
};

MjTone mealKindTone(MealKind kind) => switch (kind) {
  MealKind.salad => MjTone.green,
  MealKind.pasta || MealKind.oven => MjTone.apricot,
  MealKind.rice || MealKind.other => MjTone.glacier,
  MealKind.soup => MjTone.lavender,
  MealKind.pan => MjTone.peony,
};

IconData mealCravingIcon(MealCraving craving) => switch (craving) {
  MealCraving.any => LucideIcons.shuffle,
  MealCraving.quick => LucideIcons.zap,
  MealCraving.vegetarian => LucideIcons.leaf,
  MealCraving.comforting => LucideIcons.soup,
};
