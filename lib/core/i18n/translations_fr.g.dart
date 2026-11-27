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
	late final Translations$home$fr home = Translations$home$fr.internal(_root);
	late final Translations$household$fr household = Translations$household$fr.internal(_root);
	late final Translations$scan$fr scan = Translations$scan$fr.internal(_root);
	late final Translations$setup$fr setup = Translations$setup$fr.internal(_root);
	late final Translations$shell$fr shell = Translations$shell$fr.internal(_root);
	late final Translations$welcome$fr welcome = Translations$welcome$fr.internal(_root);
}

// Path: account
class Translations$account$fr {
	Translations$account$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mon compte'
	String get title => 'Mon compte';

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

	/// fr: 'Mon foyer'
	String get household => 'Mon foyer';

	/// fr: '1 personne'
	String get peopleSingle => '1 personne';

	/// fr: '{count} personnes'
	String peopleSeveral({required Object count}) => '${count} personnes';

	/// fr: '{adults}, {children}'
	String composition({required Object adults, required Object children}) => '${adults}, ${children}';

	/// fr: '1 adulte'
	String get adultsSingle => '1 adulte';

	/// fr: '{count} adultes'
	String adultsSeveral({required Object count}) => '${count} adultes';

	/// fr: 'sans enfant'
	String get childrenZero => 'sans enfant';

	/// fr: '1 enfant'
	String get childrenSingle => '1 enfant';

	/// fr: '{count} enfants'
	String childrenSeveral({required Object count}) => '${count} enfants';

	/// fr: '{count} min'
	String minutes({required Object count}) => '${count} min';

	/// fr: 'au plus par repas'
	String get prepDetail => 'au plus par repas';

	/// fr: 'Sans budget'
	String get noBudget => 'Sans budget';

	/// fr: 'par semaine'
	String get budgetDetail => 'par semaine';

	/// fr: 'Aucune allergie'
	String get allergiesZero => 'Aucune allergie';

	/// fr: '1 allergie'
	String get allergiesSingle => '1 allergie';

	/// fr: '{count} allergies'
	String allergiesSeveral({required Object count}) => '${count} allergies';

	/// fr: 'Commune non renseignée'
	String get noLocation => 'Commune non renseignée';
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

	/// fr: 'Ajouter au frigo'
	String get addChoiceTitle => 'Ajouter au frigo';

	/// fr: 'Photo du frigo'
	String get addPhoto => 'Photo du frigo';

	/// fr: 'Mijoo repère les ingrédients, tu valides.'
	String get addPhotoDetail => 'Mijoo repère les ingrédients, tu valides.';

	/// fr: 'Galerie'
	String get addGallery => 'Galerie';

	/// fr: 'Une photo déjà prise'
	String get addGalleryDetail => 'Une photo déjà prise';

	/// fr: 'Code-barres'
	String get addBarcode => 'Code-barres';

	/// fr: 'Rempli par Open Food Facts'
	String get addBarcodeDetail => 'Rempli par Open Food Facts';

	/// fr: 'À la main'
	String get addManual => 'À la main';

	/// fr: 'Nom, quantité, date'
	String get addManualDetail => 'Nom, quantité, date';

	/// fr: 'La photo est analysée par Gemini (Google), puis Mijoo ne la conserve pas.'
	String get photoPrivacy => 'La photo est analysée par Gemini (Google), puis Mijoo ne la conserve pas.';

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

	/// fr: 'À consommer avant'
	String get date => 'À consommer avant';

	/// fr: 'Facultative'
	String get dateOptional => 'Facultative';

	/// fr: 'Choisir une date'
	String get dateAdd => 'Choisir une date';

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

	/// fr: 'Tout'
	String get filterAll => 'Tout';

	late final Translations$fridge$stats$fr stats = Translations$fridge$stats$fr.internal(_root);
	late final Translations$fridge$freshness$fr freshness = Translations$fridge$freshness$fr.internal(_root);
	Map<String, String> get shortCategories => {
		'fruitsVegetables': 'Fruits et légumes',
		'meatFish': 'Viandes et poissons',
		'dairy': 'Laitiers',
		'grocery': 'Épicerie',
		'frozen': 'Surgelés',
		'drinks': 'Boissons',
		'other': 'Autres',
	};

	/// fr: 'Diminuer la quantité'
	String get decrease => 'Diminuer la quantité';

	/// fr: 'Augmenter la quantité'
	String get increase => 'Augmenter la quantité';
}

// Path: home
class Translations$home$fr {
	Translations$home$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Bonjour,'
	String get hello => 'Bonjour,';

