import 'package:mijoo/features/household/domain/entities/food_preferences.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_idea.dart';
import 'package:mijoo/features/meals/domain/entities/meal_ingredient.dart';
import 'package:mijoo/features/meals/domain/rules/meal_words.dart';

const int quickMealMinutes = 20;
const int ideasPerPlan = 3;

const Set<String> _meat = <String>{
  'viande',
  'poulet',
  'boeuf',
  'porc',
  'jambon',
  'lardon',
  'bacon',
  'dinde',
  'agneau',
  'veau',
  'canard',
  'saucisse',
  'chorizo',
  'saucisson',
  'steak',
  'merguez',
  'lapin',
  'escalope',
  'rillette',
  'pancetta',
  'coppa',
  'entrecote',
  'bavette',
  'hache',
  'chipolata',
  'cordon',
  'nugget',
};

const Set<String> _fish = <String>{
  'poisson',
  'saumon',
  'thon',
  'cabillaud',
  'colin',
  'merlu',
  'sardine',
  'maquereau',
  'truite',
  'sole',
  'dorade',
  'bar',
  'lieu',
  'anchoi',
  'hareng',
  'surimi',
  'eglefin',
  'tilapia',
  'pangasius',
};

const Set<String> _seafood = <String>{
  'crevette',
  'moule',
  'calamar',
  'encornet',
  'coquille',
  'jacque',
  'crabe',
  'homard',
  'langoustine',
  'huitre',
  'poulpe',
  'gamba',
  'ecrevisse',
  'seiche',
  'palourde',
};

const Map<FoodExclusion, Set<String>> _excluded = <FoodExclusion, Set<String>>{
  FoodExclusion.pork: <String>{
    'porc',
    'jambon',
    'lardon',
    'bacon',
    'saucisse',
    'chorizo',
    'saucisson',
    'rillette',
    'pancetta',
    'coppa',
    'chipolata',
    'knacki',
    'andouillette',
    'boudin',
  },
  FoodExclusion.beef: <String>{'boeuf', 'steak', 'entrecote', 'bavette', 'hache', 'rumsteck'},
  FoodExclusion.meat: _meat,
  FoodExclusion.fish: _fish,
  FoodExclusion.seafood: _seafood,
  FoodExclusion.alcohol: <String>{
    'vin',
    'biere',
    'rhum',
    'cognac',
    'calvado',
    'cidre',
    'porto',
    'whisky',
    'vodka',
    'liqueur',
    'kirsch',
  },
  FoodExclusion.spicy: <String>{'piment', 'harissa', 'tabasco', 'sriracha', 'cayenne', 'chili', 'jalapeno'},
};

const Map<Allergen, Set<String>> _allergenic = <Allergen, Set<String>>{
  Allergen.gluten: <String>{
    'farine',
    'pate',
    'pain',
    'ble',
    'semoule',
    'couscou',
    'boulgour',
    'chapelure',
    'biscotte',
    'brioche',
    'orge',
    'seigle',
    'epeautre',
    'gnocchi',
    'lasagne',
    'spaghetti',
    'tagliatelle',
    'penne',
    'macaroni',
    'coquillette',
    'nouille',
    'tortilla',
    'pizza',
    'feuilletee',
    'brisee',
    'sablee',
    'crepe',
    'ravioli',
    'vermicelle',
    'fusilli',
    'linguine',
    'croute',
    'biscuit',
    'orzo',
    'wrap',
  },
  Allergen.lactose: <String>{
    'lait',
    'beurre',
    'creme',
    'fromage',
    'yaourt',
    'mozzarella',
    'parmesan',
    'gruyere',
    'emmental',
    'comte',
    'feta',
    'chevre',
    'ricotta',
    'mascarpone',
    'bechamel',
    'raclette',
    'camembert',
    'brie',
    'reblochon',
    'cheddar',
    'burrata',
    'skyr',
    'roquefort',
  },
  Allergen.eggs: <String>{'oeuf', 'mayonnaise', 'meringue'},
  Allergen.peanuts: <String>{'arachide', 'cacahuete'},
  Allergen.treeNuts: <String>{'noix', 'noisette', 'amande', 'cajou', 'pistache', 'pecan', 'macadamia', 'pignon'},
  Allergen.soy: <String>{'soja', 'tofu', 'tamari', 'edamame', 'miso'},
  Allergen.sesame: <String>{'sesame', 'tahini', 'tahin', 'houmou'},
  Allergen.crustaceans: <String>{'crevette', 'crabe', 'homard', 'langoustine', 'ecrevisse', 'gamba'},
  Allergen.fish: _fish,
};

bool respectsHousehold(MealIdea idea, HouseholdProfile profile) {
  final Set<String> forbidden = <String>{
    for (final FoodExclusion exclusion in FoodExclusion.values)
      if (profile.exclusions.contains(exclusion.name)) ..._excluded[exclusion] ?? const <String>{},
    for (final Allergen allergen in Allergen.values)
      if (profile.allergies.contains(allergen.name)) ..._allergenic[allergen] ?? const <String>{},
  };
  return idea.minutes <= profile.maxPrepMinutes && !_mentionsAny(idea, forbidden);
}

bool matchesCraving(MealIdea idea, MealCraving craving) => switch (craving) {
  MealCraving.any || MealCraving.comforting => true,
  MealCraving.quick => idea.minutes <= quickMealMinutes,
  MealCraving.vegetarian => !_mentionsAny(idea, <String>{..._meat, ..._fish, ..._seafood}),
};

List<MealIdea> suitableIdeas(List<MealIdea> ideas, HouseholdProfile profile, MealCraving craving) => ideas
    .where((MealIdea idea) => respectsHousehold(idea, profile) && matchesCraving(idea, craving))
    .take(ideasPerPlan)
    .toList();

bool _mentionsAny(MealIdea idea, Set<String> words) => <String>[
  idea.title,
  for (final MealIngredient ingredient in idea.ingredients) ...<String>[
    ingredient.name,
    ...ingredient.substitute.match(() => const <String>[], (String substitute) => <String>[substitute]),
  ],
].any((String text) => mealWords(text).any(words.contains));
