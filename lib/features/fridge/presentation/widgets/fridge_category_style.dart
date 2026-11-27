import 'package:flutter/widgets.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:mijoo/core_ui/core_ui.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';

IconData fridgeCategoryIcon(FridgeCategory category) => switch (category) {
  FridgeCategory.fruitsVegetables => LucideIcons.carrot,
  FridgeCategory.meatFish => LucideIcons.beef,
  FridgeCategory.dairy => LucideIcons.milk,
  FridgeCategory.grocery => LucideIcons.package,
  FridgeCategory.frozen => LucideIcons.snowflake,
  FridgeCategory.drinks => LucideIcons.cupSoda,
  FridgeCategory.other => LucideIcons.shoppingBasket,
};

MjTone fridgeCategoryTone(FridgeCategory category) => switch (category) {
  FridgeCategory.fruitsVegetables => MjTone.green,
  FridgeCategory.meatFish => MjTone.peony,
  FridgeCategory.dairy => MjTone.lavender,
  FridgeCategory.grocery => MjTone.apricot,
  FridgeCategory.frozen => MjTone.glacier,
  FridgeCategory.drinks || FridgeCategory.other => MjTone.neutral,
};