	/// fr: 'Qu’est-ce qu’on mange '
	String get titleLead => 'Qu’est-ce qu’on mange ';

	/// fr: 'ce soir ?'
	String get titleHighlight => 'ce soir ?';

	/// fr: 'Scanne ton frigo'
	String get scanTitle => 'Scanne ton frigo';

	/// fr: 'Une photo et Mijoo repère tes ingrédients.'
	String get scanMessage => 'Une photo et Mijoo repère tes ingrédients.';

	/// fr: 'Prendre une photo'
	String get scanAction => 'Prendre une photo';

	/// fr: 'À consommer vite'
	String get finishFirst => 'À consommer vite';

	/// fr: 'Tout voir'
	String get seeAll => 'Tout voir';

	/// fr: 'Rien d’urgent dans ton frigo pour le moment.'
	String get nothingToFinish => 'Rien d’urgent dans ton frigo pour le moment.';

	/// fr: 'Idée du soir'
	String get mealIdea => 'Idée du soir';

	/// fr: 'Les idées de repas arrivent'
	String get mealSoonTitle => 'Les idées de repas arrivent';

	/// fr: 'Mijoo proposera des repas avec ce que tu as déjà au frigo.'
	String get mealSoonMessage => 'Mijoo proposera des repas avec ce que tu as déjà au frigo.';
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

// Path: scan
class Translations$scan$fr {
	Translations$scan$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Ouverture de l’appareil photo…'
	String get takingPhoto => 'Ouverture de l’appareil photo…';

	/// fr: 'Mijoo regarde ton frigo'
	String get analyzingTitle => 'Mijoo regarde ton frigo';

	/// fr: 'On repère les ingrédients visibles, ça prend quelques secondes.'
	String get analyzingMessage => 'On repère les ingrédients visibles, ça prend quelques secondes.';

	/// fr: 'Ce que'
	String get reviewTitleLead => 'Ce que';

	/// fr: 'j’ai vu'
	String get reviewTitleHighlight => 'j’ai vu';

	/// fr: 'Vérifie, corrige ou décoche avant d’ajouter à ton frigo.'
	String get reviewSubtitle => 'Vérifie, corrige ou décoche avant d’ajouter à ton frigo.';

	/// fr: 'À vérifier'
	String get uncertain => 'À vérifier';

	/// fr: 'Déjà au frigo, on ajoute'
	String get alreadyInFridge => 'Déjà au frigo, on ajoute';

	/// fr: 'Modifier'
	String get edit => 'Modifier';

	/// fr: 'Choisis au moins un ingrédient'
	String get addZero => 'Choisis au moins un ingrédient';

	/// fr: 'Ajouter 1 ingrédient'
	String get addSingle => 'Ajouter 1 ingrédient';

	/// fr: 'Ajouter {count} ingrédients'
	String addSeveral({required Object count}) => 'Ajouter ${count} ingrédients';

	/// fr: 'Aucun ingrédient repéré'
	String get nothingTitle => 'Aucun ingrédient repéré';

	/// fr: 'Essaie une photo plus nette, porte du frigo grande ouverte, ou ajoute tes ingrédients à la main.'
	String get nothingMessage => 'Essaie une photo plus nette, porte du frigo grande ouverte, ou ajoute tes ingrédients à la main.';

	/// fr: 'Reprendre une photo'
	String get retake => 'Reprendre une photo';

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	/// fr: 'Scanner un'
	String get barcodeTitleLead => 'Scanner un';

	/// fr: 'code-barres'
	String get barcodeTitleHighlight => 'code-barres';

	/// fr: 'Place le code-barres du produit dans le cadre.'
	String get barcodeHint => 'Place le code-barres du produit dans le cadre.';

	/// fr: 'Recherche du produit…'
	String get barcodeSearching => 'Recherche du produit…';

	/// fr: 'Produit introuvable'
	String get barcodeNotFoundTitle => 'Produit introuvable';

	/// fr: 'Ce code-barres n’est pas encore connu d’Open Food Facts. Tu peux ajouter le produit à la main.'
	String get barcodeNotFoundMessage => 'Ce code-barres n’est pas encore connu d’Open Food Facts. Tu peux ajouter le produit à la main.';

	/// fr: 'Ajouter à la main'
	String get manual => 'Ajouter à la main';

	/// fr: 'Scanner un autre produit'
	String get scanAgain => 'Scanner un autre produit';

	/// fr: 'Lire la date sur l’emballage'
	String get readDate => 'Lire la date sur l’emballage';

	/// fr: 'Lire'
	String get readDateShort => 'Lire';

