///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'translations.g.dart';

// Path: <root>
typedef TranslationsFr = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  _meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fr,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		_meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fr>.
	final TranslationMetadata<AppLocale, Translations> _meta;
	@override TranslationMetadata<AppLocale, Translations> get $meta => _meta;

	/// Access flat map
	dynamic operator[](String key) => _meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$account$fr account = Translations$account$fr.internal(_root);
	late final Translations$auth$fr auth = Translations$auth$fr.internal(_root);
	late final Translations$failures$fr failures = Translations$failures$fr.internal(_root);
	late final Translations$fridge$fr fridge = Translations$fridge$fr.internal(_root);
	late final Translations$household$fr household = Translations$household$fr.internal(_root);
	late final Translations$setup$fr setup = Translations$setup$fr.internal(_root);
	late final Translations$shell$fr shell = Translations$shell$fr.internal(_root);
	late final Translations$welcome$fr welcome = Translations$welcome$fr.internal(_root);
}

// Path: account
class Translations$account$fr {
	Translations$account$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mon '
	String get titleLead => 'Mon ';

	/// fr: 'compte'
	String get titleHighlight => 'compte';

	/// fr: 'Nom'
	String get name => 'Nom';

	/// fr: 'Adresse e-mail'
	String get email => 'Adresse e-mail';

	/// fr: 'Non renseigné'
	String get noName => 'Non renseigné';

	/// fr: 'Se déconnecter'
	String get signOut => 'Se déconnecter';
}

// Path: auth
class Translations$auth$fr {
	Translations$auth$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Se connecter'
	String get signIn => 'Se connecter';

	/// fr: 'Créer un compte'
	String get register => 'Créer un compte';

	/// fr: 'Nom'
	String get name => 'Nom';

	/// fr: 'Adresse e-mail'
	String get email => 'Adresse e-mail';

	/// fr: 'Mot de passe'
	String get password => 'Mot de passe';

	/// fr: 'Firebase n’est pas configuré sur cette version de Mijoo.'
	String get firebaseUnavailable => 'Firebase n’est pas configuré sur cette version de Mijoo.';

	/// fr: 'Vérifie ton adresse e-mail et ton mot de passe.'
	String get invalidCredentials => 'Vérifie ton adresse e-mail et ton mot de passe.';

	/// fr: 'Un compte utilise déjà cette adresse e-mail.'
	String get emailAlreadyUsed => 'Un compte utilise déjà cette adresse e-mail.';

	/// fr: 'Choisis un mot de passe plus long.'
	String get weakPassword => 'Choisis un mot de passe plus long.';

	/// fr: 'Saisis une adresse e-mail valide.'
	String get invalidEmail => 'Saisis une adresse e-mail valide.';

	/// fr: 'La connexion a échoué. Réessaie dans un instant.'
	String get networkFailure => 'La connexion a échoué. Réessaie dans un instant.';

	/// fr: 'Crée ton '
	String get registerLead => 'Crée ton ';

	/// fr: 'compte'
	String get registerHighlight => 'compte';

	/// fr: 'Quelques secondes et on passe à table.'
	String get registerSubtitle => 'Quelques secondes et on passe à table.';

	/// fr: 'Content de te '
	String get signInLead => 'Content de te ';

	/// fr: 'revoir'
	String get signInHighlight => 'revoir';

	/// fr: 'Connecte-toi pour retrouver ton frigo.'
	String get signInSubtitle => 'Connecte-toi pour retrouver ton frigo.';

	/// fr: 'Créer mon compte'
	String get registerSubmit => 'Créer mon compte';

	/// fr: 'Ton prénom'
	String get nameHint => 'Ton prénom';

	/// fr: 'nom@exemple.fr'
	String get emailHint => 'nom@exemple.fr';

	/// fr: 'Ton mot de passe'
	String get passwordHint => 'Ton mot de passe';

	/// fr: 'Confirmer le mot de passe'
	String get confirmPassword => 'Confirmer le mot de passe';

	/// fr: 'Saisis-le à nouveau'
	String get confirmPasswordHint => 'Saisis-le à nouveau';

	/// fr: 'Les mots de passe ne correspondent pas.'
	String get passwordMismatch => 'Les mots de passe ne correspondent pas.';

