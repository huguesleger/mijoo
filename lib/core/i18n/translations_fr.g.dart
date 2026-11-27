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
	late final Translations$meals$fr meals = Translations$meals$fr.internal(_root);
	late final Translations$scan$fr scan = Translations$scan$fr.internal(_root);
	late final Translations$setup$fr setup = Translations$setup$fr.internal(_root);
	late final Translations$shell$fr shell = Translations$shell$fr.internal(_root);
	late final Translations$shopping$fr shopping = Translations$shopping$fr.internal(_root);
	late final Translations$stores$fr stores = Translations$stores$fr.internal(_root);
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

	/// fr: 'Modifier'
	String get editHousehold => 'Modifier';

	/// fr: 'Membres'
	String get members => 'Membres';

	/// fr: '1 membre'
	String get membersSingle => '1 membre';

	/// fr: '{count} membres'
	String membersSeveral({required Object count}) => '${count} membres';

	/// fr: 'Toi'
	String get you => 'Toi';

	/// fr: 'Membre du foyer'
	String get member => 'Membre du foyer';

	/// fr: 'Personne d’autre pour l’instant'
	String get nobody => 'Personne d’autre pour l’instant';

	/// fr: 'Partage un code pour inviter'
	String get nobodyDetail => 'Partage un code pour inviter';

	/// fr: 'Inviter quelqu’un'
	String get invite => 'Inviter quelqu’un';

	/// fr: 'Inviter dans ton foyer'
	String get inviteTitle => 'Inviter dans ton foyer';

	/// fr: 'Elle ou il crée son compte Mijoo, choisit « Rejoindre un foyer » et saisit ce code.'
	String get inviteMessage => 'Elle ou il crée son compte Mijoo, choisit « Rejoindre un foyer » et saisit ce code.';

	/// fr: 'Code d’invitation {code}'
	String inviteCodeLabel({required Object code}) => 'Code d’invitation ${code}';

	/// fr: 'Valable 48 h'
	String get inviteValid => 'Valable 48 h';

	/// fr: 'Une seule fois'
	String get inviteOnce => 'Une seule fois';

	/// fr: 'Partager le code'
	String get share => 'Partager le code';

	/// fr: 'Copier'
	String get copy => 'Copier';

	/// fr: 'Code copié'
	String get copied => 'Code copié';

	/// fr: 'Rejoins notre foyer sur Mijoo avec le code {code}, valable 48 heures. Crée ton compte puis choisis « Rejoindre un foyer ».'
	String shareText({required Object code}) => 'Rejoins notre foyer sur Mijoo avec le code ${code}, valable 48 heures. Crée ton compte puis choisis « Rejoindre un foyer ».';

	/// fr: 'La personne verra tout le foyer : frigo, idées, semaine et courses. Ne partage le code qu’avec elle.'
	String get inviteNote => 'La personne verra tout le foyer : frigo, idées, semaine et courses. Ne partage le code qu’avec elle.';

	/// fr: 'Quitter ce foyer'
	String get leave => 'Quitter ce foyer';

	/// fr: 'Quitter ce foyer ?'
	String get leaveTitle => 'Quitter ce foyer ?';

	/// fr: 'Tu ne verras plus le frigo, les idées ni la liste de ce foyer. Tu pourras ensuite créer un foyer ou en rejoindre un autre avec un code.'
	String get leaveMessage => 'Tu ne verras plus le frigo, les idées ni la liste de ce foyer. Tu pourras ensuite créer un foyer ou en rejoindre un autre avec un code.';

	/// fr: 'Quitter le foyer'
	String get leaveConfirm => 'Quitter le foyer';

	/// fr: 'Annuler'
	String get cancel => 'Annuler';
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

	/// fr: 'Idées de repas'
	String get mealSoonTitle => 'Idées de repas';

	/// fr: 'Trois repas avec ce que tu as déjà au frigo.'
	String get mealSoonMessage => 'Trois repas avec ce que tu as déjà au frigo.';
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

	/// fr: 'Ce code n’existe pas. Vérifie-le ou demande un nouveau code.'
	String get inviteNotFound => 'Ce code n’existe pas. Vérifie-le ou demande un nouveau code.';

	/// fr: 'Ce code a expiré. Demande un nouveau code.'
	String get inviteExpired => 'Ce code a expiré. Demande un nouveau code.';

	/// fr: 'Ce code a déjà servi. Demande un nouveau code.'
	String get inviteAlreadyUsed => 'Ce code a déjà servi. Demande un nouveau code.';
}

// Path: meals
class Translations$meals$fr {
	Translations$meals$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Idées repas'
	String get title => 'Idées repas';

	/// fr: 'Trois nouvelles idées'
	String get refresh => 'Trois nouvelles idées';

	/// fr: 'Pour 1 · {minutes} min max'
	String forOne({required Object minutes}) => 'Pour 1 · ${minutes} min max';

	/// fr: 'Pour {count} · {minutes} min max'
	String forSeveral({required Object count, required Object minutes}) => 'Pour ${count} · ${minutes} min max';

	/// fr: 'sans {label}'
	String without({required Object label}) => 'sans ${label}';

	/// fr: 'Aucun interdit déclaré'
	String get noRestriction => 'Aucun interdit déclaré';

	/// fr: '1 à finir vite'
	String get toFinishSingle => '1 à finir vite';

	/// fr: '{count} à finir vite'
	String toFinishSeveral({required Object count}) => '${count} à finir vite';

	Map<String, String> get cravings => {
		'any': 'Au choix',
		'quick': 'Rapide',
		'vegetarian': 'Végétarien',
		'comforting': 'Réconfortant',
	};

	/// fr: '{count} min'
	String minutes({required Object count}) => '${count} min';

	/// fr: '{count} pers.'
	String servingsShort({required Object count}) => '${count} pers.';

	/// fr: '1 personne'
	String get servingsSingle => '1 personne';

	/// fr: '{count} personnes'
	String servingsSeveral({required Object count}) => '${count} personnes';

	/// fr: 'Tout est dans le frigo'
	String get coverageAll => 'Tout est dans le frigo';

	/// fr: '{count} sur {total} ingrédients du frigo'
	String coverage({required Object count, required Object total}) => '${count} sur ${total} ingrédients du frigo';

	/// fr: '1 à acheter'
	String get toBuySingle => '1 à acheter';

	/// fr: '{count} à acheter'
	String toBuySeveral({required Object count}) => '${count} à acheter';

	/// fr: 'Rien à acheter'
	String get nothingToBuy => 'Rien à acheter';

	/// fr: 'Qu’est-ce qu’on mange ?'
	String get emptyTitle => 'Qu’est-ce qu’on mange ?';

	/// fr: 'Mijoo te propose 3 repas avec ce qu’il y a dans ton frigo, en commençant par ce qui est à finir vite.'
	String get emptyMessage => 'Mijoo te propose 3 repas avec ce qu’il y a dans ton frigo, en commençant par ce qui est à finir vite.';

	/// fr: 'Trouver 3 idées'
	String get find => 'Trouver 3 idées';

	/// fr: 'Mijoo cherche tes repas'
	String get generatingTitle => 'Mijoo cherche tes repas';

	/// fr: 'Avec ton ingrédient, en commençant par ce qui est à finir vite.'
	String get generatingSingle => 'Avec ton ingrédient, en commençant par ce qui est à finir vite.';

	/// fr: 'Avec tes {count} ingrédients, en commençant par ceux à finir vite.'
	String generatingSeveral({required Object count}) => 'Avec tes ${count} ingrédients, en commençant par ceux à finir vite.';

	/// fr: 'Ton frigo est vide : Mijoo choisit des recettes simples.'
	String get generatingEmptyFridge => 'Ton frigo est vide : Mijoo choisit des recettes simples.';

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	/// fr: '{name} à finir'
	String finishFirst({required Object name}) => '${name} à finir';

