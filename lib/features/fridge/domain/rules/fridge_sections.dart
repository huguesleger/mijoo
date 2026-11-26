import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';

typedef FridgeSection = ({FridgeCategory category, List<FridgeItem> items});

List<FridgeSection> fridgeSections(List<FridgeItem> items, String query) {
  final String search = _normalize(query);
  final List<FridgeItem> matching = items.where((FridgeItem item) => _normalize(item.name).contains(search)).toList()
    ..sort((FridgeItem a, FridgeItem b) => _normalize(a.name).compareTo(_normalize(b.name)));
  return <FridgeSection>[
    for (final FridgeCategory category in FridgeCategory.values)
      if (matching.any((FridgeItem item) => item.category == category))
        (category: category, items: matching.where((FridgeItem item) => item.category == category).toList()),
  ];
}

String _normalize(String text) => text
    .trim()
    .toLowerCase()
    .replaceAll(RegExp('[àâä]'), 'a')
    .replaceAll(RegExp('[éèêë]'), 'e')
    .replaceAll(RegExp('[îï]'), 'i')
    .replaceAll(RegExp('[ôö]'), 'o')
    .replaceAll(RegExp('[ùûü]'), 'u')
    .replaceAll('ç', 'c')
    .replaceAll('œ', 'oe');
