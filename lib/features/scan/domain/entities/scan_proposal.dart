import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item_input.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/scan/domain/entities/scan_confidence.dart';

final class ScanProposal {
  const ScanProposal({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.category,
    required this.confidence,
  });

  final String name;
  final double quantity;
  final FridgeUnit unit;
  final FridgeCategory category;
  final ScanConfidence confidence;

  FridgeItemInput get input =>
      FridgeItemInput(name: name, quantity: quantity, unit: unit, category: category, bestBefore: none());
}
