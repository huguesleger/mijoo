# Mijoo

Mijoo est une application mobile iOS et Android destinée à simplifier la préparation des repas en famille. Elle aide à choisir un repas à partir de ce qu’il reste à la maison, puis à acheter les ingrédients manquants en tenant compte du budget alimentaire.

## Fonctionnalités

- Reconnaître les ingrédients d’une photo du frigo et corriger les propositions avant leur ajout.
- Suivre le stock alimentaire, avec ajout manuel et mise à jour après un repas confirmé.
- Générer des idées de recettes adaptées au stock, aux portions, au temps et aux préférences du foyer.
- Suivre le budget hebdomadaire et estimer le coût des achats manquants.
- Regrouper les ingrédients manquants dans une liste de courses modifiable.
- Trouver des magasins à proximité à partir d’une commune, d’un code postal ou de la position autorisée.

## État du projet

Le développement Flutter iOS et Android a commencé. Le premier parcours couvre Bienvenue, l’inscription et la connexion par e-mail et mot de passe. Le [logo](design/logo/retenu/mijoo-logo.svg) dessine un visage souriant sous les deux « o ».

## Lancer le projet

Le projet utilise Flutter 3.41.4 via FVM. La cible iOS minimale est iOS 15.

L’app est à la racine du dépôt. Le design system est dans `lib/core_ui/` et les fondations partagées dans `lib/core/`.

```sh
fvm flutter pub get
fvm flutter run
```

Sur iOS et Android, Mijoo utilise le projet Firebase `mijoo-famille` par défaut. Pour travailler avec les émulateurs locaux d’Authentication et de Firestore, lancer dans deux terminaux :

```sh
firebase emulators:start --only auth,firestore --project demo-mijoo
fvm flutter run --dart-define=FIREBASE_EMULATOR=true
```

L’adresse locale est présélectionnée pour le simulateur iOS et l’émulateur Android standard. Pour un autre environnement, fournir `FIREBASE_EMULATOR_HOST`.

```sh
fvm flutter analyze
fvm flutter test
fvm dart run slang
fvm dart run build_runner build
```

Les règles de sécurité Firestore sont dans `firestore.rules`. Leurs tests tournent sur l’émulateur Firestore :

```sh
cd firestore-tests && npm install && npm run test:emulator
```

## Documentation

| Document | Contenu |
| --- | --- |
| [Cahier des charges](docs/CAHIER_DES_CHARGES.md) | Vision, périmètre, règles métier et critères de recette |
| [Feuille de route](docs/ROADMAP.md) | Jalons et conditions de passage |
| [Architecture](docs/ARCHITECTURE.md) | Proposition technique et décisions ouvertes |
| [Design](docs/DESIGN.md) | Parcours à explorer et méthode d’analyse des captures |
| [Références visuelles](design/references/) | Dossier destiné aux captures |
| [CLAUDE.md](CLAUDE.md) | Consignes de contribution |
| [coding_rules.md](coding_rules.md) | Règles de code |
