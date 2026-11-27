import 'package:flutter/foundation.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/shopping/domain/rules/shopping_storage.dart';

@immutable
sealed class ShoppingLineSheetResult {
  const ShoppingLineSheetResult();
}

final class ShoppingLineSaved extends ShoppingLineSheetResult {
  const ShoppingLineSaved(this.quantity, this.category);

  final double quantity;
  final FridgeCategory category;
}

final class ShoppingLineRemoved extends ShoppingLineSheetResult {
  const ShoppingLineRemoved();
}

final class ShoppingStoreConfirmed {
  const ShoppingStoreConfirmed(this.toFridge);

  final List<ShoppingStorage> toFridge;
}
