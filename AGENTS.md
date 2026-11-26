# Consignes de contribution à Mijoo

Le développement Flutter est autorisé. Lire [les règles de code](docs/CODING_RULES.md), [l’architecture](docs/ARCHITECTURE.md) et [les maquettes](docs/DESIGN.md) avant de modifier une fonctionnalité.

## Règles propres à Mijoo

- Flutter et Dart via FVM, Firebase pour le backend, go_router pour les routes, flutter_bloc avec SafeCubit et fpdart.
- Chaque fonctionnalité réside dans `lib/features/<feature>/`. Placer les sources et mappers dans `data/`, les entités et interfaces dans `domain/`, les Cubits et widgets dans `presentation/`. Ajouter un use case uniquement sur demande explicite.
- Fournir le Cubit dans `<feature>_page_route.dart`. Construire l’écran avec BlocBuilder et un switch exhaustif sur l’état. Limiter chaque widget à 100 lignes. Les états sont immuables et modélisés avec des classes scellées.
- Utiliser Option pour les valeurs absentes et Either ou TaskEither pour les erreurs. Utiliser Unit pour une opération asynchrone sans valeur. Composer `match(...).map(emit).run()` depuis le Cubit.
- Le texte d’interface vit dans `lib/features/<feature>/<feature>_fr.i18n.json`. Régénérer avec `fvm dart run slang`. Utiliser la classe Assets de FlutterGen et régénérer avec `fvm dart run build_runner build`. Garder les fichiers générés sous le contrôle du générateur.
- Réutiliser les composants et jetons de `lib/core_ui/`. Ne mettre aucun commentaire dans le code ajouté ou modifié, sauf TODO. Les règles de cette section priment sur les variantes du document de référence.
- Analyser avec `fvm flutter analyze --no-pub <chemins>`. Lancer les tests avec `fvm flutter test --no-pub`.
- Les commits sont gérés exclusivement par l’utilisateur dans GitKraken. Ne jamais créer ni proposer de commit.

## Règles produit

- Conserver les parcours manuels pour l’inventaire et la recherche de magasins.
- Demander une confirmation avant d’ajouter les ingrédients détectés ou de déduire le stock après un repas.
- Appliquer les règles de budget, de quantités et d’exclusions indépendamment des suggestions.
- Isoler les données par foyer. Garder les clés privées des fournisseurs côté serveur et écarter les données sensibles des journaux.
- Vérifier sur iOS et Android les parcours concernés. Rédiger la documentation produit en français.
