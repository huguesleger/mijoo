import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_unit.dart';
import 'package:mijoo/features/fridge/domain/rules/fridge_sections.dart';

FridgeItem item(String name, FridgeCategory category) => FridgeItem(
  id: FridgeItemId(name),
  name: name,
  quantity: 1,
  unit: FridgeUnit.piece,
  category: category,
  bestBefore: none(),
);

void main() {
  final List<FridgeItem> items = <FridgeItem>[
    item('Yaourts', FridgeCategory.dairy),
    item('Tomates', FridgeCategory.fruitsVegetables),
    item('Échalotes', FridgeCategory.fruitsVegetables),
    item('Lait', FridgeCategory.dairy),
  ];

  test('groups items by category in the aisle order, sorted by name', () {
    final List<FridgeSection> sections = fridgeSections(items, '', none());
    expect(sections.map((FridgeSection section) => section.category), <FridgeCategory>[
      FridgeCategory.fruitsVegetables,
      FridgeCategory.dairy,
    ]);
    expect(sections.first.items.map((FridgeItem item) => item.name), <String>['Échalotes', 'Tomates']);
    expect(sections.last.items.map((FridgeItem item) => item.name), <String>['Lait', 'Yaourts']);
  });

  test('searches without case nor accents', () {
    final List<FridgeSection> sections = fridgeSections(items, 'ECHAL', none());
    expect(sections, hasLength(1));
    expect(sections.single.items.single.name, 'Échalotes');
    expect(fridgeSections(items, 'pizza', none()), isEmpty);
  });

  test('keeps only the selected shelf', () {
    final List<FridgeSection> sections = fridgeSections(items, '', some(FridgeCategory.dairy));
    expect(sections.single.category, FridgeCategory.dairy);
    expect(sections.single.items, hasLength(2));
  });

  test('lists the shelves in use in the aisle order', () {
    expect(fridgeCategoriesInUse(items), <FridgeCategory>[FridgeCategory.fruitsVegetables, FridgeCategory.dairy]);
  });
}