	/// fr: 'Lecture de la date…'
	String get readingDate => 'Lecture de la date…';

	/// fr: 'Aucune date lisible sur la photo. Choisis-la dans le calendrier.'
	String get dateNotFound => 'Aucune date lisible sur la photo. Choisis-la dans le calendrier.';

	/// fr: 'La reconnaissance par photo n’est pas disponible pour le moment. Tu peux ajouter tes ingrédients à la main.'
	String get unavailable => 'La reconnaissance par photo n’est pas disponible pour le moment. Tu peux ajouter tes ingrédients à la main.';

	/// fr: 'L’analyse a échoué. Vérifie ta connexion et réessaie.'
	String get networkFailure => 'L’analyse a échoué. Vérifie ta connexion et réessaie.';

	/// fr: 'Trop d’analyses pour aujourd’hui. Réessaie plus tard ou ajoute tes ingrédients à la main.'
	String get quotaReached => 'Trop d’analyses pour aujourd’hui. Réessaie plus tard ou ajoute tes ingrédients à la main.';

	/// fr: 'L’analyse des photos est très demandée en ce moment. Réessaie dans quelques instants.'
	String get busy => 'L’analyse des photos est très demandée en ce moment. Réessaie dans quelques instants.';

	/// fr: 'La photo n’a pas pu être analysée. Réessaie avec une autre photo.'
	String get invalidResponse => 'La photo n’a pas pu être analysée. Réessaie avec une autre photo.';

	/// fr: 'La photo n’a pas pu être prise. Réessaie.'
	String get photoFailure => 'La photo n’a pas pu être prise. Réessaie.';

	/// fr: 'Mijoo n’a pas accès à l’appareil photo. Autorise-le dans les réglages de ton téléphone.'
	String get cameraDenied => 'Mijoo n’a pas accès à l’appareil photo. Autorise-le dans les réglages de ton téléphone.';

	/// fr: 'Le produit n’a pas pu être recherché. Vérifie ta connexion et réessaie.'
	String get productLookupFailure => 'Le produit n’a pas pu être recherché. Vérifie ta connexion et réessaie.';

	/// fr: '{count} ingrédients repérés'
	String foundSure({required Object count}) => '${count} ingrédients repérés';

	/// fr: '{count} ingrédients · {uncertain} à vérifier'
	String foundUncertain({required Object count, required Object uncertain}) => '${count} ingrédients · ${uncertain} à vérifier';

	/// fr: 'Tout cocher'
	String get selectAll => 'Tout cocher';

	/// fr: 'Tout décocher'
	String get unselectAll => 'Tout décocher';

	/// fr: 'Annuler l’analyse'
	String get cancel => 'Annuler l’analyse';
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

	/// fr: '13 ans et plus'
	String get adultsDetail => '13 ans et plus';

	/// fr: 'Moins de 13 ans'
	String get childrenDetail => 'Moins de 13 ans';

	/// fr: 'Retirer un'
	String get decrease => 'Retirer un';

	/// fr: 'Ajouter un'
	String get increase => 'Ajouter un';

	/// fr: 'Temps de préparation maximum'
	String get prepTime => 'Temps de préparation maximum';

	/// fr: '{count} min'
	String minutes({required Object count}) => '${count} min';

	/// fr: 'min'
	String get minutesUnit => 'min';

	/// fr: '1 portion par repas, prête en {minutes} min au plus.'
	String portionsSingle({required Object minutes}) => '1 portion par repas, prête en ${minutes} min au plus.';

	/// fr: '{count} portions par repas, prêtes en {minutes} min au plus.'
	String portionsSeveral({required Object count, required Object minutes}) => '${count} portions par repas, prêtes en ${minutes} min au plus.';

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

// Path: fridge.stats
class Translations$fridge$stats$fr {
	Translations$fridge$stats$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'ingrédient'
	String get totalSingle => 'ingrédient';

	/// fr: 'ingrédients'
	String get totalSeveral => 'ingrédients';

	/// fr: 'à finir vite'
	String get toFinish => 'à finir vite';

	/// fr: 'dépassé'
	String get expiredSingle => 'dépassé';

	/// fr: 'dépassés'
	String get expiredSeveral => 'dépassés';
}

// Path: fridge.freshness
class Translations$fridge$freshness$fr {
	Translations$fridge$freshness$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Dépassé'
	String get expired => 'Dépassé';

	/// fr: 'Aujourd’hui'
	String get today => 'Aujourd’hui';

	/// fr: 'Demain'
	String get tomorrow => 'Demain';