	/// fr: 'Afficher le mot de passe'
	String get showPassword => 'Afficher le mot de passe';

	/// fr: 'Masquer le mot de passe'
	String get hidePassword => 'Masquer le mot de passe';

	/// fr: 'Au moins 8 caractères'
	String get ruleMinLength => 'Au moins 8 caractères';

	/// fr: 'Un chiffre'
	String get ruleDigit => 'Un chiffre';

	/// fr: 'Une majuscule'
	String get ruleUppercase => 'Une majuscule';

	/// fr: 'Un caractère spécial'
	String get ruleSpecial => 'Un caractère spécial';

	/// fr: 'Déjà un compte ? '
	String get haveAccount => 'Déjà un compte ? ';

	/// fr: 'Pas encore de compte ? '
	String get noAccount => 'Pas encore de compte ? ';

	/// fr: 'Mot de passe oublié ?'
	String get forgotPassword => 'Mot de passe oublié ?';

	/// fr: 'Mot de passe '
	String get forgotLead => 'Mot de passe ';

	/// fr: 'oublié ?'
	String get forgotHighlight => 'oublié ?';

	/// fr: 'Saisis ton adresse e-mail, on t’envoie un lien pour en choisir un nouveau.'
	String get forgotSubtitle => 'Saisis ton adresse e-mail, on t’envoie un lien pour en choisir un nouveau.';

	/// fr: 'Envoyer le lien'
	String get sendResetLink => 'Envoyer le lien';

	/// fr: 'Vérifie ta '
	String get resetSentLead => 'Vérifie ta ';

	/// fr: 'boîte mail'
	String get resetSentHighlight => 'boîte mail';

	/// fr: 'Le lien arrive dans quelques instants.'
	String get resetSentSubtitle => 'Le lien arrive dans quelques instants.';

	/// fr: 'Si un compte existe pour {email}, tu vas recevoir un lien pour choisir un nouveau mot de passe. Pense à regarder dans les courriers indésirables.'
	String resetSentMessage({required Object email}) => 'Si un compte existe pour ${email}, tu vas recevoir un lien pour choisir un nouveau mot de passe. Pense à regarder dans les courriers indésirables.';

	/// fr: 'Retour à la connexion'
	String get backToSignIn => 'Retour à la connexion';

	/// fr: 'Tu t’en souviens ? '
	String get rememberPassword => 'Tu t’en souviens ? ';
}

// Path: failures
class Translations$failures$fr {
	Translations$failures$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Une erreur est survenue. Réessaie dans un instant.'
	String get unknown => 'Une erreur est survenue. Réessaie dans un instant.';
}

// Path: fridge
class Translations$fridge$fr {
	Translations$fridge$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mon frigo'
	String get title => 'Mon frigo';

	/// fr: 'Ajouter un ingrédient'
	String get add => 'Ajouter un ingrédient';

	/// fr: 'Rechercher un ingrédient'
	String get search => 'Rechercher un ingrédient';

	/// fr: 'Ton frigo est vide'
	String get emptyTitle => 'Ton frigo est vide';

	/// fr: 'Ajoute ce que tu as sous la main pour recevoir des idées de repas.'
	String get emptyMessage => 'Ajoute ce que tu as sous la main pour recevoir des idées de repas.';

	/// fr: 'Aucun ingrédient trouvé'
	String get noResultTitle => 'Aucun ingrédient trouvé';

	/// fr: 'Vérifie l’orthographe ou ajoute cet ingrédient.'
	String get noResultMessage => 'Vérifie l’orthographe ou ajoute cet ingrédient.';

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	/// fr: 'À consommer avant le {date}'
	String bestBefore({required Object date}) => 'À consommer avant le ${date}';

	/// fr: 'Ajouter un ingrédient'
	String get addTitle => 'Ajouter un ingrédient';

	/// fr: 'Modifier l’ingrédient'
	String get editTitle => 'Modifier l’ingrédient';

	/// fr: 'Nom'
	String get name => 'Nom';

	/// fr: 'Par exemple Tomates'
	String get nameHint => 'Par exemple Tomates';

	/// fr: 'Quantité'
	String get quantity => 'Quantité';

