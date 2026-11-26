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
	late final Translations$account$fr account = Translations$account$fr._(_root);
	late final Translations$auth$fr auth = Translations$auth$fr._(_root);
	late final Translations$shell$fr shell = Translations$shell$fr._(_root);
	late final Translations$welcome$fr welcome = Translations$welcome$fr._(_root);
}

// Path: account
class Translations$account$fr {
	Translations$account$fr._(this._root);

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
	Translations$auth$fr._(this._root);

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

	/// fr: 'Une erreur est survenue. Réessaie dans un instant.'
	String get unknownFailure => 'Une erreur est survenue. Réessaie dans un instant.';

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

// Path: shell
class Translations$shell$fr {
	Translations$shell$fr._(this._root);

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
	Translations$welcome$fr._(this._root);

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
			'auth.unknownFailure' => 'Une erreur est survenue. Réessaie dans un instant.',
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
