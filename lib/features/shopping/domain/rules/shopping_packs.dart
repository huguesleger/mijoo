import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/meals/domain/rules/meal_words.dart';
import 'package:mijoo/features/shopping/domain/entities/shopping_pack.dart';

typedef PackSize = ({double size, FridgeUnit unit});

const Map<ShoppingPack, Set<String>> _packWords = <ShoppingPack, Set<String>>{
  ShoppingPack.eggBox: <String>{'oeuf'},
  ShoppingPack.butter: <String>{'beurre'},
  ShoppingPack.cream: <String>{'creme'},
  ShoppingPack.milk: <String>{'lait'},
  ShoppingPack.gratedCheese: <String>{'rape'},
  ShoppingPack.pasta: <String>{'pate', 'spaghetti', 'penne', 'coquillette', 'tagliatelle', 'fusilli'},
  ShoppingPack.rice: <String>{'riz'},
  ShoppingPack.flour: <String>{'farine'},
};

PackSize packSize(ShoppingPack pack) => switch (pack) {
  ShoppingPack.eggBox => (size: 6, unit: FridgeUnit.piece),
  ShoppingPack.butter => (size: 250, unit: FridgeUnit.gram),
  ShoppingPack.cream => (size: 200, unit: FridgeUnit.milliliter),
  ShoppingPack.milk => (size: 1000, unit: FridgeUnit.milliliter),
  ShoppingPack.gratedCheese => (size: 200, unit: FridgeUnit.gram),
  ShoppingPack.pasta => (size: 500, unit: FridgeUnit.gram),
  ShoppingPack.rice || ShoppingPack.flour => (size: 1000, unit: FridgeUnit.gram),
};

Option<ShoppingPack> packFor(String name, FridgeUnit unit) {
  final Set<String> words = mealWords(name);
  return Option<ShoppingPack>.fromNullable(
    ShoppingPack.values
        .where((ShoppingPack pack) => packSize(pack).unit == unit && words.any(_packWords[pack]!.contains))
        .firstOrNull,
  );
}

double packedQuantity(double needed, Option<ShoppingPack> pack) => pack.match(
  () => needed,
  (ShoppingPack pack) => (needed / packSize(pack).size - 0.0001).ceil() * packSize(pack).size,
);