	/// fr: 'Dans {count} j'
	String inDays({required Object count}) => 'Dans ${count} j';
}

/// The flat map containing all translations for locale <fr>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'account.title' => 'Mon compte',
			'account.titleLead' => 'Mon ',
			'account.titleHighlight' => 'compte',
			'account.name' => 'Nom',
			'account.email' => 'Adresse e-mail',
			'account.noName' => 'Non renseigné',
			'account.signOut' => 'Se déconnecter',
			'account.household' => 'Mon foyer',
			'account.peopleSingle' => '1 personne',
			'account.peopleSeveral' => ({required Object count}) => '${count} personnes',
			'account.composition' => ({required Object adults, required Object children}) => '${adults}, ${children}',
			'account.adultsSingle' => '1 adulte',
			'account.adultsSeveral' => ({required Object count}) => '${count} adultes',
			'account.childrenZero' => 'sans enfant',
			'account.childrenSingle' => '1 enfant',
			'account.childrenSeveral' => ({required Object count}) => '${count} enfants',
			'account.minutes' => ({required Object count}) => '${count} min',
			'account.prepDetail' => 'au plus par repas',
			'account.noBudget' => 'Sans budget',
			'account.budgetDetail' => 'par semaine',
			'account.allergiesZero' => 'Aucune allergie',
			'account.allergiesSingle' => '1 allergie',
			'account.allergiesSeveral' => ({required Object count}) => '${count} allergies',
			'account.noLocation' => 'Commune non renseignée',
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
			'fridge.addChoiceTitle' => 'Ajouter au frigo',
			'fridge.addPhoto' => 'Photo du frigo',
			'fridge.addPhotoDetail' => 'Mijoo repère les ingrédients, tu valides.',
			'fridge.addGallery' => 'Galerie',
			'fridge.addGalleryDetail' => 'Une photo déjà prise',
			'fridge.addBarcode' => 'Code-barres',
			'fridge.addBarcodeDetail' => 'Rempli par Open Food Facts',
			'fridge.addManual' => 'À la main',
			'fridge.addManualDetail' => 'Nom, quantité, date',
			'fridge.photoPrivacy' => 'La photo est analysée par Gemini (Google), puis Mijoo ne la conserve pas.',
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
			'fridge.date' => 'À consommer avant',
			'fridge.dateOptional' => 'Facultative',
			'fridge.dateAdd' => 'Choisir une date',
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
			'fridge.filterAll' => 'Tout',
			'fridge.stats.totalSingle' => 'ingrédient',
			'fridge.stats.totalSeveral' => 'ingrédients',
			'fridge.stats.toFinish' => 'à finir vite',
			'fridge.stats.expiredSingle' => 'dépassé',
			'fridge.stats.expiredSeveral' => 'dépassés',
			'fridge.freshness.expired' => 'Dépassé',
			'fridge.freshness.today' => 'Aujourd’hui',
			'fridge.freshness.tomorrow' => 'Demain',
			'fridge.freshness.inDays' => ({required Object count}) => 'Dans ${count} j',
			'fridge.shortCategories.fruitsVegetables' => 'Fruits et légumes',
			'fridge.shortCategories.meatFish' => 'Viandes et poissons',
			'fridge.shortCategories.dairy' => 'Laitiers',
			'fridge.shortCategories.grocery' => 'Épicerie',
			'fridge.shortCategories.frozen' => 'Surgelés',
			'fridge.shortCategories.drinks' => 'Boissons',
			'fridge.shortCategories.other' => 'Autres',
			'fridge.decrease' => 'Diminuer la quantité',
			'fridge.increase' => 'Augmenter la quantité',
			'home.hello' => 'Bonjour,',
			'home.titleLead' => 'Qu’est-ce qu’on mange ',
			'home.titleHighlight' => 'ce soir ?',
			'home.scanTitle' => 'Scanne ton frigo',
			'home.scanMessage' => 'Une photo et Mijoo repère tes ingrédients.',
			'home.scanAction' => 'Prendre une photo',
			'home.finishFirst' => 'À consommer vite',
			'home.seeAll' => 'Tout voir',
			'home.nothingToFinish' => 'Rien d’urgent dans ton frigo pour le moment.',
			'home.mealIdea' => 'Idée du soir',
			'home.mealSoonTitle' => 'Les idées de repas arrivent',
			'home.mealSoonMessage' => 'Mijoo proposera des repas avec ce que tu as déjà au frigo.',
			'household.unavailable' => 'Ton foyer n’est pas accessible pour le moment. Réessaie dans un instant.',
			'household.accessDenied' => 'Tu n’as pas accès à ce foyer.',
			'household.networkFailure' => 'La connexion a échoué. Réessaie dans un instant.',
			'scan.takingPhoto' => 'Ouverture de l’appareil photo…',
			'scan.analyzingTitle' => 'Mijoo regarde ton frigo',
			'scan.analyzingMessage' => 'On repère les ingrédients visibles, ça prend quelques secondes.',
			'scan.reviewTitleLead' => 'Ce que',
			'scan.reviewTitleHighlight' => 'j’ai vu',
			'scan.reviewSubtitle' => 'Vérifie, corrige ou décoche avant d’ajouter à ton frigo.',
			'scan.uncertain' => 'À vérifier',
			'scan.alreadyInFridge' => 'Déjà au frigo, on ajoute',
			'scan.edit' => 'Modifier',
			'scan.addZero' => 'Choisis au moins un ingrédient',
			'scan.addSingle' => 'Ajouter 1 ingrédient',
			'scan.addSeveral' => ({required Object count}) => 'Ajouter ${count} ingrédients',
			'scan.nothingTitle' => 'Aucun ingrédient repéré',
			'scan.nothingMessage' => 'Essaie une photo plus nette, porte du frigo grande ouverte, ou ajoute tes ingrédients à la main.',
			'scan.retake' => 'Reprendre une photo',
			'scan.retry' => 'Réessayer',
			'scan.barcodeTitleLead' => 'Scanner un',
			'scan.barcodeTitleHighlight' => 'code-barres',
			'scan.barcodeHint' => 'Place le code-barres du produit dans le cadre.',
			'scan.barcodeSearching' => 'Recherche du produit…',
			'scan.barcodeNotFoundTitle' => 'Produit introuvable',
			'scan.barcodeNotFoundMessage' => 'Ce code-barres n’est pas encore connu d’Open Food Facts. Tu peux ajouter le produit à la main.',
			'scan.manual' => 'Ajouter à la main',
			'scan.scanAgain' => 'Scanner un autre produit',
			'scan.readDate' => 'Lire la date sur l’emballage',
			'scan.readDateShort' => 'Lire',
			'scan.readingDate' => 'Lecture de la date…',
			'scan.dateNotFound' => 'Aucune date lisible sur la photo. Choisis-la dans le calendrier.',
			'scan.unavailable' => 'La reconnaissance par photo n’est pas disponible pour le moment. Tu peux ajouter tes ingrédients à la main.',
			'scan.networkFailure' => 'L’analyse a échoué. Vérifie ta connexion et réessaie.',
			'scan.quotaReached' => 'Trop d’analyses pour aujourd’hui. Réessaie plus tard ou ajoute tes ingrédients à la main.',
			'scan.busy' => 'L’analyse des photos est très demandée en ce moment. Réessaie dans quelques instants.',
			'scan.invalidResponse' => 'La photo n’a pas pu être analysée. Réessaie avec une autre photo.',
			'scan.photoFailure' => 'La photo n’a pas pu être prise. Réessaie.',
			'scan.cameraDenied' => 'Mijoo n’a pas accès à l’appareil photo. Autorise-le dans les réglages de ton téléphone.',
			'scan.productLookupFailure' => 'Le produit n’a pas pu être recherché. Vérifie ta connexion et réessaie.',
			'scan.foundSure' => ({required Object count}) => '${count} ingrédients repérés',
			'scan.foundUncertain' => ({required Object count, required Object uncertain}) => '${count} ingrédients · ${uncertain} à vérifier',
			'scan.selectAll' => 'Tout cocher',
			'scan.unselectAll' => 'Tout décocher',
			'scan.cancel' => 'Annuler l’analyse',
			'setup.step' => ({required Object current, required Object total}) => 'Étape ${current} sur ${total}',
			'setup.householdLead' => 'Ton ',
			'setup.householdHighlight' => 'foyer',
			'setup.householdSubtitle' => 'Pour adapter les portions de chaque repas.',
			'setup.adults' => 'Adultes',
			'setup.children' => 'Enfants',
			'setup.adultsDetail' => '13 ans et plus',
			'setup.childrenDetail' => 'Moins de 13 ans',
			'setup.decrease' => 'Retirer un',
			'setup.increase' => 'Ajouter un',
			'setup.prepTime' => 'Temps de préparation maximum',
			'setup.minutes' => ({required Object count}) => '${count} min',
			'setup.minutesUnit' => 'min',
			'setup.portionsSingle' => ({required Object minutes}) => '1 portion par repas, prête en ${minutes} min au plus.',
			'setup.portionsSeveral' => ({required Object count, required Object minutes}) => '${count} portions par repas, prêtes en ${minutes} min au plus.',
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
