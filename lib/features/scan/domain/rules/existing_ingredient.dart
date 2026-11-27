import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_quantity.dart';
import 'package:mijoo/features/fridge/domain/rules/ingredient_names.dart';

Option<FridgeItem> existingIngredient(FridgeItemInput input, List<FridgeItem> items) => Option<FridgeItem>.fromNullable(
  items
      .where(
        (FridgeItem item) =>
            normalizeIngredientName(item.name) == normalizeIngredientName(input.name) && item.unit == input.unit,
      )
      .firstOrNull,
);

FridgeItemInput mergeIntoExisting(FridgeItem item, FridgeItemInput added) => FridgeItemInput(
  name: item.name,
  quantity: min(item.quantity + added.quantity, maxFridgeQuantity),
  unit: item.unit,
  category: item.category,
  bestBefore: item.bestBefore.alt(() => added.bestBefore),
);
