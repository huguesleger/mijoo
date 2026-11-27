import 'package:intl/intl.dart';
import 'package:mijoo/features/fridge/domain/entities/fridge_item.dart';
import 'package:mijoo/features/household/domain/entities/household_profile.dart';
import 'package:mijoo/features/meals/domain/entities/meal_craving.dart';
import 'package:mijoo/features/meals/domain/entities/meal_request.dart';
import 'package:mijoo/features/meals/domain/rules/meal_restrictions.dart';

const int maxPromptItems = 80;

String mealRequestToPrompt(MealRequest request) {
  final HouseholdProfile profile = request.profile;
  final DateFormat day = DateFormat('dd/MM');
  final String forbidden = <String>[...profile.exclusions, ...profile.allergies].join(', ');
  return <String>[
    'Tu proposes des idées de repas du soir à une famille française.',
    'Propose exactement 3 recettes différentes, simples, familiales et réalisables à la maison, en français.',
    'Foyer : ${profile.people} personnes (${profile.adults} adultes, ${profile.children} enfants). '
        'Chaque recette donne ${profile.people} portions.',
    'Temps total maximum, préparation et cuisson comprises : ${profile.maxPrepMinutes} minutes.',
    switch (request.craving) {
      MealCraving.any => 'Varie les types de plats.',
      MealCraving.quick => 'Envie du soir : très rapide, $quickMealMinutes minutes au plus.',
      MealCraving.vegetarian => 'Envie du soir : végétarien, sans viande, poisson ni fruits de mer.',
      MealCraving.comforting => 'Envie du soir : plat réconfortant et chaud.',
    },
    if (forbidden.isNotEmpty)
      'Interdits absolus, même en petite quantité ou en dérivé (codes en anglais) : $forbidden.',
    if (profile.likes.isNotEmpty) 'Goûts du foyer (codes en anglais) : ${profile.likes.join(', ')}.',
    if (request.items.isEmpty)
      'Le frigo est vide : propose des recettes avec peu d’ingrédients courants.'
    else ...<String>[
      'Contenu du frigo :',
      for (final FridgeItem item in request.items.take(maxPromptItems))
        '- ${item.name} : ${_quantity(item.quantity)} ${item.unit.name}'
            '${item.bestBefore.match(() => '', (DateTime date) => ' (à consommer avant le ${day.format(date)})')}',
    ],
    if (request.toFinishFirst.isNotEmpty)
      'À utiliser en priorité, car ils périment bientôt : '
          '${request.toFinishFirst.map((FridgeItem item) => item.name).join(', ')}.',
    'Utilise surtout les ingrédients du frigo et limite les achats à 3 ingrédients au plus par recette.',
    'Sel, poivre, huile, vinaigre, eau et épices sèches sont toujours disponibles : ne les liste pas.',
    if (request.recentTitles.isNotEmpty)
      'Déjà cuisiné récemment, ne le repropose pas : ${request.recentTitles.join(' ; ')}.',
    'Pour un ingrédient qui vient du frigo, reprends exactement son nom. '
        'Donne une quantité pour la recette entière et une unité parmi les valeurs proposées.',
    'Ajoute une alternative courte seulement quand elle aide vraiment, sinon null.',
    'Range chaque ingrédient dans une catégorie de rayon parmi les valeurs proposées.',
    'Décris le plat en une phrase courte et appétissante, sans répéter le titre.',
    'Sépare le temps de préparation et le temps de cuisson, en minutes.',
    'Donne le niveau de difficulté et 1 à 3 ustensiles principaux (« Poêle », « Saladier »).',
    'Écris 4 à 7 étapes courtes, à l’impératif et en tutoyant. '
        'Indique la durée en minutes d’une étape seulement quand elle attend ou cuit, sinon null.',
    'Pour la photo, donne 2 ou 3 mots-clés en anglais, du plat précis au plus général puis à l’ingrédient principal '
        '(par exemple « spinach omelette », « omelette », « spinach »).',
  ].join('\n');
}

String _quantity(double quantity) =>
    quantity == quantity.roundToDouble() ? quantity.toInt().toString() : quantity.toString();