	/// fr: 'Ingrédients'
	String get ingredients => 'Ingrédients';

	/// fr: '{count} sur {total} dans le frigo'
	String inFridgeCount({required Object count, required Object total}) => '${count} sur ${total} dans le frigo';

	/// fr: 'Vérifie les étiquettes : des allergies sont déclarées dans le foyer.'
	String get allergyNote => 'Vérifie les étiquettes : des allergies sont déclarées dans le foyer.';

	/// fr: 'Vérifie les étiquettes des produits avant de cuisiner.'
	String get labelNote => 'Vérifie les étiquettes des produits avant de cuisiner.';

	/// fr: 'J’ai cuisiné ce repas'
	String get cooked => 'J’ai cuisiné ce repas';

	/// fr: 'Cette idée n’est plus proposée'
	String get missingTitle => 'Cette idée n’est plus proposée';

	/// fr: 'Le foyer a reçu de nouvelles idées entre-temps.'
	String get missingMessage => 'Le foyer a reçu de nouvelles idées entre-temps.';

	/// fr: 'Retour aux idées'
	String get back => 'Retour aux idées';

	/// fr: 'Bon appétit !'
	String get cookedTitle => 'Bon appétit !';

	/// fr: 'Voici ce que Mijoo retire du frigo. Ajuste si besoin.'
	String get cookedMessage => 'Voici ce que Mijoo retire du frigo. Ajuste si besoin.';

	/// fr: 'Aucun ingrédient de cette recette ne vient du frigo.'
	String get cookedNothing => 'Aucun ingrédient de cette recette ne vient du frigo.';

	/// fr: 'Il en reste {quantity}'
	String left({required Object quantity}) => 'Il en reste ${quantity}';

	/// fr: 'Le repas rejoint l’historique : Mijoo évitera de le reproposer trop vite.'
	String get historyNote => 'Le repas rejoint l’historique : Mijoo évitera de le reproposer trop vite.';

	/// fr: 'Mettre à jour le frigo'
	String get updateFridge => 'Mettre à jour le frigo';

	/// fr: 'Enregistrer le repas'
	String get saveMeal => 'Enregistrer le repas';

	/// fr: 'Ne rien retirer'
	String get keepFridge => 'Ne rien retirer';

	/// fr: 'Retirer moins de {name}'
	String less({required Object name}) => 'Retirer moins de ${name}';

	/// fr: 'Retirer plus de {name}'
	String more({required Object name}) => 'Retirer plus de ${name}';

	/// fr: 'Garder {name}'
	String keep({required Object name}) => 'Garder ${name}';

	/// fr: 'Retirer {name}'
	String remove({required Object name}) => 'Retirer ${name}';

	/// fr: 'Les idées de repas ne sont pas disponibles pour le moment.'
	String get unavailable => 'Les idées de repas ne sont pas disponibles pour le moment.';

	/// fr: 'La connexion a échoué. Réessaie dans un instant.'
	String get networkFailure => 'La connexion a échoué. Réessaie dans un instant.';

	/// fr: 'Tu n’as pas accès aux repas de ce foyer.'
	String get accessDenied => 'Tu n’as pas accès aux repas de ce foyer.';

	/// fr: 'Le service d’idées est très sollicité. Réessaie dans quelques minutes.'
	String get busy => 'Le service d’idées est très sollicité. Réessaie dans quelques minutes.';

	/// fr: 'Les idées gratuites du jour sont épuisées. Réessaie demain matin.'
	String get quotaReached => 'Les idées gratuites du jour sont épuisées. Réessaie demain matin.';

	/// fr: 'Les idées reçues étaient incomplètes. Réessaie.'
	String get invalidResponse => 'Les idées reçues étaient incomplètes. Réessaie.';

	/// fr: 'Aucune idée ne respectait vos contraintes. Réessaie ou change d’envie.'
	String get nothingSuitable => 'Aucune idée ne respectait vos contraintes. Réessaie ou change d’envie.';

	/// fr: 'Préparation'
	String get prep => 'Préparation';

	/// fr: 'Cuisson'
	String get cook => 'Cuisson';

	/// fr: 'Personnes'
	String get people => 'Personnes';

	/// fr: 'Niveau'
	String get level => 'Niveau';

	Map<String, String> get difficulties => {
		'easy': 'Facile',
		'medium': 'Moyen',
		'hard': 'Difficile',
	};

	/// fr: 'Photo d’illustration'
	String get photoBadge => 'Photo d’illustration';

	/// fr: 'Ingrédients'
	String get tabIngredients => 'Ingrédients';

	/// fr: 'Préparation'
	String get tabSteps => 'Préparation';

	/// fr: 'Pour 1 personne'
	String get servingsTitleSingle => 'Pour 1 personne';

	/// fr: 'Pour {count} personnes'
	String servingsTitleSeveral({required Object count}) => 'Pour ${count} personnes';

	/// fr: 'Les quantités suivent'
	String get servingsFollow => 'Les quantités suivent';

	/// fr: 'Recette prévue pour {count}'
	String servingsBase({required Object count}) => 'Recette prévue pour ${count}';

	/// fr: 'Une personne de moins'
	String get fewerPeople => 'Une personne de moins';

	/// fr: 'Une personne de plus'
	String get morePeople => 'Une personne de plus';

	/// fr: 'Dans le frigo'
	String get inFridgeLine => 'Dans le frigo';

	/// fr: 'Il en manque {quantity}'
	String missingLine({required Object quantity}) => 'Il en manque ${quantity}';

	/// fr: 'À acheter'
	String get toBuyLine => 'À acheter';

	/// fr: '{line} · ou {substitute}'
	String orSubstituteLine({required Object line, required Object substitute}) => '${line} · ou ${substitute}';

	/// fr: 'Étape {number}'
	String stepNumber({required Object number}) => 'Étape ${number}';

	/// fr: '1 étape'
	String get stepCountSingle => '1 étape';

	/// fr: '{count} étapes'
	String stepCountSeveral({required Object count}) => '${count} étapes';

	/// fr: 'Ma semaine'
	String get week => 'Ma semaine';

	/// fr: '1 repas · {portions} portions'
	String weekSummarySingle({required Object portions}) => '1 repas · ${portions} portions';

	/// fr: '{count} repas · {portions} portions'
	String weekSummarySeveral({required Object count, required Object portions}) => '${count} repas · ${portions} portions';

	/// fr: 'Idées du soir'
	String get tonight => 'Idées du soir';

	/// fr: 'Dans ma semaine'
	String get inWeek => 'Dans ma semaine';

	/// fr: 'Cuisiné'
	String get cookedTag => 'Cuisiné';

	/// fr: 'Ajouter à ma semaine'
	String get addToWeek => 'Ajouter à ma semaine';

	/// fr: 'Retirer de ma semaine'
	String get removeFromWeek => 'Retirer de ma semaine';

	/// fr: '0 €'
	String get costNothing => '0 €';

	/// fr: '≈ {amount} à acheter'
	String costToBuy({required Object amount}) => '≈ ${amount} à acheter';

	/// fr: 'Hors budget'
	String get overBudget => 'Hors budget';

	/// fr: 'Il reste {amount} cette semaine. 1 idée le dépasse : elle reste affichée, marquée hors budget.'
	String budgetLeftSingle({required Object amount}) => 'Il reste ${amount} cette semaine. 1 idée le dépasse : elle reste affichée, marquée hors budget.';

	/// fr: 'Il reste {amount} cette semaine. {count} idées le dépassent : elles restent affichées, marquées hors budget.'
	String budgetLeftSeveral({required Object amount, required Object count}) => 'Il reste ${amount} cette semaine. ${count} idées le dépassent : elles restent affichées, marquées hors budget.';

