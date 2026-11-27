import 'package:mijoo/features/fridge/domain/rules/ingredient_names.dart';

const Set<String> _linkWords = <String>{'de', 'du', 'des', 'la', 'le', 'les', 'l', 'd', 'a', 'au', 'aux', 'en', 'et'};

Set<String> mealWords(String name) => normalizeIngredientName(name)
    .split(RegExp('[^a-z0-9]+'))
    .where((String word) => word.isNotEmpty && !_linkWords.contains(word))
    .map(_singular)
    .toSet();

String _singular(String word) =>
    word.length > 3 && (word.endsWith('s') || word.endsWith('x')) ? word.substring(0, word.length - 1) : word;
