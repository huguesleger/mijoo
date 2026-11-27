import 'package:fpdart/fpdart.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_category.dart';
import 'package:mijoo/features/meals/domain/rules/meal_words.dart';
import 'package:mijoo/features/shopping/domain/entities/price_basis.dart';

typedef CatalogPrice = ({
  Set<String> words,
  double cents,
  PriceBasis basis,
  FridgeCategory category,
  Option<double> pieceGrams,
  Option<String> openPricesTag,
});

CatalogPrice _kilo(
  Set<String> words,
  double cents,
  FridgeCategory category, {
  double? pieceGrams,
  String? tag,
}) => (
  words: words,
  cents: cents,
  basis: PriceBasis.kilogram,
  category: category,
  pieceGrams: Option<double>.fromNullable(pieceGrams),
  openPricesTag: Option<String>.fromNullable(tag),
);

CatalogPrice _liter(Set<String> words, double cents, FridgeCategory category) => (
  words: words,
  cents: cents,
  basis: PriceBasis.liter,
  category: category,
  pieceGrams: none(),
  openPricesTag: none(),
);

CatalogPrice _piece(Set<String> words, double cents, FridgeCategory category, {String? tag}) => (
  words: words,
  cents: cents,
  basis: PriceBasis.piece,
  category: category,
  pieceGrams: none(),
  openPricesTag: Option<String>.fromNullable(tag),
);

const FridgeCategory _produce = FridgeCategory.fruitsVegetables;
const FridgeCategory _meat = FridgeCategory.meatFish;
const FridgeCategory _dairy = FridgeCategory.dairy;
const FridgeCategory _grocery = FridgeCategory.grocery;
const FridgeCategory _frozen = FridgeCategory.frozen;

final List<CatalogPrice> priceCatalog = <CatalogPrice>[
  _kilo(<String>{'pomme', 'terre'}, 150, _produce, pieceGrams: 150, tag: 'en:potatoes'),
  _kilo(<String>{'tomate', 'concassee'}, 350, _grocery),
  _kilo(<String>{'coulis'}, 350, _grocery),
  _kilo(<String>{'haricot', 'vert'}, 600, _produce),
  _kilo(<String>{'petit', 'poi'}, 500, _frozen),
  _kilo(<String>{'steak', 'hache'}, 1300, _meat, pieceGrams: 100),
  _kilo(<String>{'chou', 'fleur'}, 300, _produce, pieceGrams: 800),
  _kilo(<String>{'poi', 'chiche'}, 300, _grocery),
  _kilo(<String>{'carotte'}, 150, _produce, pieceGrams: 100, tag: 'en:carrots'),
  _kilo(<String>{'tomate'}, 300, _produce, pieceGrams: 120, tag: 'en:tomatoes'),
  _kilo(<String>{'oignon'}, 200, _produce, pieceGrams: 120, tag: 'en:onions'),
  _kilo(<String>{'echalote'}, 600, _produce, pieceGrams: 30),
  _kilo(<String>{'courgette'}, 300, _produce, pieceGrams: 250, tag: 'en:zucchini'),
  _kilo(<String>{'poireau'}, 300, _produce, pieceGrams: 200, tag: 'en:leeks'),
  _kilo(<String>{'poivron'}, 450, _produce, pieceGrams: 180, tag: 'en:bell-peppers'),
  _kilo(<String>{'aubergine'}, 350, _produce, pieceGrams: 300, tag: 'en:eggplants'),
  _kilo(<String>{'champignon'}, 600, _produce, pieceGrams: 20, tag: 'en:mushrooms'),
  _kilo(<String>{'epinard'}, 600, _produce, tag: 'en:spinach'),
  _kilo(<String>{'brocoli'}, 400, _produce, pieceGrams: 400, tag: 'en:broccoli'),
  _kilo(<String>{'potiron'}, 250, _produce, pieceGrams: 1500, tag: 'en:pumpkins'),
  _kilo(<String>{'courge'}, 250, _produce, pieceGrams: 1000, tag: 'en:squashes'),
  _kilo(<String>{'pomme'}, 300, _produce, pieceGrams: 150, tag: 'en:apples'),
  _kilo(<String>{'poire'}, 350, _produce, pieceGrams: 150, tag: 'en:pears'),
  _kilo(<String>{'banane'}, 220, _produce, pieceGrams: 120, tag: 'en:bananas'),
  _kilo(<String>{'orange'}, 250, _produce, pieceGrams: 200, tag: 'en:oranges'),
  _kilo(<String>{'poulet'}, 1100, _meat, pieceGrams: 150),
  _kilo(<String>{'dinde'}, 1200, _meat, pieceGrams: 150),
  _kilo(<String>{'boeuf'}, 1500, _meat),
  _kilo(<String>{'porc'}, 900, _meat),
  _kilo(<String>{'jambon'}, 1800, _meat, pieceGrams: 40),
  _kilo(<String>{'lardon'}, 1400, _meat),
  _kilo(<String>{'saumon'}, 2500, _meat, pieceGrams: 125),
  _kilo(<String>{'cabillaud'}, 2000, _meat, pieceGrams: 125),
  _kilo(<String>{'crevette'}, 1800, _meat),
  _kilo(<String>{'beurre'}, 1000, _dairy),
  _kilo(<String>{'parmesan'}, 2500, _dairy),
  _kilo(<String>{'gruyere'}, 1200, _dairy),
  _kilo(<String>{'emmental'}, 1100, _dairy),
  _kilo(<String>{'comte'}, 1800, _dairy),
  _kilo(<String>{'mozzarella'}, 900, _dairy, pieceGrams: 125),
  _kilo(<String>{'feta'}, 1300, _dairy, pieceGrams: 200),
  _kilo(<String>{'fromage'}, 1200, _dairy, pieceGrams: 250),
  _kilo(<String>{'pate'}, 200, _grocery),
  _kilo(<String>{'spaghetti'}, 200, _grocery),
  _kilo(<String>{'riz'}, 250, _grocery),
  _kilo(<String>{'farine'}, 120, _grocery),
  _kilo(<String>{'sucre'}, 120, _grocery),
  _kilo(<String>{'lentille'}, 350, _grocery),
  _kilo(<String>{'semoule'}, 250, _grocery),
  _kilo(<String>{'chocolat'}, 1000, _grocery, pieceGrams: 100),
  _liter(<String>{'lait'}, 110, _dairy),
  _liter(<String>{'creme'}, 500, _dairy),
  _liter(<String>{'huile'}, 400, _grocery),
  _liter(<String>{'bouillon'}, 300, _grocery),
  _piece(<String>{'oeuf'}, 30, _dairy),
  _piece(<String>{'yaourt'}, 40, _dairy),
  _piece(<String>{'pain'}, 120, _grocery),
  _piece(<String>{'baguette'}, 110, _grocery),
  _piece(<String>{'citron'}, 50, _produce, tag: 'en:lemons'),
  _piece(<String>{'salade'}, 120, _produce),
  _piece(<String>{'laitue'}, 120, _produce),
  _piece(<String>{'concombre'}, 100, _produce),
  _piece(<String>{'avocat'}, 120, _produce),
  _piece(<String>{'ail'}, 60, _produce),
  _piece(<String>{'thon'}, 250, _grocery),
];

Option<CatalogPrice> catalogPrice(String name) {
  final Set<String> words = mealWords(name);
  return Option<CatalogPrice>.fromNullable(
    (priceCatalog.where((CatalogPrice entry) => words.containsAll(entry.words)).toList()
          ..sort((CatalogPrice a, CatalogPrice b) => b.words.length.compareTo(a.words.length)))
        .firstOrNull,
  );
}
