import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

final List<FridgeItem> homeBoneMock = <FridgeItem>[
  for (int index = 0; index < 3; index++)
    FridgeItem(
      id: FridgeItemId('bone-$index'),
      name: 'Ingrédient',
      quantity: 1,
      unit: FridgeUnit.piece,
      category: FridgeCategory.fruitsVegetables,
      bestBefore: some(DateTime(2000, 1, 2)),
    ),
];
