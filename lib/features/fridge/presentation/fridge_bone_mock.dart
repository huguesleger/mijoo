import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';

final List<FridgeItem> fridgeBoneMock = <FridgeItem>[
  for (final (int index, FridgeCategory category) in <(int, FridgeCategory)>[
    (0, FridgeCategory.fruitsVegetables),
    (1, FridgeCategory.fruitsVegetables),
    (2, FridgeCategory.fruitsVegetables),
    (3, FridgeCategory.dairy),
    (4, FridgeCategory.dairy),
  ])
    FridgeItem(
      id: FridgeItemId('bone-$index'),
      name: 'Ingrédient du frigo',
      quantity: 2,
      unit: FridgeUnit.piece,
      category: category,
      bestBefore: none(),
    ),
];