	/// fr: 'Par exemple 4'
	String get quantityHint => 'Par exemple 4';

	/// fr: 'Saisis une quantité supérieure à 0.'
	String get quantityInvalid => 'Saisis une quantité supérieure à 0.';

	/// fr: 'Unité'
	String get unit => 'Unité';

	/// fr: 'Rayon'
	String get category => 'Rayon';

	/// fr: 'Date de consommation'
	String get date => 'Date de consommation';

	/// fr: 'Facultative'
	String get dateOptional => 'Facultative';

	/// fr: 'Ajouter une date'
	String get dateAdd => 'Ajouter une date';

	/// fr: 'Retirer la date'
	String get dateRemove => 'Retirer la date';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';

	/// fr: 'Ajouter'
	String get create => 'Ajouter';

	/// fr: 'Supprimer l’ingrédient'
	String get delete => 'Supprimer l’ingrédient';

	/// fr: 'Ton frigo n’est pas accessible pour le moment. Réessaie dans un instant.'
	String get unavailable => 'Ton frigo n’est pas accessible pour le moment. Réessaie dans un instant.';

	/// fr: 'Tu n’as pas accès à ce frigo.'
	String get accessDenied => 'Tu n’as pas accès à ce frigo.';

	/// fr: 'La connexion a échoué. Réessaie dans un instant.'
	String get networkFailure => 'La connexion a échoué. Réessaie dans un instant.';

	late final Translations$fridge$quantities$fr quantities = Translations$fridge$quantities$fr.internal(_root);
	Map<String, String> get units => {
		'piece': 'Pièce',
		'gram': 'g',
		'kilogram': 'kg',
		'milliliter': 'ml',
		'liter': 'L',
		'pack': 'Paquet',
	};
	Map<String, String> get categories => {
		'fruitsVegetables': 'Fruits et légumes',
		'meatFish': 'Viandes et poissons',
		'dairy': 'Produits laitiers',
		'grocery': 'Épicerie',
		'frozen': 'Surgelés',
		'drinks': 'Boissons',
		'other': 'Autres',
	};
}

// Path: household
class Translations$household$fr {
	Translations$household$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ton foyer n’est pas accessible pour le moment. Réessaie dans un instant.'
	String get unavailable => 'Ton foyer n’est pas accessible pour le moment. Réessaie dans un instant.';

	/// fr: 'Tu n’as pas accès à ce foyer.'
	String get accessDenied => 'Tu n’as pas accès à ce foyer.';

	/// fr: 'La connexion a échoué. Réessaie dans un instant.'
	String get networkFailure => 'La connexion a échoué. Réessaie dans un instant.';
}

// Path: setup
class Translations$setup$fr {
	Translations$setup$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Étape {current} sur {total}'
	String step({required Object current, required Object total}) => 'Étape ${current} sur ${total}';

	/// fr: 'Ton '
	String get householdLead => 'Ton ';

	/// fr: 'foyer'
	String get householdHighlight => 'foyer';

	/// fr: 'Pour adapter les portions de chaque repas.'
	String get householdSubtitle => 'Pour adapter les portions de chaque repas.';

	/// fr: 'Adultes'
	String get adults => 'Adultes';

	/// fr: 'Enfants'
	String get children => 'Enfants';

	/// fr: 'Retirer un'
	String get decrease => 'Retirer un';

	/// fr: 'Ajouter un'
	String get increase => 'Ajouter un';

	/// fr: 'Temps de préparation maximum'
	String get prepTime => 'Temps de préparation maximum';

	/// fr: '{count} min'
	String minutes({required Object count}) => '${count} min';

	/// fr: 'Tes '
	String get preferencesLead => 'Tes ';

	/// fr: 'goûts'
	String get preferencesHighlight => 'goûts';

	/// fr: 'Mijoo écarte toujours les exclusions et les allergies.'
	String get preferencesSubtitle => 'Mijoo écarte toujours les exclusions et les allergies.';

	/// fr: 'Ce que vous aimez'
	String get likesTitle => 'Ce que vous aimez';

	/// fr: 'À éviter'
	String get exclusionsTitle => 'À éviter';

	/// fr: 'Allergies'
	String get allergiesTitle => 'Allergies';

