import 'package:flutter/foundation.dart';

@immutable
sealed class IngredientAvailability {
  const IngredientAvailability();
}

final class InFridge extends IngredientAvailability {
  const InFridge();
}

final class NotEnoughInFridge extends IngredientAvailability {
  const NotEnoughInFridge(this.missing);

  final double missing;
}

final class ToBuy extends IngredientAvailability {
  const ToBuy();
}