	/// fr: 'Le budget de la semaine est dépassé. 1 idée demande des achats : elle reste affichée, marquée hors budget.'
	String get budgetSpentSingle => 'Le budget de la semaine est dépassé. 1 idée demande des achats : elle reste affichée, marquée hors budget.';

	/// fr: 'Le budget de la semaine est dépassé. {count} idées demandent des achats : elles restent affichées, marquées hors budget.'
	String budgetSpentSeveral({required Object count}) => 'Le budget de la semaine est dépassé. ${count} idées demandent des achats : elles restent affichées, marquées hors budget.';
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

	/// fr: 'Modifier mon foyer'
	String get editTitle => 'Modifier mon foyer';

	/// fr: 'Composition'
	String get editComposition => 'Composition';

	/// fr: 'Goûts'
	String get editPreferences => 'Goûts';

	/// fr: 'Budget et commune'
	String get editBudget => 'Budget et commune';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';

	/// fr: 'Ton '
	String get chooseLead => 'Ton ';

	/// fr: 'foyer'
	String get chooseHighlight => 'foyer';

	/// fr: 'Tout le monde chez toi partage le même frigo et la même liste.'
	String get chooseSubtitle => 'Tout le monde chez toi partage le même frigo et la même liste.';

	/// fr: 'Créer mon foyer'
	String get createTitle => 'Créer mon foyer';

	/// fr: 'Je suis le premier de la famille sur Mijoo.'
	String get createDetail => 'Je suis le premier de la famille sur Mijoo.';

	/// fr: 'Rejoindre un foyer'
	String get joinTitle => 'Rejoindre un foyer';

	/// fr: 'Quelqu’un de la famille m’a envoyé un code.'
	String get joinDetail => 'Quelqu’un de la famille m’a envoyé un code.';

	/// fr: 'Pas de code ? Demande à la personne qui utilise déjà Mijoo de t’en envoyer un depuis Mon compte.'
	String get noCode => 'Pas de code ? Demande à la personne qui utilise déjà Mijoo de t’en envoyer un depuis Mon compte.';

	/// fr: 'Rejoindre '
	String get joinLead => 'Rejoindre ';

	/// fr: 'un foyer'
	String get joinHighlight => 'un foyer';

	/// fr: 'Saisis le code reçu de ta famille.'
	String get joinSubtitle => 'Saisis le code reçu de ta famille.';

	/// fr: 'Code d’invitation'
	String get codeLabel => 'Code d’invitation';

	/// fr: 'MJ-4K7Q'
	String get codeHint => 'MJ-4K7Q';

	/// fr: 'Valable 48 heures après sa création.'
	String get codeHelp => 'Valable 48 heures après sa création.';

	/// fr: 'Rejoindre le foyer'
	String get join => 'Rejoindre le foyer';
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

	/// fr: 'Mon compte'
	String get account => 'Mon compte';
}

// Path: shopping
class Translations$shopping$fr {
	Translations$shopping$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Mes courses'
	String get title => 'Mes courses';

	/// fr: 'Magasin'
	String get store => 'Magasin';

	/// fr: 'Magasins autour de moi'
	String get stores => 'Magasins autour de moi';

	/// fr: 'Ajouter un article (pain, lessive…)'
	String get addHint => 'Ajouter un article (pain, lessive…)';

	/// fr: 'Ajouter à la liste'
	String get add => 'Ajouter à la liste';

	/// fr: 'Ajouté à la main'
	String get manual => 'Ajouté à la main';

	/// fr: 'Ajouté par {name}'
	String addedBy({required Object name}) => 'Ajouté par ${name}';

	/// fr: 'il faut {quantity}'
	String needed({required Object quantity}) => 'il faut ${quantity}';

	/// fr: '{count} × {pack}'
	String packed({required Object count, required Object pack}) => '${count} × ${pack}';

	Map<String, String> get packs => {
		'eggBox': 'boîte de 6',
		'butter': 'plaquette de 250 g',
		'cream': 'brique de 20 cl',
		'milk': 'bouteille de 1 l',
		'gratedCheese': 'sachet de 200 g',
		'pasta': 'paquet de 500 g',
		'rice': 'paquet de 1 kg',
		'flour': 'paquet de 1 kg',
	};

	/// fr: 'Déjà dans le frigo'
	String get reserved => 'Déjà dans le frigo';

	/// fr: 'réservé · {count}'
	String reservedCount({required Object count}) => 'réservé · ${count}';

	/// fr: 'Réservé'
	String get reservedTag => 'Réservé';

	/// fr: '{meals} · {quantity}'
	String reservedFor({required Object meals, required Object quantity}) => '${meals} · ${quantity}';

	/// fr: 'Cocher {name}'
	String check({required Object name}) => 'Cocher ${name}';

	/// fr: 'Décocher {name}'
	String uncheck({required Object name}) => 'Décocher ${name}';

	/// fr: 'Ta liste est vide'
	String get emptyTitle => 'Ta liste est vide';

	/// fr: 'Ajoute des repas à ta semaine depuis l’onglet Repas : leurs ingrédients manquants arrivent ici. Tu peux aussi ajouter un article ci-dessus.'
	String get emptyMessage => 'Ajoute des repas à ta semaine depuis l’onglet Repas : leurs ingrédients manquants arrivent ici. Tu peux aussi ajouter un article ci-dessus.';

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	/// fr: 'Quantité à acheter'
	String get quantityTitle => 'Quantité à acheter';

	/// fr: 'Il faut {quantity}.'
	String neededExplained({required Object quantity}) => 'Il faut ${quantity}.';

	/// fr: 'Il faut {quantity}. Arrondi au conditionnement : {pack}.'
	String packExplained({required Object quantity, required Object pack}) => 'Il faut ${quantity}. Arrondi au conditionnement : ${pack}.';

	/// fr: 'Rayon'
	String get aisle => 'Rayon';

	/// fr: 'Enregistrer'
	String get save => 'Enregistrer';

	/// fr: 'Retirer de la liste'
	String get remove => 'Retirer de la liste';

	/// fr: 'Moins'
	String get less => 'Moins';

	/// fr: 'Plus'
	String get more => 'Plus';

	/// fr: 'Ranger dans le frigo'
	String get storeTitle => 'Ranger dans le frigo';

	/// fr: '1 article coché. Ajuste ce que tu as vraiment acheté.'
	String get storeMessageSingle => '1 article coché. Ajuste ce que tu as vraiment acheté.';

	/// fr: '{count} articles cochés. Ajuste ce que tu as vraiment acheté.'
	String storeMessageSeveral({required Object count}) => '${count} articles cochés. Ajuste ce que tu as vraiment acheté.';

	/// fr: 'Hors frigo, retiré de la liste'
	String get outsideFridge => 'Hors frigo, retiré de la liste';

	/// fr: 'Les ingrédients rejoignent le frigo et quittent la liste. Ceux des repas prévus restent réservés.'
	String get storeNote => 'Les ingrédients rejoignent le frigo et quittent la liste. Ceux des repas prévus restent réservés.';

	/// fr: 'Retirer de la liste'
	String get storeZero => 'Retirer de la liste';

	/// fr: 'Ranger 1 article'
	String get storeSingle => 'Ranger 1 article';

	/// fr: 'Ranger {count} articles'
	String storeSeveral({required Object count}) => 'Ranger ${count} articles';

	/// fr: 'Plus tard'
	String get later => 'Plus tard';

	/// fr: 'Ranger {name} dans le frigo'
	String keepInFridge({required Object name}) => 'Ranger ${name} dans le frigo';

	/// fr: 'Ne pas ranger {name}'
	String skipFridge({required Object name}) => 'Ne pas ranger ${name}';

	/// fr: 'La liste de courses n’est pas disponible pour le moment.'
	String get unavailable => 'La liste de courses n’est pas disponible pour le moment.';

