# Mijoo

Des idées de repas avec ce que la famille a déjà dans son frigo, une liste de courses qui respecte le budget de la semaine et les magasins à proximité. Données isolées par foyer dans Firebase.

Une seule app Flutter (iOS, Android), à la racine du dépôt (paquet `mijoo`) :

- `lib/core/` : fondations de l'app. `core.dart` réexporte `SafeCubit`, `AppFailure`, `UnknownFailure` et `withMinimalDelay` ; on y trouve aussi `router/`, `firebase/`, `i18n/` et `presentation/`.
- `lib/core_ui/` : design system (`Mj*`, `MjTheme`, jetons dans `foundation/`), importé d'un seul coup avec `package:mijoo/core_ui/core_ui.dart`. Il n'importe jamais rien du reste de l'app : `test/core_ui/core_ui_boundaries_test.dart` le vérifie.
- `assets/` : logo, image du bol, polices Fredoka (titres) et Comfortaa (textes).
- `firestore.rules` et `firestore-tests/` : règles de sécurité Firestore et leurs tests sur l'émulateur

## Règles de code

@coding_rules.md

## Organisation de l'app

- `lib/main.dart` appelle `configureDependencies()` (`lib/config/setup_get_it.dart`, instance `getIt`) puis lance `App` (`lib/app/app.dart`), qui crée le `SessionCubit` et le routeur.
- Routes typées `go_router_builder` : `lib/core/router/routes.dart` déclare chaque `<feature>_page_route.dart` en `part`, `routes.g.dart` est généré. Les chemins sont dans `route_paths.dart`, la redirection selon la session et le foyer dans `session_redirect.dart`. La navigation passe par les classes de route (`const SignInPageRoute().push<void>(context)`).
- Une fonctionnalité : `data/data_sources`, `data/mappers`, `data/repositories/<x>_repository_impl.dart` ; `domain/entities`, `domain/rules`, `domain/<x>_repository.dart`, `domain/<feature>_failure.dart` ; `presentation/bloc` (Cubit et état), `presentation/widgets`, `presentation/<feature>_screen.dart` et `<feature>_page_route.dart`.
- Les textes d'un échec atteignant l'écran passent par `lib/core/presentation/failure_message.dart` et s'affichent avec `FailureView`.

## Commandes

Toujours passer par `fvm` (version de Flutter fixée dans `.fvmrc`). `fvm` est dans `~/.pub-cache/bin`.

- Dépendances : `fvm flutter pub get` à la racine.
- Analyse : `fvm flutter analyze` à la racine.
- Formatage : `fvm dart format <chemins>` (largeur 120, fixée dans `analysis_options.yaml`).
- Tests : `fvm flutter test` à la racine.
- Code généré : `fvm dart run build_runner build` à la racine régénère les routes typées (`lib/core/router/routes.g.dart`) et les assets (`lib/core_ui/gen/`). Ne jamais éditer un `*.g.dart` à la main.
- Textes de l'app : un fichier `<namespace>_fr.i18n.json` par fonctionnalité (`lib/features/<feature>/`) ou dans `lib/core/presentation/`, sans tiret bas dans le nom du namespace. Après modification : `fvm dart run slang` à la racine pour régénérer `lib/core/i18n/translations*.g.dart`. Dans le code : `t.<namespace>.<clé>`.
- Assets : déclarés dans `pubspec.yaml`, accessibles par la classe générée `Assets` (`Assets.logo.mijooLogo.svg()`, `Assets.images.bolBleu.image()`) et `FontFamily`. Après ajout ou renommage d'un asset : `fvm dart run build_runner build`.
- Lancer l'app : configuration « Mobile (iOS / Android) » de `.vscode/launch.json`, ou `fvm flutter run` à la racine.

## Firebase

- Projet `mijoo-famille`, base Firestore `(default)` à Paris (`europe-west9`). La configuration Flutter générée est dans `lib/core/firebase/firebase_options.dart`, `android/app/google-services.json` et `ios/Runner/GoogleService-Info.plist`.
- Émulateurs locaux : `firebase emulators:start --only auth,firestore --project demo-mijoo` à la racine, puis `fvm flutter run --dart-define=FIREBASE_EMULATOR=true`.
- Ajout au frigo par photo, lecture de date et idées de repas : Gemini par `firebase_ai` (Firebase AI Logic, Gemini Developer API, modèle principal `GeminiGenerator.model` (`lib/core/firebase/gemini_generator.dart`, partagé par le scan et les idées de repas), puis `fallbackModel` en cas de surcharge ou de quota atteint ; offre gratuite limitée en requêtes par jour et par modèle), activée dans la console Firebase ; aucune clé Gemini dans l'app. App Check est appliqué à AI Logic : en debug l'app utilise le fournisseur de débogage (jeton affiché dans les logs au premier lancement, à ajouter dans la console App Check), en release Play Integrity et DeviceCheck. Codes-barres : Open Food Facts (`openfoodfacts`). Photos d'illustration des recettes : TheMealDB (clé de test publique `1`, sans compte, usage personnel), cherchées une fois à la génération à partir des mots-clés anglais donnés par Gemini, puis enregistrées avec l'idée.
- Foyer partagé : un membre crée un code dans `invites/{code}` (48 h, usage unique) ; l'autre parent le saisit à l'inscription, et l'écriture groupée l'ajoute à `memberIds`, marque le code utilisé et crée son lien `users/{uid}`. Les noms affichés des membres sont dans `households/{id}/members/{uid}`.
- Règles Firestore : `firestore.rules`. Tests : `cd firestore-tests && npm install && npm run test:emulator`. Déploiement : `firebase deploy --only firestore:rules`, uniquement à la demande de l'utilisateur.

## Règles produit

- Conserver les parcours manuels pour l'inventaire et la recherche de magasins.
- Demander une confirmation avant d'ajouter les ingrédients détectés ou de déduire le stock après un repas.
- Appliquer les règles de budget, de quantités et d'exclusions indépendamment des suggestions.
- Isoler les données par foyer. Garder les clés privées des fournisseurs côté serveur et écarter les données sensibles des journaux.
- Rédiger la documentation produit en français.

## Vérification

Ne pas lancer l'app sur un simulateur iOS ni un émulateur Android pour vérifier : l'utilisateur le fait lui-même. S'en tenir à l'analyse et aux tests, puis indiquer ce qu'il faut vérifier sur appareil.

## Git

Ne jamais commit, ni proposer de commit : l'utilisateur commit lui-même.
