import 'package:flutter/foundation.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';

@immutable
sealed class FridgeSheetResult {
  const FridgeSheetResult();
}

final class FridgeSheetSaved extends FridgeSheetResult {
  const FridgeSheetSaved(this.input);

  final FridgeItemInput input;
}

final class FridgeSheetDeleted extends FridgeSheetResult {
  const FridgeSheetDeleted();
}