	/// fr: 'La connexion a échoué. Réessaie dans un instant.'
	String get networkFailure => 'La connexion a échoué. Réessaie dans un instant.';

	/// fr: 'Tu n’as pas accès à la liste de ce foyer.'
	String get accessDenied => 'Tu n’as pas accès à la liste de ce foyer.';

	/// fr: 'Semaine du {date}'
	String week({required Object date}) => 'Semaine du ${date}';

	/// fr: 'Dépense'
	String get expense => 'Dépense';

	/// fr: 'Dépensé'
	String get spent => 'Dépensé';

	/// fr: 'Panier prévu'
	String get planned => 'Panier prévu';

	/// fr: '{low} à {high}'
	String plannedRange({required Object low, required Object high}) => '${low} à ${high}';

	/// fr: 'Reste sur {budget}'
	String remaining({required Object budget}) => 'Reste sur ${budget}';

	/// fr: 'Dépassé sur {budget}'
	String overBudget({required Object budget}) => 'Dépassé sur ${budget}';

	/// fr: 'Pas de budget'
	String get noBudget => 'Pas de budget';

	/// fr: 'à définir dans Mon foyer'
	String get noBudgetDetail => 'à définir dans Mon foyer';

	/// fr: '≈ {amount}'
	String approx({required Object amount}) => '≈ ${amount}';

	/// fr: 'Sans prix connu'
	String get unpriced => 'Sans prix connu';

	/// fr: 'Pas compté dans le panier'
	String get unpricedDetail => 'Pas compté dans le panier';

	/// fr: 'Ajouter un prix'
	String get addPrice => 'Ajouter un prix';

	Map<String, String> get reliabilities => {
		'low': 'Prix indicatif, peu fiable',
		'medium': 'Prix assez fiable',
		'high': 'Prix fiable',
	};

	/// fr: 'Prix'
	String get priceTitle => 'Prix';

	Map<String, String> get sources => {
		'household': 'Ton prix, partagé avec le foyer',
		'openPrices': 'Open Prices',
		'catalog': 'Prix moyen indicatif Mijoo',
	};

	/// fr: '1 relevé en France'
	String get observationsSingle => '1 relevé en France';

	/// fr: '{count} relevés en France'
	String observationsSeveral({required Object count}) => '${count} relevés en France';

	/// fr: 'Dernier relevé le {date}'
	String lastSeen({required Object date}) => 'Dernier relevé le ${date}';

	Map<String, String> get myPrice => {
		'kilogram': 'Mon prix au kilo',
		'liter': 'Mon prix au litre',
		'piece': 'Mon prix à la pièce',
	};

	/// fr: 'Par exemple 1,15'
	String get myPriceHint => 'Par exemple 1,15';

	/// fr: 'Ton prix sert à tout le foyer et remplace l’estimation.'
	String get myPriceHelp => 'Ton prix sert à tout le foyer et remplace l’estimation.';

	Map<String, String> get priceUnit => {
		'kilogram': '€/kg',
		'liter': '€/l',
		'piece': '€',
	};

	/// fr: 'Saisis un prix en euros, par exemple 1,15.'
	String get priceInvalid => 'Saisis un prix en euros, par exemple 1,15.';

	/// fr: 'Nouvelle dépense'
	String get expenseTitle => 'Nouvelle dépense';

	/// fr: 'Montant'
	String get amount => 'Montant';

	/// fr: 'Par exemple 38,70'
	String get amountHint => 'Par exemple 38,70';

	/// fr: 'Saisis un montant en euros, par exemple 38,70.'
	String get amountInvalid => 'Saisis un montant en euros, par exemple 38,70.';

	/// fr: 'Date'
	String get date => 'Date';

	/// fr: 'Aujourd’hui'
	String get today => 'Aujourd’hui';

	/// fr: 'Facultatif'
	String get storeHint => 'Facultatif';

	/// fr: 'Ajouter la dépense'
	String get addExpense => 'Ajouter la dépense';

	/// fr: 'Cette semaine'
	String get thisWeek => 'Cette semaine';

	/// fr: '{spent} sur {budget}'
	String weekSpent({required Object spent, required Object budget}) => '${spent} sur ${budget}';

	/// fr: '{spent} dépensés'
	String weekSpentNoBudget({required Object spent}) => '${spent} dépensés';

	/// fr: '{date} · {name}'
	String expenseBy({required Object date, required Object name}) => '${date} · ${name}';

	/// fr: 'Supprimer la dépense de {amount}'
	String deleteExpense({required Object amount}) => 'Supprimer la dépense de ${amount}';

	/// fr: 'Aucune dépense saisie cette semaine.'
	String get noExpense => 'Aucune dépense saisie cette semaine.';

	/// fr: 'Courses'
	String get expenseDefault => 'Courses';

	/// fr: 'soit {price} le kilo'
	String perKilogram({required Object price}) => 'soit ${price} le kilo';

	/// fr: 'soit {price} le litre'
	String perLiter({required Object price}) => 'soit ${price} le litre';

	/// fr: 'soit {price} la pièce'
	String perPiece({required Object price}) => 'soit ${price} la pièce';

	/// fr: 'de {low} à {high} le kilo'
	String rangeKilogram({required Object low, required Object high}) => 'de ${low} à ${high} le kilo';

	/// fr: 'de {low} à {high} le litre'
	String rangeLiter({required Object low, required Object high}) => 'de ${low} à ${high} le litre';

	/// fr: 'de {low} à {high} la pièce'
	String rangePiece({required Object low, required Object high}) => 'de ${low} à ${high} la pièce';
}

// Path: stores
class Translations$stores$fr {
	Translations$stores$fr.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// fr: 'Magasins autour de moi'
	String get title => 'Magasins autour de moi';

	/// fr: 'Liste'
	String get list => 'Liste';

	/// fr: 'Carte'
	String get map => 'Carte';

	/// fr: '{city} · {postalCode}'
	String townTitle({required Object city, required Object postalCode}) => '${city} · ${postalCode}';

	/// fr: 'Commune de ton foyer'
	String get townSubtitle => 'Commune de ton foyer';

	/// fr: 'Ma position'
	String get positionTitle => 'Ma position';

	/// fr: 'Recherche autour de toi, non enregistrée'
	String get positionSubtitle => 'Recherche autour de toi, non enregistrée';

	/// fr: 'Ma position'
	String get usePosition => 'Ma position';

	/// fr: 'Ma commune'
	String get useTown => 'Ma commune';

	Map<String, String> get radius => {
		'short': '500 m',
		'near': '1 km',
		'medium': '2 km',
		'far': '5 km',
	};
	Map<String, String> get filters => {
		'all': 'Tous',
		'supermarkets': 'Supermarchés',
		'local': 'Proximité',
		'bakeries': 'Boulangeries',
		'markets': 'Marchés',
		'specialists': 'Spécialistes',
	};
	Map<String, String> get kinds => {
		'supermarket': 'Supermarché',
		'convenience': 'Supérette',
		'bakery': 'Boulangerie',
		'butcher': 'Boucherie',
		'greengrocer': 'Primeur',
		'organic': 'Magasin bio',
		'cheese': 'Fromagerie',
		'frozenFood': 'Surgelés',
		'marketplace': 'Marché',
	};

	/// fr: '{meters} m'
	String meters({required Object meters}) => '${meters} m';

	/// fr: '{kilometers} km'
	String kilometers({required Object kilometers}) => '${kilometers} km';

	/// fr: '{hours}:{minutes}'
	String time({required Object hours, required Object minutes}) => '${hours}:${minutes}';

	/// fr: 'Ouvert · ferme à {time}'
	String openUntil({required Object time}) => 'Ouvert · ferme à ${time}';

