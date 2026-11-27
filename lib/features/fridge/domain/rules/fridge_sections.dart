import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/rules/ingredient_names.dart';

typedef FridgeSection = ({FridgeCategory category, List<FridgeItem> items});

List<FridgeSection> fridgeSections(List<FridgeItem> items, String query, Option<FridgeCategory> category) {
  final String search = normalizeIngredientName(query);
  final List<FridgeItem> matching =
      items.where((FridgeItem item) => normalizeIngredientName(item.name).contains(search)).toList()..sort(
        (FridgeItem a, FridgeItem b) => normalizeIngredientName(a.name).compareTo(normalizeIngredientName(b.name)),
      );
  return <FridgeSection>[
    for (final FridgeCategory shelf in FridgeCategory.values)
      if (category.match(() => true, (FridgeCategory selected) => selected == shelf) &&
          matching.any((FridgeItem item) => item.category == shelf))
        (category: shelf, items: matching.where((FridgeItem item) => item.category == shelf).toList()),
  ];
}

List<FridgeCategory> fridgeCategoriesInUse(List<FridgeItem> items) => <FridgeCategory>[
  for (final FridgeCategory shelf in FridgeCategory.values)
    if (items.any((FridgeItem item) => item.category == shelf)) shelf,
];