	Map<String, String> get likes => {
		'pasta': 'Pâtes',
		'rice': 'Riz',
		'vegetables': 'Légumes',
		'salads': 'Salades',
		'soups': 'Soupes',
		'stews': 'Plats mijotés',
		'fish': 'Poisson',
		'meat': 'Viande',
		'vegetarian': 'Végétarien',
		'worldCuisine': 'Cuisines du monde',
	};
	Map<String, String> get exclusions => {
		'pork': 'Porc',
		'beef': 'Bœuf',
		'meat': 'Toute viande',
		'fish': 'Poisson',
		'seafood': 'Fruits de mer',
		'alcohol': 'Alcool',
		'spicy': 'Épicé',
	};
	Map<String, String> get allergens => {
		'gluten': 'Gluten',
		'lactose': 'Lactose',
		'eggs': 'Œufs',
		'peanuts': 'Arachides',
		'treeNuts': 'Fruits à coque',
		'soy': 'Soja',
		'sesame': 'Sésame',
		'crustaceans': 'Crustacés',
		'fish': 'Poisson',
	};

	/// fr: 'Ton '
	String get budgetLead => 'Ton ';

	/// fr: 'budget'
	String get budgetHighlight => 'budget';

	/// fr: 'Facultatif, tu pourras le changer plus tard.'
	String get budgetSubtitle => 'Facultatif, tu pourras le changer plus tard.';

	/// fr: 'Budget courses par semaine'
	String get weeklyBudget => 'Budget courses par semaine';

	/// fr: 'Par exemple 120'
	String get weeklyBudgetHint => 'Par exemple 120';

	/// fr: '€'
	String get euro => '€';

	/// fr: 'Saisis un montant en euros, par exemple 120 ou 85,50.'
	String get budgetInvalid => 'Saisis un montant en euros, par exemple 120 ou 85,50.';

	/// fr: 'Code postal'
	String get postalCode => 'Code postal';

	/// fr: '69001'
	String get postalCodeHint => '69001';

	/// fr: 'Saisis un code postal à 5 chiffres.'
	String get postalCodeInvalid => 'Saisis un code postal à 5 chiffres.';

	/// fr: 'Commune'
	String get city => 'Commune';

	/// fr: 'Lyon'
	String get cityHint => 'Lyon';

	/// fr: 'Ta commune sert seulement à trouver les magasins proches.'
	String get locationHelp => 'Ta commune sert seulement à trouver les magasins proches.';

	/// fr: 'Continuer'
	String get kContinue => 'Continuer';

	/// fr: 'Terminer'
	String get finish => 'Terminer';

	/// fr: 'Tout est '
	String get doneLead => 'Tout est ';

	/// fr: 'prêt'
	String get doneHighlight => 'prêt';

	/// fr: 'Ton foyer est configuré.'
	String get doneSubtitle => 'Ton foyer est configuré.';

	/// fr: 'Ajoute ce qu’il y a dans ton frigo pour recevoir tes premières idées de repas.'
	String get doneMessage => 'Ajoute ce qu’il y a dans ton frigo pour recevoir tes premières idées de repas.';

	/// fr: 'Découvrir Mijoo'
	String get start => 'Découvrir Mijoo';
}

// Path: shell
class Translations$shell$fr {
	Translations$shell$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Accueil'
	String get home => 'Accueil';

	/// fr: 'Frigo'
	String get fridge => 'Frigo';

	/// fr: 'Repas'
	String get meals => 'Repas';

	/// fr: 'Courses'
	String get shopping => 'Courses';

	/// fr: 'Bonjour'
	String get greeting => 'Bonjour';

	/// fr: 'Bonjour {name}'
	String greetingName({required Object name}) => 'Bonjour ${name}';

	/// fr: 'Cette partie arrive bientôt.'
	String get comingSoon => 'Cette partie arrive bientôt.';

	/// fr: 'Mon compte'
	String get account => 'Mon compte';
}

// Path: welcome
class Translations$welcome$fr {
	Translations$welcome$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mijoo'
	String get appName => 'Mijoo';

	/// fr: 'Cuisine malin avec '
	String get titleLead => 'Cuisine malin\navec ';

	/// fr: 'ton frigo'
	String get titleHighlight => 'ton frigo';