	/// fr: 'Ouvert'
	String get open => 'Ouvert';

	/// fr: 'Fermé · ouvre à {time}'
	String closedOpensToday({required Object time}) => 'Fermé · ouvre à ${time}';

	/// fr: 'Fermé · ouvre {day} à {time}'
	String closedOpensOn({required Object day, required Object time}) => 'Fermé · ouvre ${day} à ${time}';

	/// fr: 'Fermé'
	String get closed => 'Fermé';

	/// fr: 'Horaires non renseignés'
	String get hoursUnknown => 'Horaires non renseignés';

	/// fr: 'Horaires sur la fiche'
	String get hoursOnSheet => 'Horaires sur la fiche';

	List<String> get days => [
		'lundi',
		'mardi',
		'mercredi',
		'jeudi',
		'vendredi',
		'samedi',
		'dimanche',
	];
	List<String> get dayNames => [
		'Lundi',
		'Mardi',
		'Mercredi',
		'Jeudi',
		'Vendredi',
		'Samedi',
		'Dimanche',
	];

	/// fr: '{day}, aujourd’hui'
	String today({required Object day}) => '${day}, aujourd’hui';

	/// fr: 'Fermé'
	String get closedDay => 'Fermé';

	/// fr: '{start} – {end}'
	String range({required Object start, required Object end}) => '${start} – ${end}';

	/// fr: 'Aucun magasin à moins de {radius}'
	String countZero({required Object radius}) => 'Aucun magasin à moins de ${radius}';

	/// fr: '1 magasin à moins de {radius}'
	String countSingle({required Object radius}) => '1 magasin à moins de ${radius}';

	/// fr: '{count} magasins à moins de {radius}'
	String countSeveral({required Object count, required Object radius}) => '${count} magasins à moins de ${radius}';

	/// fr: 'Aucun magasin de ce type dans ce rayon. Élargis la recherche ou choisis un autre type.'
	String get emptyFilter => 'Aucun magasin de ce type dans ce rayon. Élargis la recherche ou choisis un autre type.';

	/// fr: 'Données © contributeurs OpenStreetMap · distances à vol d’oiseau'
	String get attribution => 'Données © contributeurs OpenStreetMap · distances à vol d’oiseau';

	/// fr: 'contributeurs OpenStreetMap'
	String get mapAttribution => 'contributeurs OpenStreetMap';

	/// fr: '{kind} · {address}'
	String kindAndAddress({required Object kind, required Object address}) => '${kind} · ${address}';

	/// fr: '{kind} · à {distance}'
	String kindAndDistance({required Object kind, required Object distance}) => '${kind} · à ${distance}';

	/// fr: 'Horaires'
	String get hours => 'Horaires';

	/// fr: 'Itinéraire'
	String get directions => 'Itinéraire';

	/// fr: 'Horaires et adresse issus d’OpenStreetMap, à vérifier sur place.'
	String get sheetNote => 'Horaires et adresse issus d’OpenStreetMap, à vérifier sur place.';

	/// fr: 'Chercher autour de toi ?'
	String get consentTitle => 'Chercher autour de toi ?';

	/// fr: 'Mijoo utilise ta position seulement pour cette recherche. Elle n’est ni enregistrée ni partagée avec ton foyer.'
	String get consentMessage => 'Mijoo utilise ta position seulement pour cette recherche. Elle n’est ni enregistrée ni partagée avec ton foyer.';

	/// fr: 'Utiliser ma position'
	String get consentAccept => 'Utiliser ma position';

	/// fr: 'Rester sur {city}'
	String consentStay({required Object city}) => 'Rester sur ${city}';

	/// fr: 'Pas maintenant'
	String get consentCancel => 'Pas maintenant';

	/// fr: 'Si tu refuses, la recherche par commune reste disponible.'
	String get consentNote => 'Si tu refuses, la recherche par commune reste disponible.';

	/// fr: 'Où chercher ?'
	String get noTownTitle => 'Où chercher ?';

	/// fr: 'Indique la commune de ton foyer ou utilise ta position pour voir les magasins proches.'
	String get noTownMessage => 'Indique la commune de ton foyer ou utilise ta position pour voir les magasins proches.';

	/// fr: 'Renseigner ma commune'
	String get noTownEdit => 'Renseigner ma commune';

	/// fr: 'Réessayer'
	String get retry => 'Réessayer';

	/// fr: 'Recherche des commerces sur OpenStreetMap, cela peut prendre jusqu’à une minute.'
	String get searching => 'Recherche des commerces sur OpenStreetMap, cela peut prendre jusqu’à une minute.';

	/// fr: 'Impossible de joindre le service des magasins. Vérifie ta connexion et réessaie.'
	String get networkFailure => 'Impossible de joindre le service des magasins. Vérifie ta connexion et réessaie.';

	/// fr: 'Le service des magasins est très demandé. Réessaie dans un moment.'
	String get busy => 'Le service des magasins est très demandé. Réessaie dans un moment.';

	/// fr: 'La commune du foyer n’a pas été trouvée. Vérifie son code postal.'
	String get townNotFound => 'La commune du foyer n’a pas été trouvée. Vérifie son code postal.';

	/// fr: 'Impossible de trouver ta position. Vérifie que la localisation est activée.'
	String get locationOff => 'Impossible de trouver ta position. Vérifie que la localisation est activée.';

	/// fr: 'Mijoo n’a pas accès à ta position. Autorise-la dans les réglages, ou cherche autour de ta commune.'
	String get locationDenied => 'Mijoo n’a pas accès à ta position. Autorise-la dans les réglages, ou cherche autour de ta commune.';
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
			'account.editHousehold' => 'Modifier',
			'account.members' => 'Membres',
			'account.membersSingle' => '1 membre',
			'account.membersSeveral' => ({required Object count}) => '${count} membres',
			'account.you' => 'Toi',
			'account.member' => 'Membre du foyer',
			'account.nobody' => 'Personne d’autre pour l’instant',
			'account.nobodyDetail' => 'Partage un code pour inviter',
			'account.invite' => 'Inviter quelqu’un',
			'account.inviteTitle' => 'Inviter dans ton foyer',
			'account.inviteMessage' => 'Elle ou il crée son compte Mijoo, choisit « Rejoindre un foyer » et saisit ce code.',
			'account.inviteCodeLabel' => ({required Object code}) => 'Code d’invitation ${code}',
			'account.inviteValid' => 'Valable 48 h',
			'account.inviteOnce' => 'Une seule fois',
			'account.share' => 'Partager le code',
			'account.copy' => 'Copier',
			'account.copied' => 'Code copié',
			'account.shareText' => ({required Object code}) => 'Rejoins notre foyer sur Mijoo avec le code ${code}, valable 48 heures. Crée ton compte puis choisis « Rejoindre un foyer ».',
			'account.inviteNote' => 'La personne verra tout le foyer : frigo, idées, semaine et courses. Ne partage le code qu’avec elle.',
			'account.leave' => 'Quitter ce foyer',
			'account.leaveTitle' => 'Quitter ce foyer ?',
			'account.leaveMessage' => 'Tu ne verras plus le frigo, les idées ni la liste de ce foyer. Tu pourras ensuite créer un foyer ou en rejoindre un autre avec un code.',
			'account.leaveConfirm' => 'Quitter le foyer',
			'account.cancel' => 'Annuler',
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
			'home.mealSoonTitle' => 'Idées de repas',
			'home.mealSoonMessage' => 'Trois repas avec ce que tu as déjà au frigo.',
			'household.unavailable' => 'Ton foyer n’est pas accessible pour le moment. Réessaie dans un instant.',
			'household.accessDenied' => 'Tu n’as pas accès à ce foyer.',
			'household.networkFailure' => 'La connexion a échoué. Réessaie dans un instant.',
			'household.inviteNotFound' => 'Ce code n’existe pas. Vérifie-le ou demande un nouveau code.',
			'household.inviteExpired' => 'Ce code a expiré. Demande un nouveau code.',
			'household.inviteAlreadyUsed' => 'Ce code a déjà servi. Demande un nouveau code.',
			'meals.title' => 'Idées repas',
			'meals.refresh' => 'Trois nouvelles idées',
			'meals.forOne' => ({required Object minutes}) => 'Pour 1 · ${minutes} min max',
			'meals.forSeveral' => ({required Object count, required Object minutes}) => 'Pour ${count} · ${minutes} min max',
			'meals.without' => ({required Object label}) => 'sans ${label}',
			'meals.noRestriction' => 'Aucun interdit déclaré',
			'meals.toFinishSingle' => '1 à finir vite',
			'meals.toFinishSeveral' => ({required Object count}) => '${count} à finir vite',
			'meals.cravings.any' => 'Au choix',
			'meals.cravings.quick' => 'Rapide',
			'meals.cravings.vegetarian' => 'Végétarien',
			'meals.cravings.comforting' => 'Réconfortant',
			'meals.minutes' => ({required Object count}) => '${count} min',
			'meals.servingsShort' => ({required Object count}) => '${count} pers.',
			'meals.servingsSingle' => '1 personne',
			'meals.servingsSeveral' => ({required Object count}) => '${count} personnes',
			'meals.coverageAll' => 'Tout est dans le frigo',
			'meals.coverage' => ({required Object count, required Object total}) => '${count} sur ${total} ingrédients du frigo',
			'meals.toBuySingle' => '1 à acheter',
			'meals.toBuySeveral' => ({required Object count}) => '${count} à acheter',
			'meals.nothingToBuy' => 'Rien à acheter',
			'meals.emptyTitle' => 'Qu’est-ce qu’on mange ?',
			'meals.emptyMessage' => 'Mijoo te propose 3 repas avec ce qu’il y a dans ton frigo, en commençant par ce qui est à finir vite.',
			'meals.find' => 'Trouver 3 idées',
			'meals.generatingTitle' => 'Mijoo cherche tes repas',
			'meals.generatingSingle' => 'Avec ton ingrédient, en commençant par ce qui est à finir vite.',
			'meals.generatingSeveral' => ({required Object count}) => 'Avec tes ${count} ingrédients, en commençant par ceux à finir vite.',
			'meals.generatingEmptyFridge' => 'Ton frigo est vide : Mijoo choisit des recettes simples.',
			'meals.retry' => 'Réessayer',
			'meals.finishFirst' => ({required Object name}) => '${name} à finir',
			'meals.ingredients' => 'Ingrédients',
			'meals.inFridgeCount' => ({required Object count, required Object total}) => '${count} sur ${total} dans le frigo',
			'meals.allergyNote' => 'Vérifie les étiquettes : des allergies sont déclarées dans le foyer.',
			'meals.labelNote' => 'Vérifie les étiquettes des produits avant de cuisiner.',
			'meals.cooked' => 'J’ai cuisiné ce repas',
			'meals.missingTitle' => 'Cette idée n’est plus proposée',
			'meals.missingMessage' => 'Le foyer a reçu de nouvelles idées entre-temps.',
			'meals.back' => 'Retour aux idées',
			'meals.cookedTitle' => 'Bon appétit !',
			'meals.cookedMessage' => 'Voici ce que Mijoo retire du frigo. Ajuste si besoin.',
			'meals.cookedNothing' => 'Aucun ingrédient de cette recette ne vient du frigo.',
			'meals.left' => ({required Object quantity}) => 'Il en reste ${quantity}',
			'meals.historyNote' => 'Le repas rejoint l’historique : Mijoo évitera de le reproposer trop vite.',
			'meals.updateFridge' => 'Mettre à jour le frigo',
			'meals.saveMeal' => 'Enregistrer le repas',
			'meals.keepFridge' => 'Ne rien retirer',
			'meals.less' => ({required Object name}) => 'Retirer moins de ${name}',
			'meals.more' => ({required Object name}) => 'Retirer plus de ${name}',
			'meals.keep' => ({required Object name}) => 'Garder ${name}',
			'meals.remove' => ({required Object name}) => 'Retirer ${name}',
			'meals.unavailable' => 'Les idées de repas ne sont pas disponibles pour le moment.',
			'meals.networkFailure' => 'La connexion a échoué. Réessaie dans un instant.',
			'meals.accessDenied' => 'Tu n’as pas accès aux repas de ce foyer.',
			'meals.busy' => 'Le service d’idées est très sollicité. Réessaie dans quelques minutes.',
			'meals.quotaReached' => 'Les idées gratuites du jour sont épuisées. Réessaie demain matin.',
			'meals.invalidResponse' => 'Les idées reçues étaient incomplètes. Réessaie.',
			'meals.nothingSuitable' => 'Aucune idée ne respectait vos contraintes. Réessaie ou change d’envie.',
			'meals.prep' => 'Préparation',
			'meals.cook' => 'Cuisson',
			'meals.people' => 'Personnes',
			'meals.level' => 'Niveau',
			'meals.difficulties.easy' => 'Facile',
			'meals.difficulties.medium' => 'Moyen',
			'meals.difficulties.hard' => 'Difficile',
			'meals.photoBadge' => 'Photo d’illustration',
			'meals.tabIngredients' => 'Ingrédients',
			'meals.tabSteps' => 'Préparation',
			'meals.servingsTitleSingle' => 'Pour 1 personne',
			'meals.servingsTitleSeveral' => ({required Object count}) => 'Pour ${count} personnes',
			'meals.servingsFollow' => 'Les quantités suivent',
			'meals.servingsBase' => ({required Object count}) => 'Recette prévue pour ${count}',
			'meals.fewerPeople' => 'Une personne de moins',
			'meals.morePeople' => 'Une personne de plus',
			'meals.inFridgeLine' => 'Dans le frigo',
			'meals.missingLine' => ({required Object quantity}) => 'Il en manque ${quantity}',
			'meals.toBuyLine' => 'À acheter',
			'meals.orSubstituteLine' => ({required Object line, required Object substitute}) => '${line} · ou ${substitute}',
			'meals.stepNumber' => ({required Object number}) => 'Étape ${number}',
			'meals.stepCountSingle' => '1 étape',
			'meals.stepCountSeveral' => ({required Object count}) => '${count} étapes',
			'meals.week' => 'Ma semaine',
			'meals.weekSummarySingle' => ({required Object portions}) => '1 repas · ${portions} portions',
			'meals.weekSummarySeveral' => ({required Object count, required Object portions}) => '${count} repas · ${portions} portions',
			'meals.tonight' => 'Idées du soir',
			'meals.inWeek' => 'Dans ma semaine',
			'meals.cookedTag' => 'Cuisiné',
			'meals.addToWeek' => 'Ajouter à ma semaine',
			'meals.removeFromWeek' => 'Retirer de ma semaine',
			'meals.costNothing' => '0 €',
			'meals.costToBuy' => ({required Object amount}) => '≈ ${amount} à acheter',
			'meals.overBudget' => 'Hors budget',
			'meals.budgetLeftSingle' => ({required Object amount}) => 'Il reste ${amount} cette semaine. 1 idée le dépasse : elle reste affichée, marquée hors budget.',
			'meals.budgetLeftSeveral' => ({required Object amount, required Object count}) => 'Il reste ${amount} cette semaine. ${count} idées le dépassent : elles restent affichées, marquées hors budget.',
			'meals.budgetSpentSingle' => 'Le budget de la semaine est dépassé. 1 idée demande des achats : elle reste affichée, marquée hors budget.',
			'meals.budgetSpentSeveral' => ({required Object count}) => 'Le budget de la semaine est dépassé. ${count} idées demandent des achats : elles restent affichées, marquées hors budget.',
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
			'setup.editTitle' => 'Modifier mon foyer',
			'setup.editComposition' => 'Composition',
			'setup.editPreferences' => 'Goûts',
			'setup.editBudget' => 'Budget et commune',
			'setup.save' => 'Enregistrer',
			'setup.chooseLead' => 'Ton ',
			'setup.chooseHighlight' => 'foyer',
			'setup.chooseSubtitle' => 'Tout le monde chez toi partage le même frigo et la même liste.',
			'setup.createTitle' => 'Créer mon foyer',
			'setup.createDetail' => 'Je suis le premier de la famille sur Mijoo.',
			'setup.joinTitle' => 'Rejoindre un foyer',
			'setup.joinDetail' => 'Quelqu’un de la famille m’a envoyé un code.',
			'setup.noCode' => 'Pas de code ? Demande à la personne qui utilise déjà Mijoo de t’en envoyer un depuis Mon compte.',
			'setup.joinLead' => 'Rejoindre ',
			'setup.joinHighlight' => 'un foyer',
			'setup.joinSubtitle' => 'Saisis le code reçu de ta famille.',
			'setup.codeLabel' => 'Code d’invitation',
			'setup.codeHint' => 'MJ-4K7Q',
			'setup.codeHelp' => 'Valable 48 heures après sa création.',
			'setup.join' => 'Rejoindre le foyer',
			'shell.home' => 'Accueil',
			'shell.fridge' => 'Frigo',
			'shell.meals' => 'Repas',
			'shell.shopping' => 'Courses',
			'shell.greeting' => 'Bonjour',
			'shell.greetingName' => ({required Object name}) => 'Bonjour ${name}',
			'shell.account' => 'Mon compte',
			'shopping.title' => 'Mes courses',
			'shopping.store' => 'Magasin',
			'shopping.stores' => 'Magasins autour de moi',
			'shopping.addHint' => 'Ajouter un article (pain, lessive…)',
			'shopping.add' => 'Ajouter à la liste',
			'shopping.manual' => 'Ajouté à la main',
			'shopping.addedBy' => ({required Object name}) => 'Ajouté par ${name}',
			'shopping.needed' => ({required Object quantity}) => 'il faut ${quantity}',
			'shopping.packed' => ({required Object count, required Object pack}) => '${count} × ${pack}',
			'shopping.packs.eggBox' => 'boîte de 6',
			'shopping.packs.butter' => 'plaquette de 250 g',
			'shopping.packs.cream' => 'brique de 20 cl',
			'shopping.packs.milk' => 'bouteille de 1 l',
			'shopping.packs.gratedCheese' => 'sachet de 200 g',
			'shopping.packs.pasta' => 'paquet de 500 g',
			'shopping.packs.rice' => 'paquet de 1 kg',
			'shopping.packs.flour' => 'paquet de 1 kg',
			'shopping.reserved' => 'Déjà dans le frigo',
			'shopping.reservedCount' => ({required Object count}) => 'réservé · ${count}',
			'shopping.reservedTag' => 'Réservé',
			'shopping.reservedFor' => ({required Object meals, required Object quantity}) => '${meals} · ${quantity}',
			'shopping.check' => ({required Object name}) => 'Cocher ${name}',
			'shopping.uncheck' => ({required Object name}) => 'Décocher ${name}',
			'shopping.emptyTitle' => 'Ta liste est vide',
			'shopping.emptyMessage' => 'Ajoute des repas à ta semaine depuis l’onglet Repas : leurs ingrédients manquants arrivent ici. Tu peux aussi ajouter un article ci-dessus.',
			'shopping.retry' => 'Réessayer',
			'shopping.quantityTitle' => 'Quantité à acheter',
			'shopping.neededExplained' => ({required Object quantity}) => 'Il faut ${quantity}.',
			'shopping.packExplained' => ({required Object quantity, required Object pack}) => 'Il faut ${quantity}. Arrondi au conditionnement : ${pack}.',
			'shopping.aisle' => 'Rayon',
			'shopping.save' => 'Enregistrer',
			'shopping.remove' => 'Retirer de la liste',
			'shopping.less' => 'Moins',
			'shopping.more' => 'Plus',
			'shopping.storeTitle' => 'Ranger dans le frigo',
			'shopping.storeMessageSingle' => '1 article coché. Ajuste ce que tu as vraiment acheté.',
			'shopping.storeMessageSeveral' => ({required Object count}) => '${count} articles cochés. Ajuste ce que tu as vraiment acheté.',
			'shopping.outsideFridge' => 'Hors frigo, retiré de la liste',
			'shopping.storeNote' => 'Les ingrédients rejoignent le frigo et quittent la liste. Ceux des repas prévus restent réservés.',
			'shopping.storeZero' => 'Retirer de la liste',
			'shopping.storeSingle' => 'Ranger 1 article',
			'shopping.storeSeveral' => ({required Object count}) => 'Ranger ${count} articles',
			'shopping.later' => 'Plus tard',
			'shopping.keepInFridge' => ({required Object name}) => 'Ranger ${name} dans le frigo',
			'shopping.skipFridge' => ({required Object name}) => 'Ne pas ranger ${name}',
			'shopping.unavailable' => 'La liste de courses n’est pas disponible pour le moment.',
			'shopping.networkFailure' => 'La connexion a échoué. Réessaie dans un instant.',
			'shopping.accessDenied' => 'Tu n’as pas accès à la liste de ce foyer.',
			'shopping.week' => ({required Object date}) => 'Semaine du ${date}',
			'shopping.expense' => 'Dépense',
			'shopping.spent' => 'Dépensé',
			'shopping.planned' => 'Panier prévu',
			'shopping.plannedRange' => ({required Object low, required Object high}) => '${low} à ${high}',
			'shopping.remaining' => ({required Object budget}) => 'Reste sur ${budget}',
			'shopping.overBudget' => ({required Object budget}) => 'Dépassé sur ${budget}',
			'shopping.noBudget' => 'Pas de budget',
			'shopping.noBudgetDetail' => 'à définir dans Mon foyer',
			'shopping.approx' => ({required Object amount}) => '≈ ${amount}',
			'shopping.unpriced' => 'Sans prix connu',
			'shopping.unpricedDetail' => 'Pas compté dans le panier',
			'shopping.addPrice' => 'Ajouter un prix',
			'shopping.reliabilities.low' => 'Prix indicatif, peu fiable',
			'shopping.reliabilities.medium' => 'Prix assez fiable',
			'shopping.reliabilities.high' => 'Prix fiable',
			'shopping.priceTitle' => 'Prix',
			'shopping.sources.household' => 'Ton prix, partagé avec le foyer',
			'shopping.sources.openPrices' => 'Open Prices',
			'shopping.sources.catalog' => 'Prix moyen indicatif Mijoo',
			'shopping.observationsSingle' => '1 relevé en France',
			'shopping.observationsSeveral' => ({required Object count}) => '${count} relevés en France',
			'shopping.lastSeen' => ({required Object date}) => 'Dernier relevé le ${date}',
			'shopping.myPrice.kilogram' => 'Mon prix au kilo',
			'shopping.myPrice.liter' => 'Mon prix au litre',
			'shopping.myPrice.piece' => 'Mon prix à la pièce',
			'shopping.myPriceHint' => 'Par exemple 1,15',
			'shopping.myPriceHelp' => 'Ton prix sert à tout le foyer et remplace l’estimation.',
			'shopping.priceUnit.kilogram' => '€/kg',
			'shopping.priceUnit.liter' => '€/l',
			'shopping.priceUnit.piece' => '€',
			'shopping.priceInvalid' => 'Saisis un prix en euros, par exemple 1,15.',
			'shopping.expenseTitle' => 'Nouvelle dépense',
			'shopping.amount' => 'Montant',
			'shopping.amountHint' => 'Par exemple 38,70',
			'shopping.amountInvalid' => 'Saisis un montant en euros, par exemple 38,70.',
			'shopping.date' => 'Date',
			'shopping.today' => 'Aujourd’hui',
			'shopping.storeHint' => 'Facultatif',
			'shopping.addExpense' => 'Ajouter la dépense',
			'shopping.thisWeek' => 'Cette semaine',
			'shopping.weekSpent' => ({required Object spent, required Object budget}) => '${spent} sur ${budget}',
			'shopping.weekSpentNoBudget' => ({required Object spent}) => '${spent} dépensés',
			'shopping.expenseBy' => ({required Object date, required Object name}) => '${date} · ${name}',
			'shopping.deleteExpense' => ({required Object amount}) => 'Supprimer la dépense de ${amount}',
			'shopping.noExpense' => 'Aucune dépense saisie cette semaine.',
			_ => null,
		} ?? switch (path) {
			'shopping.expenseDefault' => 'Courses',
			'shopping.perKilogram' => ({required Object price}) => 'soit ${price} le kilo',
			'shopping.perLiter' => ({required Object price}) => 'soit ${price} le litre',
			'shopping.perPiece' => ({required Object price}) => 'soit ${price} la pièce',
			'shopping.rangeKilogram' => ({required Object low, required Object high}) => 'de ${low} à ${high} le kilo',
			'shopping.rangeLiter' => ({required Object low, required Object high}) => 'de ${low} à ${high} le litre',
			'shopping.rangePiece' => ({required Object low, required Object high}) => 'de ${low} à ${high} la pièce',
			'stores.title' => 'Magasins autour de moi',
			'stores.list' => 'Liste',
			'stores.map' => 'Carte',
			'stores.townTitle' => ({required Object city, required Object postalCode}) => '${city} · ${postalCode}',
			'stores.townSubtitle' => 'Commune de ton foyer',
			'stores.positionTitle' => 'Ma position',
			'stores.positionSubtitle' => 'Recherche autour de toi, non enregistrée',
			'stores.usePosition' => 'Ma position',
			'stores.useTown' => 'Ma commune',
			'stores.radius.short' => '500 m',
			'stores.radius.near' => '1 km',
			'stores.radius.medium' => '2 km',
			'stores.radius.far' => '5 km',
			'stores.filters.all' => 'Tous',
			'stores.filters.supermarkets' => 'Supermarchés',
			'stores.filters.local' => 'Proximité',
			'stores.filters.bakeries' => 'Boulangeries',
			'stores.filters.markets' => 'Marchés',
			'stores.filters.specialists' => 'Spécialistes',
			'stores.kinds.supermarket' => 'Supermarché',
			'stores.kinds.convenience' => 'Supérette',
			'stores.kinds.bakery' => 'Boulangerie',
			'stores.kinds.butcher' => 'Boucherie',
			'stores.kinds.greengrocer' => 'Primeur',
			'stores.kinds.organic' => 'Magasin bio',
			'stores.kinds.cheese' => 'Fromagerie',
			'stores.kinds.frozenFood' => 'Surgelés',
			'stores.kinds.marketplace' => 'Marché',
			'stores.meters' => ({required Object meters}) => '${meters} m',
			'stores.kilometers' => ({required Object kilometers}) => '${kilometers} km',
			'stores.time' => ({required Object hours, required Object minutes}) => '${hours}:${minutes}',
			'stores.openUntil' => ({required Object time}) => 'Ouvert · ferme à ${time}',
			'stores.open' => 'Ouvert',
			'stores.closedOpensToday' => ({required Object time}) => 'Fermé · ouvre à ${time}',
			'stores.closedOpensOn' => ({required Object day, required Object time}) => 'Fermé · ouvre ${day} à ${time}',
			'stores.closed' => 'Fermé',
			'stores.hoursUnknown' => 'Horaires non renseignés',
			'stores.hoursOnSheet' => 'Horaires sur la fiche',
			'stores.days.0' => 'lundi',
			'stores.days.1' => 'mardi',
			'stores.days.2' => 'mercredi',
			'stores.days.3' => 'jeudi',
			'stores.days.4' => 'vendredi',
			'stores.days.5' => 'samedi',
			'stores.days.6' => 'dimanche',
			'stores.dayNames.0' => 'Lundi',
			'stores.dayNames.1' => 'Mardi',
			'stores.dayNames.2' => 'Mercredi',
			'stores.dayNames.3' => 'Jeudi',
			'stores.dayNames.4' => 'Vendredi',
			'stores.dayNames.5' => 'Samedi',
			'stores.dayNames.6' => 'Dimanche',
			'stores.today' => ({required Object day}) => '${day}, aujourd’hui',
			'stores.closedDay' => 'Fermé',
			'stores.range' => ({required Object start, required Object end}) => '${start} – ${end}',
			'stores.countZero' => ({required Object radius}) => 'Aucun magasin à moins de ${radius}',
			'stores.countSingle' => ({required Object radius}) => '1 magasin à moins de ${radius}',
			'stores.countSeveral' => ({required Object count, required Object radius}) => '${count} magasins à moins de ${radius}',
			'stores.emptyFilter' => 'Aucun magasin de ce type dans ce rayon. Élargis la recherche ou choisis un autre type.',
			'stores.attribution' => 'Données © contributeurs OpenStreetMap · distances à vol d’oiseau',
			'stores.mapAttribution' => 'contributeurs OpenStreetMap',
			'stores.kindAndAddress' => ({required Object kind, required Object address}) => '${kind} · ${address}',
			'stores.kindAndDistance' => ({required Object kind, required Object distance}) => '${kind} · à ${distance}',
			'stores.hours' => 'Horaires',
			'stores.directions' => 'Itinéraire',
			'stores.sheetNote' => 'Horaires et adresse issus d’OpenStreetMap, à vérifier sur place.',
			'stores.consentTitle' => 'Chercher autour de toi ?',
			'stores.consentMessage' => 'Mijoo utilise ta position seulement pour cette recherche. Elle n’est ni enregistrée ni partagée avec ton foyer.',
			'stores.consentAccept' => 'Utiliser ma position',
			'stores.consentStay' => ({required Object city}) => 'Rester sur ${city}',
			'stores.consentCancel' => 'Pas maintenant',
			'stores.consentNote' => 'Si tu refuses, la recherche par commune reste disponible.',
			'stores.noTownTitle' => 'Où chercher ?',
			'stores.noTownMessage' => 'Indique la commune de ton foyer ou utilise ta position pour voir les magasins proches.',
			'stores.noTownEdit' => 'Renseigner ma commune',
			'stores.retry' => 'Réessayer',
			'stores.searching' => 'Recherche des commerces sur OpenStreetMap, cela peut prendre jusqu’à une minute.',
			'stores.networkFailure' => 'Impossible de joindre le service des magasins. Vérifie ta connexion et réessaie.',
			'stores.busy' => 'Le service des magasins est très demandé. Réessaie dans un moment.',
			'stores.townNotFound' => 'La commune du foyer n’a pas été trouvée. Vérifie son code postal.',
			'stores.locationOff' => 'Impossible de trouver ta position. Vérifie que la localisation est activée.',
			'stores.locationDenied' => 'Mijoo n’a pas accès à ta position. Autorise-la dans les réglages, ou cherche autour de ta commune.',
			'welcome.appName' => 'Mijoo',
			'welcome.titleLead' => 'Cuisine malin\navec ',
			'welcome.titleHighlight' => 'ton frigo',
			'welcome.subtitle' => 'Mijoo te propose des repas avec ton frigo, pour toute la famille et dans ton budget.',
			_ => null,
		};
	}
}