	/// fr: 'Mijoo te propose des repas avec ton frigo, pour toute la famille et dans ton budget.'
	String get subtitle => 'Mijoo te propose des repas avec ton frigo, pour toute la famille et dans ton budget.';
}

// Path: fridge.quantities
class Translations$fridge$quantities$fr {
	Translations$fridge$quantities$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: '{count} pièce'
	String pieceSingle({required Object count}) => '${count} pièce';

	/// fr: '{count} pièces'
	String pieceSeveral({required Object count}) => '${count} pièces';

	/// fr: '{count} g'
	String gram({required Object count}) => '${count} g';

	/// fr: '{count} kg'
	String kilogram({required Object count}) => '${count} kg';

	/// fr: '{count} ml'
	String milliliter({required Object count}) => '${count} ml';

	/// fr: '{count} L'
	String liter({required Object count}) => '${count} L';

	/// fr: '{count} paquet'
	String packSingle({required Object count}) => '${count} paquet';

	/// fr: '{count} paquets'
	String packSeveral({required Object count}) => '${count} paquets';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'account.titleLead' => 'Mon ',
			'account.titleHighlight' => 'compte',
			'account.name' => 'Nom',
			'account.email' => 'Adresse e-mail',
			'account.noName' => 'Non renseigné',
			'account.signOut' => 'Se déconnecter',
			'auth.signIn' => 'Se connecter',
			'auth.register' => 'Créer un compte',
			'auth.name' => 'Nom',
			'auth.email' => 'Adresse e-mail',
			'auth.password' => 'Mot de passe',
			'auth.firebaseUnavailable' => 'Firebase n’est pas configuré sur cette version de Mijoo.',
			'auth.invalidCredentials' => 'Vérifie ton adresse e-mail et ton mot de passe.',
			'auth.emailAlreadyUsed' => 'Un compte utilise déjà cette adresse e-mail.',
			'auth.weakPassword' => 'Choisis un mot de passe plus long.',
			'auth.invalidEmail' => 'Saisis une adresse e-mail valide.',
			'auth.networkFailure' => 'La connexion a échoué. Réessaie dans un instant.',
			'auth.registerLead' => 'Crée ton ',
			'auth.registerHighlight' => 'compte',
			'auth.registerSubtitle' => 'Quelques secondes et on passe à table.',
			'auth.signInLead' => 'Content de te ',
			'auth.signInHighlight' => 'revoir',
			'auth.signInSubtitle' => 'Connecte-toi pour retrouver ton frigo.',
			'auth.registerSubmit' => 'Créer mon compte',
			'auth.nameHint' => 'Ton prénom',
			'auth.emailHint' => 'nom@exemple.fr',
			'auth.passwordHint' => 'Ton mot de passe',
			'auth.confirmPassword' => 'Confirmer le mot de passe',
			'auth.confirmPasswordHint' => 'Saisis-le à nouveau',
			'auth.passwordMismatch' => 'Les mots de passe ne correspondent pas.',
			'auth.showPassword' => 'Afficher le mot de passe',
			'auth.hidePassword' => 'Masquer le mot de passe',
			'auth.ruleMinLength' => 'Au moins 8 caractères',
			'auth.ruleDigit' => 'Un chiffre',
			'auth.ruleUppercase' => 'Une majuscule',
			'auth.ruleSpecial' => 'Un caractère spécial',
			'auth.haveAccount' => 'Déjà un compte ? ',
			'auth.noAccount' => 'Pas encore de compte ? ',
			'auth.forgotPassword' => 'Mot de passe oublié ?',
			'auth.forgotLead' => 'Mot de passe ',
			'auth.forgotHighlight' => 'oublié ?',
			'auth.forgotSubtitle' => 'Saisis ton adresse e-mail, on t’envoie un lien pour en choisir un nouveau.',
			'auth.sendResetLink' => 'Envoyer le lien',
			'auth.resetSentLead' => 'Vérifie ta ',
			'auth.resetSentHighlight' => 'boîte mail',
			'auth.resetSentSubtitle' => 'Le lien arrive dans quelques instants.',
			'auth.resetSentMessage' => ({required Object email}) => 'Si un compte existe pour ${email}, tu vas recevoir un lien pour choisir un nouveau mot de passe. Pense à regarder dans les courriers indésirables.',
			'auth.backToSignIn' => 'Retour à la connexion',
			'auth.rememberPassword' => 'Tu t’en souviens ? ',
			'failures.unknown' => 'Une erreur est survenue. Réessaie dans un instant.',
			'fridge.title' => 'Mon frigo',
			'fridge.add' => 'Ajouter un ingrédient',
			'fridge.search' => 'Rechercher un ingrédient',
			'fridge.emptyTitle' => 'Ton frigo est vide',
			'fridge.emptyMessage' => 'Ajoute ce que tu as sous la main pour recevoir des idées de repas.',
			'fridge.noResultTitle' => 'Aucun ingrédient trouvé',
			'fridge.noResultMessage' => 'Vérifie l’orthographe ou ajoute cet ingrédient.',
			'fridge.retry' => 'Réessayer',
			'fridge.bestBefore' => ({required Object date}) => 'À consommer avant le ${date}',
			'fridge.addTitle' => 'Ajouter un ingrédient',
			'fridge.editTitle' => 'Modifier l’ingrédient',
			'fridge.name' => 'Nom',
			'fridge.nameHint' => 'Par exemple Tomates',
			'fridge.quantity' => 'Quantité',
			'fridge.quantityHint' => 'Par exemple 4',
			'fridge.quantityInvalid' => 'Saisis une quantité supérieure à 0.',
			'fridge.unit' => 'Unité',
			'fridge.category' => 'Rayon',
			'fridge.date' => 'Date de consommation',
			'fridge.dateOptional' => 'Facultative',
			'fridge.dateAdd' => 'Ajouter une date',
			'fridge.dateRemove' => 'Retirer la date',
			'fridge.save' => 'Enregistrer',
			'fridge.create' => 'Ajouter',
			'fridge.delete' => 'Supprimer l’ingrédient',
			'fridge.unavailable' => 'Ton frigo n’est pas accessible pour le moment. Réessaie dans un instant.',
			'fridge.accessDenied' => 'Tu n’as pas accès à ce frigo.',
			'fridge.networkFailure' => 'La connexion a échoué. Réessaie dans un instant.',
			'fridge.quantities.pieceSingle' => ({required Object count}) => '${count} pièce',
			'fridge.quantities.pieceSeveral' => ({required Object count}) => '${count} pièces',
			'fridge.quantities.gram' => ({required Object count}) => '${count} g',
			'fridge.quantities.kilogram' => ({required Object count}) => '${count} kg',
			'fridge.quantities.milliliter' => ({required Object count}) => '${count} ml',
			'fridge.quantities.liter' => ({required Object count}) => '${count} L',
			'fridge.quantities.packSingle' => ({required Object count}) => '${count} paquet',
			'fridge.quantities.packSeveral' => ({required Object count}) => '${count} paquets',
			'fridge.units.piece' => 'Pièce',
			'fridge.units.gram' => 'g',
			'fridge.units.kilogram' => 'kg',
			'fridge.units.milliliter' => 'ml',
			'fridge.units.liter' => 'L',
			'fridge.units.pack' => 'Paquet',
			'fridge.categories.fruitsVegetables' => 'Fruits et légumes',
			'fridge.categories.meatFish' => 'Viandes et poissons',
			'fridge.categories.dairy' => 'Produits laitiers',
			'fridge.categories.grocery' => 'Épicerie',
			'fridge.categories.frozen' => 'Surgelés',
			'fridge.categories.drinks' => 'Boissons',
			'fridge.categories.other' => 'Autres',
			'household.unavailable' => 'Ton foyer n’est pas accessible pour le moment. Réessaie dans un instant.',
			'household.accessDenied' => 'Tu n’as pas accès à ce foyer.',
			'household.networkFailure' => 'La connexion a échoué. Réessaie dans un instant.',
			'setup.step' => ({required Object current, required Object total}) => 'Étape ${current} sur ${total}',
			'setup.householdLead' => 'Ton ',
			'setup.householdHighlight' => 'foyer',
			'setup.householdSubtitle' => 'Pour adapter les portions de chaque repas.',
			'setup.adults' => 'Adultes',
			'setup.children' => 'Enfants',
			'setup.decrease' => 'Retirer un',
			'setup.increase' => 'Ajouter un',
			'setup.prepTime' => 'Temps de préparation maximum',
			'setup.minutes' => ({required Object count}) => '${count} min',
			'setup.preferencesLead' => 'Tes ',
			'setup.preferencesHighlight' => 'goûts',
			'setup.preferencesSubtitle' => 'Mijoo écarte toujours les exclusions et les allergies.',
			'setup.likesTitle' => 'Ce que vous aimez',
			'setup.exclusionsTitle' => 'À éviter',
			'setup.allergiesTitle' => 'Allergies',
			'setup.likes.pasta' => 'Pâtes',
			'setup.likes.rice' => 'Riz',
			'setup.likes.vegetables' => 'Légumes',
			'setup.likes.salads' => 'Salades',
			'setup.likes.soups' => 'Soupes',
			'setup.likes.stews' => 'Plats mijotés',
			'setup.likes.fish' => 'Poisson',
			'setup.likes.meat' => 'Viande',
			'setup.likes.vegetarian' => 'Végétarien',
			'setup.likes.worldCuisine' => 'Cuisines du monde',
			'setup.exclusions.pork' => 'Porc',
			'setup.exclusions.beef' => 'Bœuf',
			'setup.exclusions.meat' => 'Toute viande',
			'setup.exclusions.fish' => 'Poisson',
			'setup.exclusions.seafood' => 'Fruits de mer',
			'setup.exclusions.alcohol' => 'Alcool',
			'setup.exclusions.spicy' => 'Épicé',
			'setup.allergens.gluten' => 'Gluten',
			'setup.allergens.lactose' => 'Lactose',
			'setup.allergens.eggs' => 'Œufs',
			'setup.allergens.peanuts' => 'Arachides',
			'setup.allergens.treeNuts' => 'Fruits à coque',
			'setup.allergens.soy' => 'Soja',
			'setup.allergens.sesame' => 'Sésame',
			'setup.allergens.crustaceans' => 'Crustacés',
			'setup.allergens.fish' => 'Poisson',
			'setup.budgetLead' => 'Ton ',
			'setup.budgetHighlight' => 'budget',
			'setup.budgetSubtitle' => 'Facultatif, tu pourras le changer plus tard.',
			'setup.weeklyBudget' => 'Budget courses par semaine',
			'setup.weeklyBudgetHint' => 'Par exemple 120',
			'setup.euro' => '€',
			'setup.budgetInvalid' => 'Saisis un montant en euros, par exemple 120 ou 85,50.',
			'setup.postalCode' => 'Code postal',
			'setup.postalCodeHint' => '69001',
			'setup.postalCodeInvalid' => 'Saisis un code postal à 5 chiffres.',
			'setup.city' => 'Commune',
			'setup.cityHint' => 'Lyon',
			'setup.locationHelp' => 'Ta commune sert seulement à trouver les magasins proches.',
			'setup.kContinue' => 'Continuer',
			'setup.finish' => 'Terminer',
			'setup.doneLead' => 'Tout est ',
			'setup.doneHighlight' => 'prêt',
			'setup.doneSubtitle' => 'Ton foyer est configuré.',
			'setup.doneMessage' => 'Ajoute ce qu’il y a dans ton frigo pour recevoir tes premières idées de repas.',
			'setup.start' => 'Découvrir Mijoo',
			'shell.home' => 'Accueil',
			'shell.fridge' => 'Frigo',
			'shell.meals' => 'Repas',
			'shell.shopping' => 'Courses',
			'shell.greeting' => 'Bonjour',
			'shell.greetingName' => ({required Object name}) => 'Bonjour ${name}',
			'shell.comingSoon' => 'Cette partie arrive bientôt.',
			'shell.account' => 'Mon compte',
			'welcome.appName' => 'Mijoo',
			'welcome.titleLead' => 'Cuisine malin\navec ',
			'welcome.titleHighlight' => 'ton frigo',
			'welcome.subtitle' => 'Mijoo te propose des repas avec ton frigo, pour toute la famille et dans ton budget.',
			_ => null,
		};
	}
}
