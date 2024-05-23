/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 256 (128 per locale)
///
/// Built on 2024-05-23 at 12:41 UTC

// coverage:ignore-file
// ignore_for_file: type=lint

import 'package:flutter/widgets.dart';
import 'package:slang/builder/model/node.dart';
import 'package:slang_flutter/slang_flutter.dart';
export 'package:slang_flutter/slang_flutter.dart';

const AppLocale _baseLocale = AppLocale.en;

/// Supported locales, see extension methods below.
///
/// Usage:
/// - LocaleSettings.setLocale(AppLocale.en) // set locale
/// - Locale locale = AppLocale.en.flutterLocale // get flutter locale from enum
/// - if (LocaleSettings.currentLocale == AppLocale.en) // locale check
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
	en(languageCode: 'en', build: Translations.build),
	zh(languageCode: 'zh', build: _StringsZh.build);

	const AppLocale({required this.languageCode, this.scriptCode, this.countryCode, required this.build}); // ignore: unused_element

	@override final String languageCode;
	@override final String? scriptCode;
	@override final String? countryCode;
	@override final TranslationBuilder<AppLocale, Translations> build;

	/// Gets current instance managed by [LocaleSettings].
	Translations get translations => LocaleSettings.instance.translationMap[this]!;
}

/// Method A: Simple
///
/// No rebuild after locale change.
/// Translation happens during initialization of the widget (call of t).
/// Configurable via 'translate_var'.
///
/// Usage:
/// String a = t.someKey.anotherKey;
/// String b = t['someKey.anotherKey']; // Only for edge cases!
Translations get t => LocaleSettings.instance.currentTranslations;

/// Method B: Advanced
///
/// All widgets using this method will trigger a rebuild when locale changes.
/// Use this if you have e.g. a settings page where the user can select the locale during runtime.
///
/// Step 1:
/// wrap your App with
/// TranslationProvider(
/// 	child: MyApp()
/// );
///
/// Step 2:
/// final t = Translations.of(context); // Get t variable.
/// String a = t.someKey.anotherKey; // Use t variable.
/// String b = t['someKey.anotherKey']; // Only for edge cases!
class TranslationProvider extends BaseTranslationProvider<AppLocale, Translations> {
	TranslationProvider({required super.child}) : super(settings: LocaleSettings.instance);

	static InheritedLocaleData<AppLocale, Translations> of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context);
}

/// Method B shorthand via [BuildContext] extension method.
/// Configurable via 'translate_var'.
///
/// Usage (e.g. in a widget's build method):
/// context.t.someKey.anotherKey
extension BuildContextTranslationsExtension on BuildContext {
	Translations get t => TranslationProvider.of(this).translations;
}

/// Manages all translation instances and the current locale
class LocaleSettings extends BaseFlutterLocaleSettings<AppLocale, Translations> {
	LocaleSettings._() : super(utils: AppLocaleUtils.instance);

	static final instance = LocaleSettings._();

	// static aliases (checkout base methods for documentation)
	static AppLocale get currentLocale => instance.currentLocale;
	static Stream<AppLocale> getLocaleStream() => instance.getLocaleStream();
	static AppLocale setLocale(AppLocale locale, {bool? listenToDeviceLocale = false}) => instance.setLocale(locale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale setLocaleRaw(String rawLocale, {bool? listenToDeviceLocale = false}) => instance.setLocaleRaw(rawLocale, listenToDeviceLocale: listenToDeviceLocale);
	static AppLocale useDeviceLocale() => instance.useDeviceLocale();
	@Deprecated('Use [AppLocaleUtils.supportedLocales]') static List<Locale> get supportedLocales => instance.supportedLocales;
	@Deprecated('Use [AppLocaleUtils.supportedLocalesRaw]') static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
	static void setPluralResolver({String? language, AppLocale? locale, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver}) => instance.setPluralResolver(
		language: language,
		locale: locale,
		cardinalResolver: cardinalResolver,
		ordinalResolver: ordinalResolver,
	);
}

/// Provides utility functions without any side effects.
class AppLocaleUtils extends BaseAppLocaleUtils<AppLocale, Translations> {
	AppLocaleUtils._() : super(baseLocale: _baseLocale, locales: AppLocale.values);

	static final instance = AppLocaleUtils._();

	// static aliases (checkout base methods for documentation)
	static AppLocale parse(String rawLocale) => instance.parse(rawLocale);
	static AppLocale parseLocaleParts({required String languageCode, String? scriptCode, String? countryCode}) => instance.parseLocaleParts(languageCode: languageCode, scriptCode: scriptCode, countryCode: countryCode);
	static AppLocale findDeviceLocale() => instance.findDeviceLocale();
	static List<Locale> get supportedLocales => instance.supportedLocales;
	static List<String> get supportedLocalesRaw => instance.supportedLocalesRaw;
}

// translations

// Path: <root>
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	// Translations
	String get appName => 'Homing Pigeon';
	late final _StringsCommonEn common = _StringsCommonEn._(_root);
	late final _StringsPagesEn pages = _StringsPagesEn._(_root);
	late final _StringsButtonsEn buttons = _StringsButtonsEn._(_root);
	late final _StringsBottomSheetsEn bottomSheets = _StringsBottomSheetsEn._(_root);
	late final _StringsDialogsEn dialogs = _StringsDialogsEn._(_root);
	Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: common
class _StringsCommonEn {
	_StringsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get copied => 'Copied';
	String get success => 'Succeeded😊';
	String get failure => 'Failed😭';
	String get noData => 'No data, click to reload😭';
}

// Path: pages
class _StringsPagesEn {
	_StringsPagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesHomeEn home = _StringsPagesHomeEn._(_root);
	late final _StringsPagesEmojiEn emoji = _StringsPagesEmojiEn._(_root);
	late final _StringsPagesFeedbackEn feedback = _StringsPagesFeedbackEn._(_root);
	late final _StringsPagesFeedbackDetailEn feedbackDetail = _StringsPagesFeedbackDetailEn._(_root);
	late final _StringsPagesLiveEn live = _StringsPagesLiveEn._(_root);
	late final _StringsPagesMovieEn movie = _StringsPagesMovieEn._(_root);
	late final _StringsPagesRoadmapEn roadmap = _StringsPagesRoadmapEn._(_root);
	late final _StringsPagesSocialEn social = _StringsPagesSocialEn._(_root);
}

// Path: buttons
class _StringsButtonsEn {
	_StringsButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get agree => 'Agree';
	String get cancel => 'Cancel';
	String get login => 'Login';
	String get signup => 'Sign up';
	String get logout => 'Logout';
	String get ignore => 'Ignore';
	String get turnOn => 'Turn on';
	String get turnOff => 'Turn off';
}

// Path: bottomSheets
class _StringsBottomSheetsEn {
	_StringsBottomSheetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsBottomSheetsLoginEn login = _StringsBottomSheetsLoginEn._(_root);
	late final _StringsBottomSheetsSignupEn signup = _StringsBottomSheetsSignupEn._(_root);
	late final _StringsBottomSheetsStoreEn store = _StringsBottomSheetsStoreEn._(_root);
}

// Path: dialogs
class _StringsDialogsEn {
	_StringsDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsDialogsLicenseEn license = _StringsDialogsLicenseEn._(_root);
	late final _StringsDialogsAlbumEn album = _StringsDialogsAlbumEn._(_root);
}

// Path: pages.home
class _StringsPagesHomeEn {
	_StringsPagesHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesHomePrimaryEn primary = _StringsPagesHomePrimaryEn._(_root);
	late final _StringsPagesHomeOtherEn other = _StringsPagesHomeOtherEn._(_root);
	String get version => 'Version';
}

// Path: pages.emoji
class _StringsPagesEmojiEn {
	_StringsPagesEmojiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Emojis～';
	late final _StringsPagesEmojiTipsEn tips = _StringsPagesEmojiTipsEn._(_root);
	late final _StringsPagesEmojiDialogsEn dialogs = _StringsPagesEmojiDialogsEn._(_root);
}

// Path: pages.feedback
class _StringsPagesFeedbackEn {
	_StringsPagesFeedbackEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback';
	late final _StringsPagesFeedbackTipsEn tips = _StringsPagesFeedbackTipsEn._(_root);
	late final _StringsPagesFeedbackDialogsEn dialogs = _StringsPagesFeedbackDialogsEn._(_root);
}

// Path: pages.feedbackDetail
class _StringsPagesFeedbackDetailEn {
	_StringsPagesFeedbackDetailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback details';
}

// Path: pages.live
class _StringsPagesLiveEn {
	_StringsPagesLiveEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Live streaming～';
}

// Path: pages.movie
class _StringsPagesMovieEn {
	_StringsPagesMovieEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Movie';
}

// Path: pages.roadmap
class _StringsPagesRoadmapEn {
	_StringsPagesRoadmapEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Roadmap';
}

// Path: pages.social
class _StringsPagesSocialEn {
	_StringsPagesSocialEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Social';
}

// Path: bottomSheets.login
class _StringsBottomSheetsLoginEn {
	_StringsBottomSheetsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get header => 'Please fill in your login information';
	late final _StringsBottomSheetsLoginFormEn form = _StringsBottomSheetsLoginFormEn._(_root);
	late final _StringsBottomSheetsLoginTipsEn tips = _StringsBottomSheetsLoginTipsEn._(_root);
}

// Path: bottomSheets.signup
class _StringsBottomSheetsSignupEn {
	_StringsBottomSheetsSignupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get header => 'Please fill in the registration information';
	late final _StringsBottomSheetsSignupFormEn form = _StringsBottomSheetsSignupFormEn._(_root);
	late final _StringsBottomSheetsSignupTipsEn tips = _StringsBottomSheetsSignupTipsEn._(_root);
}

// Path: bottomSheets.store
class _StringsBottomSheetsStoreEn {
	_StringsBottomSheetsStoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Please select to continue';
	late final _StringsBottomSheetsStoreCodeEn code = _StringsBottomSheetsStoreCodeEn._(_root);
	late final _StringsBottomSheetsStoreLinkEn link = _StringsBottomSheetsStoreLinkEn._(_root);
}

// Path: dialogs.license
class _StringsDialogsLicenseEn {
	_StringsDialogsLicenseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Terms and Conditions';
	String get contentContent => 'Protecting user\'s privacy and personal information is a fundamental principle of Homing Pigeon.';
	String get contentTip => 'Below is a list of permissions required by this APP:';
	String get contentPrefix => 'Before you use this APP\'s services, please carefully read and agree to the ';
	String get contentUserAgreement => 'User Agreement';
	String get contentAnd => ' and ';
	String get contentPrivacyAgreement => 'Privacy Agreement';
	String get contentSuffix => ', start using our services after you agree and accept all terms.';
	List<String> get iosPermissions => [
		'For you to take pictures, Homing Pigeon needs access to your Camera. (NSCameraUsageDescription)',
		'For you to upload pictures, Homing Pigeon needs access to your Photos. (NSPhotoLibraryUsageDescription)',
	];
	List<String> get androidPermissions => [
		'Used for data interaction between the application and the server, Homing Pigeon needs access to your Internet. (android.permission.INTERNET)',
		'In order to send you notifications, Homing Pigeon needs access to your permission. (android.permission.POST_NOTIFICATIONS)',
		'For you to upload pictures, Homing Pigeon needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)',
		'For you to save pictures, Homing Pigeon needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)',
		'For you to upload pictures, Homing Pigeon needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)',
		'For you to upload videos, Homing Pigeon needs access to your Videos. (android.permission.READ_MEDIA_VIDEO)',
		'For you to take pictures, Homing Pigeon needs access to your Camera. (android.permission.CAMERA)',
		'In order to send you local notifications, Homing Pigeon needs access to your permission. (android.permission.RECEIVE_BOOT_COMPLETED)',
	];
}

// Path: dialogs.album
class _StringsDialogsAlbumEn {
	_StringsDialogsAlbumEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Allow access to your album';
	String get description => 'Please go to your phone Settings to grant Homing Pigeon the permission to visit your album.';
}

// Path: pages.home.primary
class _StringsPagesHomePrimaryEn {
	_StringsPagesHomePrimaryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Primary';
	late final _StringsPagesHomePrimaryRatingEn rating = _StringsPagesHomePrimaryRatingEn._(_root);
	late final _StringsPagesHomePrimaryLiveEn live = _StringsPagesHomePrimaryLiveEn._(_root);
	late final _StringsPagesHomePrimarySettingsEn settings = _StringsPagesHomePrimarySettingsEn._(_root);
}

// Path: pages.home.other
class _StringsPagesHomeOtherEn {
	_StringsPagesHomeOtherEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Others';
	late final _StringsPagesHomeOtherNotificationsEn notifications = _StringsPagesHomeOtherNotificationsEn._(_root);
	late final _StringsPagesHomeOtherStoreEn store = _StringsPagesHomeOtherStoreEn._(_root);
	late final _StringsPagesHomeOtherEmojiEn emoji = _StringsPagesHomeOtherEmojiEn._(_root);
	late final _StringsPagesHomeOtherFeedbackEn feedback = _StringsPagesHomeOtherFeedbackEn._(_root);
	late final _StringsPagesHomeOtherRoadmapEn roadmap = _StringsPagesHomeOtherRoadmapEn._(_root);
}

// Path: pages.emoji.tips
class _StringsPagesEmojiTipsEn {
	_StringsPagesEmojiTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Contributions are welcome, Wow~';
	String get prefix => 'Welcome';
	String get button => ' [click here] ';
	String get suffix => 'to contribute, it can be emoticons, creative copywriting, or some embarrassing pictures or screenshots of cats, etc.😄';
}

// Path: pages.emoji.dialogs
class _StringsPagesEmojiDialogsEn {
	_StringsPagesEmojiDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesEmojiDialogsUploadEn upload = _StringsPagesEmojiDialogsUploadEn._(_root);
}

// Path: pages.feedback.tips
class _StringsPagesFeedbackTipsEn {
	_StringsPagesFeedbackTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Comments or suggestions are welcome, wow~';
	String get prefix => 'No matter you encounter any questions, comments or suggestions, you can';
	String get button => ' [click here] ';
	String get suffix => 'to give feedback.';
}

// Path: pages.feedback.dialogs
class _StringsPagesFeedbackDialogsEn {
	_StringsPagesFeedbackDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesFeedbackDialogsUploadEn upload = _StringsPagesFeedbackDialogsUploadEn._(_root);
}

// Path: bottomSheets.login.form
class _StringsBottomSheetsLoginFormEn {
	_StringsBottomSheetsLoginFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsBottomSheetsLoginFormAccountEn account = _StringsBottomSheetsLoginFormAccountEn._(_root);
	late final _StringsBottomSheetsLoginFormPasswordEn password = _StringsBottomSheetsLoginFormPasswordEn._(_root);
	late final _StringsBottomSheetsLoginFormPrivacyEn privacy = _StringsBottomSheetsLoginFormPrivacyEn._(_root);
}

// Path: bottomSheets.login.tips
class _StringsBottomSheetsLoginTipsEn {
	_StringsBottomSheetsLoginTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get prefix => 'Already have an account, ';
	String get suffix => 'go to login';
}

// Path: bottomSheets.signup.form
class _StringsBottomSheetsSignupFormEn {
	_StringsBottomSheetsSignupFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsBottomSheetsSignupFormAccountEn account = _StringsBottomSheetsSignupFormAccountEn._(_root);
	late final _StringsBottomSheetsSignupFormNicknameEn nickname = _StringsBottomSheetsSignupFormNicknameEn._(_root);
	late final _StringsBottomSheetsSignupFormEmailEn email = _StringsBottomSheetsSignupFormEmailEn._(_root);
	late final _StringsBottomSheetsSignupFormPasswordEn password = _StringsBottomSheetsSignupFormPasswordEn._(_root);
	late final _StringsBottomSheetsSignupFormRepeatPasswordEn repeatPassword = _StringsBottomSheetsSignupFormRepeatPasswordEn._(_root);
}

// Path: bottomSheets.signup.tips
class _StringsBottomSheetsSignupTipsEn {
	_StringsBottomSheetsSignupTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get prefix => 'No account yet, ';
	String get suffix => 'go to register';
}

// Path: bottomSheets.store.code
class _StringsBottomSheetsStoreCodeEn {
	_StringsBottomSheetsStoreCodeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Copy Taobao code';
	String get description => 'Get the live broadcast platform, time, etc.';
}

// Path: bottomSheets.store.link
class _StringsBottomSheetsStoreLinkEn {
	_StringsBottomSheetsStoreLinkEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Open store link';
	String get description => 'The cold wave is coming! Bring on a sweatshirt~~';
}

// Path: pages.home.primary.rating
class _StringsPagesHomePrimaryRatingEn {
	_StringsPagesHomePrimaryRatingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Movie rating';
	String get description => 'Rate the movies you’ve watched~~';
}

// Path: pages.home.primary.live
class _StringsPagesHomePrimaryLiveEn {
	_StringsPagesHomePrimaryLiveEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Live broadcast preview';
	String get description => 'Go to the details';
}

// Path: pages.home.primary.settings
class _StringsPagesHomePrimarySettingsEn {
	_StringsPagesHomePrimarySettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
}

// Path: pages.home.other.notifications
class _StringsPagesHomeOtherNotificationsEn {
	_StringsPagesHomeOtherNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Reminders';
	String get description => 'Get the live broadcast platform, time, etc.';
}

// Path: pages.home.other.store
class _StringsPagesHomeOtherStoreEn {
	_StringsPagesHomeOtherStoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'TAOBAO: Serious';
	String get description => 'The cold wave is coming! Bring on a sweatshirt~~';
}

// Path: pages.home.other.emoji
class _StringsPagesHomeOtherEmojiEn {
	_StringsPagesHomeOtherEmojiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Emojis🐱';
	String get description => 'Contributions welcome~~';
}

// Path: pages.home.other.feedback
class _StringsPagesHomeOtherFeedbackEn {
	_StringsPagesHomeOtherFeedbackEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback';
	String get description => 'No matter you encounter any questions, comments or suggestions, you can give us feedback...';
}

// Path: pages.home.other.roadmap
class _StringsPagesHomeOtherRoadmapEn {
	_StringsPagesHomeOtherRoadmapEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Roadmap';
	String get description => 'View development plans and progress😄';
}

// Path: pages.emoji.dialogs.upload
class _StringsPagesEmojiDialogsUploadEn {
	_StringsPagesEmojiDialogsUploadEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesEmojiDialogsUploadButtonsEn buttons = _StringsPagesEmojiDialogsUploadButtonsEn._(_root);
	String get header => 'Please select emojis you want to upload';
	late final _StringsPagesEmojiDialogsUploadTipsEn tips = _StringsPagesEmojiDialogsUploadTipsEn._(_root);
	late final _StringsPagesEmojiDialogsUploadFormEn form = _StringsPagesEmojiDialogsUploadFormEn._(_root);
	String get uploadFailed => 'File upload failed😭';
}

// Path: pages.feedback.dialogs.upload
class _StringsPagesFeedbackDialogsUploadEn {
	_StringsPagesFeedbackDialogsUploadEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesFeedbackDialogsUploadButtonsEn buttons = _StringsPagesFeedbackDialogsUploadButtonsEn._(_root);
	String get header => 'Please fill in the feedback info';
	late final _StringsPagesFeedbackDialogsUploadFormEn form = _StringsPagesFeedbackDialogsUploadFormEn._(_root);
	late final _StringsPagesFeedbackDialogsUploadErrorEn error = _StringsPagesFeedbackDialogsUploadErrorEn._(_root);
	String get uploadFailed => '文件上传失败😭';
}

// Path: bottomSheets.login.form.account
class _StringsBottomSheetsLoginFormAccountEn {
	_StringsBottomSheetsLoginFormAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Account';
	String get hintText => 'Please enter your account';
	String get errorText => 'Please enter your account';
	String get errorText2 => 'Please enter at least 8 characters';
}

// Path: bottomSheets.login.form.password
class _StringsBottomSheetsLoginFormPasswordEn {
	_StringsBottomSheetsLoginFormPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Password';
	String get hintText => 'Please enter your password';
	String get errorText => 'Please enter your password';
	String get errorText2 => 'Please enter at least 8 characters';
}

// Path: bottomSheets.login.form.privacy
class _StringsBottomSheetsLoginFormPrivacyEn {
	_StringsBottomSheetsLoginFormPrivacyEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Privacy';
	String get prefix => 'I have read carefully and agree';
	String get privacy => ' Privacy Policy ';
	String get and => '&';
	String get terms => ' terms and Conditions';
	String get errorText => 'Please agree to the privacy agreement';
}

// Path: bottomSheets.signup.form.account
class _StringsBottomSheetsSignupFormAccountEn {
	_StringsBottomSheetsSignupFormAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get helperText => 'The account number can only contain letters, numbers or underscores, and can only start with a letter and be at least 8 characters long.';
	String get errorText2 => 'The account number can only contain letters, numbers or underscores, and can only start with a letter and be at least 8 characters long.';
}

// Path: bottomSheets.signup.form.nickname
class _StringsBottomSheetsSignupFormNicknameEn {
	_StringsBottomSheetsSignupFormNicknameEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Nickname';
	String get hintText => 'Please enter your nickname';
	String get helperText => 'Nickname cannot be longer than 20 characters';
	String get errorText => 'Nickname cannot be longer than 20 characters';
}

// Path: bottomSheets.signup.form.email
class _StringsBottomSheetsSignupFormEmailEn {
	_StringsBottomSheetsSignupFormEmailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Email';
	String get hintText => 'Please enter your email';
	String get errorText => 'Please enter your email';
	String get errorText2 => 'The email format you entered is wrong';
}

// Path: bottomSheets.signup.form.password
class _StringsBottomSheetsSignupFormPasswordEn {
	_StringsBottomSheetsSignupFormPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get helperText => 'Please enter at least 8 characters';
}

// Path: bottomSheets.signup.form.repeatPassword
class _StringsBottomSheetsSignupFormRepeatPasswordEn {
	_StringsBottomSheetsSignupFormRepeatPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Repeat password';
	String get hintText => 'Please enter your password again';
	String get errorText => 'Please enter your password again';
	String get errorText2 => 'The passwords entered twice are different';
}

// Path: pages.emoji.dialogs.upload.buttons
class _StringsPagesEmojiDialogsUploadButtonsEn {
	_StringsPagesEmojiDialogsUploadButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get upload => 'Upload';
}

// Path: pages.emoji.dialogs.upload.tips
class _StringsPagesEmojiDialogsUploadTipsEn {
	_StringsPagesEmojiDialogsUploadTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get prefix => 'You can upload up to 9 images';
	String get suffix => 'Image size must be between 50KB and 15MB';
}

// Path: pages.emoji.dialogs.upload.form
class _StringsPagesEmojiDialogsUploadFormEn {
	_StringsPagesEmojiDialogsUploadFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesEmojiDialogsUploadFormEmojisEn emojis = _StringsPagesEmojiDialogsUploadFormEmojisEn._(_root);
}

// Path: pages.feedback.dialogs.upload.buttons
class _StringsPagesFeedbackDialogsUploadButtonsEn {
	_StringsPagesFeedbackDialogsUploadButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get upload => 'Submit';
}

// Path: pages.feedback.dialogs.upload.form
class _StringsPagesFeedbackDialogsUploadFormEn {
	_StringsPagesFeedbackDialogsUploadFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesFeedbackDialogsUploadFormTitleEn title = _StringsPagesFeedbackDialogsUploadFormTitleEn._(_root);
	late final _StringsPagesFeedbackDialogsUploadFormDescriptionEn description = _StringsPagesFeedbackDialogsUploadFormDescriptionEn._(_root);
	late final _StringsPagesFeedbackDialogsUploadFormAssetsEn assets = _StringsPagesFeedbackDialogsUploadFormAssetsEn._(_root);
}

// Path: pages.feedback.dialogs.upload.error
class _StringsPagesFeedbackDialogsUploadErrorEn {
	_StringsPagesFeedbackDialogsUploadErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get image => 'Uploaded images must be between 15KB and 15MB';
	String get video => 'Uploaded videos must be between 15KB and 15MB';
}

// Path: pages.emoji.dialogs.upload.form.emojis
class _StringsPagesEmojiDialogsUploadFormEmojisEn {
	_StringsPagesEmojiDialogsUploadFormEmojisEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get errorText => 'Please select emojis you want to upload';
}

// Path: pages.feedback.dialogs.upload.form.title
class _StringsPagesFeedbackDialogsUploadFormTitleEn {
	_StringsPagesFeedbackDialogsUploadFormTitleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Title';
	String get hintText => 'Please enter a title';
	String get errorText => 'Please enter a title';
}

// Path: pages.feedback.dialogs.upload.form.description
class _StringsPagesFeedbackDialogsUploadFormDescriptionEn {
	_StringsPagesFeedbackDialogsUploadFormDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Description';
	String get hintText => 'Please enter a description';
	String get errorText => 'Please enter a description';
}

// Path: pages.feedback.dialogs.upload.form.assets
class _StringsPagesFeedbackDialogsUploadFormAssetsEn {
	_StringsPagesFeedbackDialogsUploadFormAssetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Picture or video';
	String get prefix => 'You can upload up to 9 pictures or videos';
	String get suffix => 'Image size must be between 50KB and 15MB, video size must be between 50KB and 20MB';
}

// Path: <root>
class _StringsZh implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	_StringsZh.build({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	@override late final _StringsZh _root = this; // ignore: unused_field

	// Translations
	@override String get appName => '信鸽';
	@override late final _StringsCommonZh common = _StringsCommonZh._(_root);
	@override late final _StringsPagesZh pages = _StringsPagesZh._(_root);
	@override late final _StringsButtonsZh buttons = _StringsButtonsZh._(_root);
	@override late final _StringsBottomSheetsZh bottomSheets = _StringsBottomSheetsZh._(_root);
	@override late final _StringsDialogsZh dialogs = _StringsDialogsZh._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: common
class _StringsCommonZh implements _StringsCommonEn {
	_StringsCommonZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get copied => '已复制';
	@override String get success => '成功啦😊';
	@override String get failure => '失败啦😭';
	@override String get noData => '没有数据, 点击以重新加载😭';
}

// Path: pages
class _StringsPagesZh implements _StringsPagesEn {
	_StringsPagesZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesHomeZh home = _StringsPagesHomeZh._(_root);
	@override late final _StringsPagesEmojiZh emoji = _StringsPagesEmojiZh._(_root);
	@override late final _StringsPagesFeedbackZh feedback = _StringsPagesFeedbackZh._(_root);
	@override late final _StringsPagesFeedbackDetailZh feedbackDetail = _StringsPagesFeedbackDetailZh._(_root);
	@override late final _StringsPagesLiveZh live = _StringsPagesLiveZh._(_root);
	@override late final _StringsPagesMovieZh movie = _StringsPagesMovieZh._(_root);
	@override late final _StringsPagesRoadmapZh roadmap = _StringsPagesRoadmapZh._(_root);
	@override late final _StringsPagesSocialZh social = _StringsPagesSocialZh._(_root);
}

// Path: buttons
class _StringsButtonsZh implements _StringsButtonsEn {
	_StringsButtonsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get agree => '同意';
	@override String get cancel => '再想想';
	@override String get login => '登录';
	@override String get signup => '注册';
	@override String get logout => '退出';
	@override String get ignore => '忽略';
	@override String get turnOn => '开启';
	@override String get turnOff => '关闭';
}

// Path: bottomSheets
class _StringsBottomSheetsZh implements _StringsBottomSheetsEn {
	_StringsBottomSheetsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsBottomSheetsLoginZh login = _StringsBottomSheetsLoginZh._(_root);
	@override late final _StringsBottomSheetsSignupZh signup = _StringsBottomSheetsSignupZh._(_root);
	@override late final _StringsBottomSheetsStoreZh store = _StringsBottomSheetsStoreZh._(_root);
}

// Path: dialogs
class _StringsDialogsZh implements _StringsDialogsEn {
	_StringsDialogsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsDialogsLicenseZh license = _StringsDialogsLicenseZh._(_root);
	@override late final _StringsDialogsAlbumZh album = _StringsDialogsAlbumZh._(_root);
}

// Path: pages.home
class _StringsPagesHomeZh implements _StringsPagesHomeEn {
	_StringsPagesHomeZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesHomePrimaryZh primary = _StringsPagesHomePrimaryZh._(_root);
	@override late final _StringsPagesHomeOtherZh other = _StringsPagesHomeOtherZh._(_root);
	@override String get version => '版本号';
}

// Path: pages.emoji
class _StringsPagesEmojiZh implements _StringsPagesEmojiEn {
	_StringsPagesEmojiZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '表情库～';
	@override late final _StringsPagesEmojiTipsZh tips = _StringsPagesEmojiTipsZh._(_root);
	@override late final _StringsPagesEmojiDialogsZh dialogs = _StringsPagesEmojiDialogsZh._(_root);
}

// Path: pages.feedback
class _StringsPagesFeedbackZh implements _StringsPagesFeedbackEn {
	_StringsPagesFeedbackZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '意见或建议';
	@override late final _StringsPagesFeedbackTipsZh tips = _StringsPagesFeedbackTipsZh._(_root);
	@override late final _StringsPagesFeedbackDialogsZh dialogs = _StringsPagesFeedbackDialogsZh._(_root);
}

// Path: pages.feedbackDetail
class _StringsPagesFeedbackDetailZh implements _StringsPagesFeedbackDetailEn {
	_StringsPagesFeedbackDetailZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '反馈详情';
}

// Path: pages.live
class _StringsPagesLiveZh implements _StringsPagesLiveEn {
	_StringsPagesLiveZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '直播～';
}

// Path: pages.movie
class _StringsPagesMovieZh implements _StringsPagesMovieEn {
	_StringsPagesMovieZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '电影';
}

// Path: pages.roadmap
class _StringsPagesRoadmapZh implements _StringsPagesRoadmapEn {
	_StringsPagesRoadmapZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '路线图';
}

// Path: pages.social
class _StringsPagesSocialZh implements _StringsPagesSocialEn {
	_StringsPagesSocialZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '社交';
}

// Path: bottomSheets.login
class _StringsBottomSheetsLoginZh implements _StringsBottomSheetsLoginEn {
	_StringsBottomSheetsLoginZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get header => '请填写登录信息';
	@override late final _StringsBottomSheetsLoginFormZh form = _StringsBottomSheetsLoginFormZh._(_root);
	@override late final _StringsBottomSheetsLoginTipsZh tips = _StringsBottomSheetsLoginTipsZh._(_root);
}

// Path: bottomSheets.signup
class _StringsBottomSheetsSignupZh implements _StringsBottomSheetsSignupEn {
	_StringsBottomSheetsSignupZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get header => '请填写注册信息';
	@override late final _StringsBottomSheetsSignupFormZh form = _StringsBottomSheetsSignupFormZh._(_root);
	@override late final _StringsBottomSheetsSignupTipsZh tips = _StringsBottomSheetsSignupTipsZh._(_root);
}

// Path: bottomSheets.store
class _StringsBottomSheetsStoreZh implements _StringsBottomSheetsStoreEn {
	_StringsBottomSheetsStoreZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '请选择您的操作';
	@override late final _StringsBottomSheetsStoreCodeZh code = _StringsBottomSheetsStoreCodeZh._(_root);
	@override late final _StringsBottomSheetsStoreLinkZh link = _StringsBottomSheetsStoreLinkZh._(_root);
}

// Path: dialogs.license
class _StringsDialogsLicenseZh implements _StringsDialogsLicenseEn {
	_StringsDialogsLicenseZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '隐私条款';
	@override String get contentContent => '信鸽 非常重视你的隐私保护和个人信息保护.';
	@override String get contentTip => '以下是该APP所需的权限列表:';
	@override String get contentPrefix => '在使用APP服务前，请认真阅读 ';
	@override String get contentUserAgreement => '《隐私政策》';
	@override String get contentAnd => '和';
	@override String get contentPrivacyAgreement => '《用户服务协议》';
	@override String get contentSuffix => ', 你同意并接受全部条款后开始使用我们的服务.';
	@override List<String> get iosPermissions => [
		'为了让您拍摄照片, 信鸽 需要访问您的相机. (NSCameraUsageDescription)',
		'为了让您上传图片, 信鸽 需要访问您的照片. (NSPhotoLibraryUsageDescription)',
	];
	@override List<String> get androidPermissions => [
		'用于应用程序和服务器之间的数据交互，信鸽 需要访问您的互联网. (android.permission.INTERNET)',
		'为了给您发送通知, 信鸽 需要获取您的权限. (android.permission.POST_NOTIFICATIONS)',
		'为了让您上传图片, 信鸽 需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)',
		'为了让您保存图片, 信鸽 需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)',
		'为了让您上传图片, 信鸽 需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)',
		'为了让您上传视频, 信鸽 需要访问您的视频. (android.permission.READ_MEDIA_VIDEO)',
		'为了让您拍摄照片, 信鸽 需要访问您的相机. (android.permission.CAMERA)',
		'为了向您发送本地通知, 信鸽 需要访问您的权限. (android.permission.RECEIVE_BOOT_COMPLETED)',
	];
}

// Path: dialogs.album
class _StringsDialogsAlbumZh implements _StringsDialogsAlbumEn {
	_StringsDialogsAlbumZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问您的相册';
	@override String get description => '请前往您的手机设置授予信鸽访问您相册的权限.';
}

// Path: pages.home.primary
class _StringsPagesHomePrimaryZh implements _StringsPagesHomePrimaryEn {
	_StringsPagesHomePrimaryZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '主要功能';
	@override late final _StringsPagesHomePrimaryRatingZh rating = _StringsPagesHomePrimaryRatingZh._(_root);
	@override late final _StringsPagesHomePrimaryLiveZh live = _StringsPagesHomePrimaryLiveZh._(_root);
	@override late final _StringsPagesHomePrimarySettingsZh settings = _StringsPagesHomePrimarySettingsZh._(_root);
}

// Path: pages.home.other
class _StringsPagesHomeOtherZh implements _StringsPagesHomeOtherEn {
	_StringsPagesHomeOtherZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '其他功能';
	@override late final _StringsPagesHomeOtherNotificationsZh notifications = _StringsPagesHomeOtherNotificationsZh._(_root);
	@override late final _StringsPagesHomeOtherStoreZh store = _StringsPagesHomeOtherStoreZh._(_root);
	@override late final _StringsPagesHomeOtherEmojiZh emoji = _StringsPagesHomeOtherEmojiZh._(_root);
	@override late final _StringsPagesHomeOtherFeedbackZh feedback = _StringsPagesHomeOtherFeedbackZh._(_root);
	@override late final _StringsPagesHomeOtherRoadmapZh roadmap = _StringsPagesHomeOtherRoadmapZh._(_root);
}

// Path: pages.emoji.tips
class _StringsPagesEmojiTipsZh implements _StringsPagesEmojiTipsEn {
	_StringsPagesEmojiTipsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '欢迎投稿，嗷呜~';
	@override String get prefix => '欢迎';
	@override String get button => ' [点击此处] ';
	@override String get suffix => '投稿，可以是表情包，可以是文案创意，也可以是一些令猫尴尬的图片或截图等~😄';
}

// Path: pages.emoji.dialogs
class _StringsPagesEmojiDialogsZh implements _StringsPagesEmojiDialogsEn {
	_StringsPagesEmojiDialogsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesEmojiDialogsUploadZh upload = _StringsPagesEmojiDialogsUploadZh._(_root);
}

// Path: pages.feedback.tips
class _StringsPagesFeedbackTipsZh implements _StringsPagesFeedbackTipsEn {
	_StringsPagesFeedbackTipsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '欢迎提意见或建议，嗷呜~';
	@override String get prefix => '无论您遇到任何问题、意见或建议，均可';
	@override String get button => ' [点击此处] ';
	@override String get suffix => '进行反馈.';
}

// Path: pages.feedback.dialogs
class _StringsPagesFeedbackDialogsZh implements _StringsPagesFeedbackDialogsEn {
	_StringsPagesFeedbackDialogsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesFeedbackDialogsUploadZh upload = _StringsPagesFeedbackDialogsUploadZh._(_root);
}

// Path: bottomSheets.login.form
class _StringsBottomSheetsLoginFormZh implements _StringsBottomSheetsLoginFormEn {
	_StringsBottomSheetsLoginFormZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsBottomSheetsLoginFormAccountZh account = _StringsBottomSheetsLoginFormAccountZh._(_root);
	@override late final _StringsBottomSheetsLoginFormPasswordZh password = _StringsBottomSheetsLoginFormPasswordZh._(_root);
	@override late final _StringsBottomSheetsLoginFormPrivacyZh privacy = _StringsBottomSheetsLoginFormPrivacyZh._(_root);
}

// Path: bottomSheets.login.tips
class _StringsBottomSheetsLoginTipsZh implements _StringsBottomSheetsLoginTipsEn {
	_StringsBottomSheetsLoginTipsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get prefix => '已有账号, ';
	@override String get suffix => '去登录';
}

// Path: bottomSheets.signup.form
class _StringsBottomSheetsSignupFormZh implements _StringsBottomSheetsSignupFormEn {
	_StringsBottomSheetsSignupFormZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsBottomSheetsSignupFormAccountZh account = _StringsBottomSheetsSignupFormAccountZh._(_root);
	@override late final _StringsBottomSheetsSignupFormNicknameZh nickname = _StringsBottomSheetsSignupFormNicknameZh._(_root);
	@override late final _StringsBottomSheetsSignupFormEmailZh email = _StringsBottomSheetsSignupFormEmailZh._(_root);
	@override late final _StringsBottomSheetsSignupFormPasswordZh password = _StringsBottomSheetsSignupFormPasswordZh._(_root);
	@override late final _StringsBottomSheetsSignupFormRepeatPasswordZh repeatPassword = _StringsBottomSheetsSignupFormRepeatPasswordZh._(_root);
}

// Path: bottomSheets.signup.tips
class _StringsBottomSheetsSignupTipsZh implements _StringsBottomSheetsSignupTipsEn {
	_StringsBottomSheetsSignupTipsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get prefix => '还没有账号, ';
	@override String get suffix => '去注册';
}

// Path: bottomSheets.store.code
class _StringsBottomSheetsStoreCodeZh implements _StringsBottomSheetsStoreCodeEn {
	_StringsBottomSheetsStoreCodeZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '复制淘口令';
	@override String get description => '直播平台、时间等';
}

// Path: bottomSheets.store.link
class _StringsBottomSheetsStoreLinkZh implements _StringsBottomSheetsStoreLinkEn {
	_StringsBottomSheetsStoreLinkZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '打开淘宝店地址';
	@override String get description => '寒潮啦! 来件卫衣吧~~';
}

// Path: pages.home.primary.rating
class _StringsPagesHomePrimaryRatingZh implements _StringsPagesHomePrimaryRatingEn {
	_StringsPagesHomePrimaryRatingZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '电影打分系统';
	@override String get description => '给看过的电影打个分吧~~';
}

// Path: pages.home.primary.live
class _StringsPagesHomePrimaryLiveZh implements _StringsPagesHomePrimaryLiveEn {
	_StringsPagesHomePrimaryLiveZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '直播预告';
	@override String get description => '查看详情';
}

// Path: pages.home.primary.settings
class _StringsPagesHomePrimarySettingsZh implements _StringsPagesHomePrimarySettingsEn {
	_StringsPagesHomePrimarySettingsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '开播通知设置';
}

// Path: pages.home.other.notifications
class _StringsPagesHomeOtherNotificationsZh implements _StringsPagesHomeOtherNotificationsEn {
	_StringsPagesHomeOtherNotificationsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '直播信息/提醒群';
	@override String get description => '直播平台、时间等';
}

// Path: pages.home.other.store
class _StringsPagesHomeOtherStoreZh implements _StringsPagesHomeOtherStoreEn {
	_StringsPagesHomeOtherStoreZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '小德官方店: 喜瑞斯';
	@override String get description => '寒潮啦! 来件卫衣吧~~';
}

// Path: pages.home.other.emoji
class _StringsPagesHomeOtherEmojiZh implements _StringsPagesHomeOtherEmojiEn {
	_StringsPagesHomeOtherEmojiZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '小德表情包🐱';
	@override String get description => '欢迎投稿~~';
}

// Path: pages.home.other.feedback
class _StringsPagesHomeOtherFeedbackZh implements _StringsPagesHomeOtherFeedbackEn {
	_StringsPagesHomeOtherFeedbackZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '意见/建议';
	@override String get description => '无论您遇到任何问题、意见或建议, 均可反馈...';
}

// Path: pages.home.other.roadmap
class _StringsPagesHomeOtherRoadmapZh implements _StringsPagesHomeOtherRoadmapEn {
	_StringsPagesHomeOtherRoadmapZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '路线图';
	@override String get description => '查看开发计划和进度😄';
}

// Path: pages.emoji.dialogs.upload
class _StringsPagesEmojiDialogsUploadZh implements _StringsPagesEmojiDialogsUploadEn {
	_StringsPagesEmojiDialogsUploadZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesEmojiDialogsUploadButtonsZh buttons = _StringsPagesEmojiDialogsUploadButtonsZh._(_root);
	@override String get header => '请选择要上传的表情';
	@override late final _StringsPagesEmojiDialogsUploadTipsZh tips = _StringsPagesEmojiDialogsUploadTipsZh._(_root);
	@override late final _StringsPagesEmojiDialogsUploadFormZh form = _StringsPagesEmojiDialogsUploadFormZh._(_root);
	@override String get uploadFailed => '文件上传失败😭';
}

// Path: pages.feedback.dialogs.upload
class _StringsPagesFeedbackDialogsUploadZh implements _StringsPagesFeedbackDialogsUploadEn {
	_StringsPagesFeedbackDialogsUploadZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesFeedbackDialogsUploadButtonsZh buttons = _StringsPagesFeedbackDialogsUploadButtonsZh._(_root);
	@override String get header => '请填写反馈内容';
	@override late final _StringsPagesFeedbackDialogsUploadFormZh form = _StringsPagesFeedbackDialogsUploadFormZh._(_root);
	@override late final _StringsPagesFeedbackDialogsUploadErrorZh error = _StringsPagesFeedbackDialogsUploadErrorZh._(_root);
	@override String get uploadFailed => '文件上传失败😭';
}

// Path: bottomSheets.login.form.account
class _StringsBottomSheetsLoginFormAccountZh implements _StringsBottomSheetsLoginFormAccountEn {
	_StringsBottomSheetsLoginFormAccountZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '账号';
	@override String get hintText => '请输入账号';
	@override String get errorText => '请输入账号';
	@override String get errorText2 => '请输入至少8个字符';
}

// Path: bottomSheets.login.form.password
class _StringsBottomSheetsLoginFormPasswordZh implements _StringsBottomSheetsLoginFormPasswordEn {
	_StringsBottomSheetsLoginFormPasswordZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '密码';
	@override String get hintText => '请输入密码';
	@override String get errorText => '请输入密码';
	@override String get errorText2 => '请输入至少8个字符';
}

// Path: bottomSheets.login.form.privacy
class _StringsBottomSheetsLoginFormPrivacyZh implements _StringsBottomSheetsLoginFormPrivacyEn {
	_StringsBottomSheetsLoginFormPrivacyZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '隐私协议';
	@override String get prefix => '我已仔细阅读并同意';
	@override String get privacy => '隐私政策';
	@override String get and => '以及';
	@override String get terms => '条款和条件';
	@override String get errorText => '请同意隐私协议';
}

// Path: bottomSheets.signup.form.account
class _StringsBottomSheetsSignupFormAccountZh implements _StringsBottomSheetsSignupFormAccountEn {
	_StringsBottomSheetsSignupFormAccountZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get helperText => '只能包含英文, 数字或下划线, 且只能以字母开头, 至少8个字符';
	@override String get errorText2 => '账号只能包含英文,数字或下划线, 且只能以字母开头, 至少8个字符';
}

// Path: bottomSheets.signup.form.nickname
class _StringsBottomSheetsSignupFormNicknameZh implements _StringsBottomSheetsSignupFormNicknameEn {
	_StringsBottomSheetsSignupFormNicknameZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '昵称';
	@override String get hintText => '请输入昵称';
	@override String get helperText => '不能多于20个字符';
	@override String get errorText => '昵称长度不能大于20';
}

// Path: bottomSheets.signup.form.email
class _StringsBottomSheetsSignupFormEmailZh implements _StringsBottomSheetsSignupFormEmailEn {
	_StringsBottomSheetsSignupFormEmailZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '邮箱';
	@override String get hintText => '请输入邮箱';
	@override String get errorText => '请输入邮箱';
	@override String get errorText2 => '邮箱格式错误';
}

// Path: bottomSheets.signup.form.password
class _StringsBottomSheetsSignupFormPasswordZh implements _StringsBottomSheetsSignupFormPasswordEn {
	_StringsBottomSheetsSignupFormPasswordZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get helperText => '请输入至少8个字符';
}

// Path: bottomSheets.signup.form.repeatPassword
class _StringsBottomSheetsSignupFormRepeatPasswordZh implements _StringsBottomSheetsSignupFormRepeatPasswordEn {
	_StringsBottomSheetsSignupFormRepeatPasswordZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '账号';
	@override String get hintText => '请再次输入密码';
	@override String get errorText => '请再次输入密码';
	@override String get errorText2 => '两次输入的密码不一样';
}

// Path: pages.emoji.dialogs.upload.buttons
class _StringsPagesEmojiDialogsUploadButtonsZh implements _StringsPagesEmojiDialogsUploadButtonsEn {
	_StringsPagesEmojiDialogsUploadButtonsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get upload => '上传';
}

// Path: pages.emoji.dialogs.upload.tips
class _StringsPagesEmojiDialogsUploadTipsZh implements _StringsPagesEmojiDialogsUploadTipsEn {
	_StringsPagesEmojiDialogsUploadTipsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get prefix => '您最多可以上传9张图片';
	@override String get suffix => '图片大小必须在50KB到15MB之间';
}

// Path: pages.emoji.dialogs.upload.form
class _StringsPagesEmojiDialogsUploadFormZh implements _StringsPagesEmojiDialogsUploadFormEn {
	_StringsPagesEmojiDialogsUploadFormZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesEmojiDialogsUploadFormEmojisZh emojis = _StringsPagesEmojiDialogsUploadFormEmojisZh._(_root);
}

// Path: pages.feedback.dialogs.upload.buttons
class _StringsPagesFeedbackDialogsUploadButtonsZh implements _StringsPagesFeedbackDialogsUploadButtonsEn {
	_StringsPagesFeedbackDialogsUploadButtonsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get upload => '提交';
}

// Path: pages.feedback.dialogs.upload.form
class _StringsPagesFeedbackDialogsUploadFormZh implements _StringsPagesFeedbackDialogsUploadFormEn {
	_StringsPagesFeedbackDialogsUploadFormZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesFeedbackDialogsUploadFormTitleZh title = _StringsPagesFeedbackDialogsUploadFormTitleZh._(_root);
	@override late final _StringsPagesFeedbackDialogsUploadFormDescriptionZh description = _StringsPagesFeedbackDialogsUploadFormDescriptionZh._(_root);
	@override late final _StringsPagesFeedbackDialogsUploadFormAssetsZh assets = _StringsPagesFeedbackDialogsUploadFormAssetsZh._(_root);
}

// Path: pages.feedback.dialogs.upload.error
class _StringsPagesFeedbackDialogsUploadErrorZh implements _StringsPagesFeedbackDialogsUploadErrorEn {
	_StringsPagesFeedbackDialogsUploadErrorZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get image => '上传的图片必须在15KB至15MB之间';
	@override String get video => '上传的视频必须在15KB至20MB之间';
}

// Path: pages.emoji.dialogs.upload.form.emojis
class _StringsPagesEmojiDialogsUploadFormEmojisZh implements _StringsPagesEmojiDialogsUploadFormEmojisEn {
	_StringsPagesEmojiDialogsUploadFormEmojisZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get errorText => '请选择要上传的表情';
}

// Path: pages.feedback.dialogs.upload.form.title
class _StringsPagesFeedbackDialogsUploadFormTitleZh implements _StringsPagesFeedbackDialogsUploadFormTitleEn {
	_StringsPagesFeedbackDialogsUploadFormTitleZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '标题';
	@override String get hintText => '请输入标题';
	@override String get errorText => '请输入标题';
}

// Path: pages.feedback.dialogs.upload.form.description
class _StringsPagesFeedbackDialogsUploadFormDescriptionZh implements _StringsPagesFeedbackDialogsUploadFormDescriptionEn {
	_StringsPagesFeedbackDialogsUploadFormDescriptionZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '描述';
	@override String get hintText => '请输入描述';
	@override String get errorText => '请输入描述';
}

// Path: pages.feedback.dialogs.upload.form.assets
class _StringsPagesFeedbackDialogsUploadFormAssetsZh implements _StringsPagesFeedbackDialogsUploadFormAssetsEn {
	_StringsPagesFeedbackDialogsUploadFormAssetsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '图片或视频';
	@override String get prefix => '您最多可以上传9张图片或视频';
	@override String get suffix => '图片大小必须在50KB到15MB之间, 视频大小必须在50KB到20MB之间';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Homing Pigeon';
			case 'common.copied': return 'Copied';
			case 'common.success': return 'Succeeded😊';
			case 'common.failure': return 'Failed😭';
			case 'common.noData': return 'No data, click to reload😭';
			case 'pages.home.primary.title': return 'Primary';
			case 'pages.home.primary.rating.title': return 'Movie rating';
			case 'pages.home.primary.rating.description': return 'Rate the movies you’ve watched~~';
			case 'pages.home.primary.live.title': return 'Live broadcast preview';
			case 'pages.home.primary.live.description': return 'Go to the details';
			case 'pages.home.primary.settings.title': return 'Settings';
			case 'pages.home.other.title': return 'Others';
			case 'pages.home.other.notifications.title': return 'Reminders';
			case 'pages.home.other.notifications.description': return 'Get the live broadcast platform, time, etc.';
			case 'pages.home.other.store.title': return 'TAOBAO: Serious';
			case 'pages.home.other.store.description': return 'The cold wave is coming! Bring on a sweatshirt~~';
			case 'pages.home.other.emoji.title': return 'Emojis🐱';
			case 'pages.home.other.emoji.description': return 'Contributions welcome~~';
			case 'pages.home.other.feedback.title': return 'Feedback';
			case 'pages.home.other.feedback.description': return 'No matter you encounter any questions, comments or suggestions, you can give us feedback...';
			case 'pages.home.other.roadmap.title': return 'Roadmap';
			case 'pages.home.other.roadmap.description': return 'View development plans and progress😄';
			case 'pages.home.version': return 'Version';
			case 'pages.emoji.title': return 'Emojis～';
			case 'pages.emoji.tips.title': return 'Contributions are welcome, Wow~';
			case 'pages.emoji.tips.prefix': return 'Welcome';
			case 'pages.emoji.tips.button': return ' [click here] ';
			case 'pages.emoji.tips.suffix': return 'to contribute, it can be emoticons, creative copywriting, or some embarrassing pictures or screenshots of cats, etc.😄';
			case 'pages.emoji.dialogs.upload.buttons.upload': return 'Upload';
			case 'pages.emoji.dialogs.upload.header': return 'Please select emojis you want to upload';
			case 'pages.emoji.dialogs.upload.tips.prefix': return 'You can upload up to 9 images';
			case 'pages.emoji.dialogs.upload.tips.suffix': return 'Image size must be between 50KB and 15MB';
			case 'pages.emoji.dialogs.upload.form.emojis.errorText': return 'Please select emojis you want to upload';
			case 'pages.emoji.dialogs.upload.uploadFailed': return 'File upload failed😭';
			case 'pages.feedback.title': return 'Feedback';
			case 'pages.feedback.tips.title': return 'Comments or suggestions are welcome, wow~';
			case 'pages.feedback.tips.prefix': return 'No matter you encounter any questions, comments or suggestions, you can';
			case 'pages.feedback.tips.button': return ' [click here] ';
			case 'pages.feedback.tips.suffix': return 'to give feedback.';
			case 'pages.feedback.dialogs.upload.buttons.upload': return 'Submit';
			case 'pages.feedback.dialogs.upload.header': return 'Please fill in the feedback info';
			case 'pages.feedback.dialogs.upload.form.title.title': return 'Title';
			case 'pages.feedback.dialogs.upload.form.title.hintText': return 'Please enter a title';
			case 'pages.feedback.dialogs.upload.form.title.errorText': return 'Please enter a title';
			case 'pages.feedback.dialogs.upload.form.description.title': return 'Description';
			case 'pages.feedback.dialogs.upload.form.description.hintText': return 'Please enter a description';
			case 'pages.feedback.dialogs.upload.form.description.errorText': return 'Please enter a description';
			case 'pages.feedback.dialogs.upload.form.assets.title': return 'Picture or video';
			case 'pages.feedback.dialogs.upload.form.assets.prefix': return 'You can upload up to 9 pictures or videos';
			case 'pages.feedback.dialogs.upload.form.assets.suffix': return 'Image size must be between 50KB and 15MB, video size must be between 50KB and 20MB';
			case 'pages.feedback.dialogs.upload.error.image': return 'Uploaded images must be between 15KB and 15MB';
			case 'pages.feedback.dialogs.upload.error.video': return 'Uploaded videos must be between 15KB and 15MB';
			case 'pages.feedback.dialogs.upload.uploadFailed': return '文件上传失败😭';
			case 'pages.feedbackDetail.title': return 'Feedback details';
			case 'pages.live.title': return 'Live streaming～';
			case 'pages.movie.title': return 'Movie';
			case 'pages.roadmap.title': return 'Roadmap';
			case 'pages.social.title': return 'Social';
			case 'buttons.agree': return 'Agree';
			case 'buttons.cancel': return 'Cancel';
			case 'buttons.login': return 'Login';
			case 'buttons.signup': return 'Sign up';
			case 'buttons.logout': return 'Logout';
			case 'buttons.ignore': return 'Ignore';
			case 'buttons.turnOn': return 'Turn on';
			case 'buttons.turnOff': return 'Turn off';
			case 'bottomSheets.login.header': return 'Please fill in your login information';
			case 'bottomSheets.login.form.account.title': return 'Account';
			case 'bottomSheets.login.form.account.hintText': return 'Please enter your account';
			case 'bottomSheets.login.form.account.errorText': return 'Please enter your account';
			case 'bottomSheets.login.form.account.errorText2': return 'Please enter at least 8 characters';
			case 'bottomSheets.login.form.password.title': return 'Password';
			case 'bottomSheets.login.form.password.hintText': return 'Please enter your password';
			case 'bottomSheets.login.form.password.errorText': return 'Please enter your password';
			case 'bottomSheets.login.form.password.errorText2': return 'Please enter at least 8 characters';
			case 'bottomSheets.login.form.privacy.title': return 'Privacy';
			case 'bottomSheets.login.form.privacy.prefix': return 'I have read carefully and agree';
			case 'bottomSheets.login.form.privacy.privacy': return ' Privacy Policy ';
			case 'bottomSheets.login.form.privacy.and': return '&';
			case 'bottomSheets.login.form.privacy.terms': return ' terms and Conditions';
			case 'bottomSheets.login.form.privacy.errorText': return 'Please agree to the privacy agreement';
			case 'bottomSheets.login.tips.prefix': return 'Already have an account, ';
			case 'bottomSheets.login.tips.suffix': return 'go to login';
			case 'bottomSheets.signup.header': return 'Please fill in the registration information';
			case 'bottomSheets.signup.form.account.helperText': return 'The account number can only contain letters, numbers or underscores, and can only start with a letter and be at least 8 characters long.';
			case 'bottomSheets.signup.form.account.errorText2': return 'The account number can only contain letters, numbers or underscores, and can only start with a letter and be at least 8 characters long.';
			case 'bottomSheets.signup.form.nickname.title': return 'Nickname';
			case 'bottomSheets.signup.form.nickname.hintText': return 'Please enter your nickname';
			case 'bottomSheets.signup.form.nickname.helperText': return 'Nickname cannot be longer than 20 characters';
			case 'bottomSheets.signup.form.nickname.errorText': return 'Nickname cannot be longer than 20 characters';
			case 'bottomSheets.signup.form.email.title': return 'Email';
			case 'bottomSheets.signup.form.email.hintText': return 'Please enter your email';
			case 'bottomSheets.signup.form.email.errorText': return 'Please enter your email';
			case 'bottomSheets.signup.form.email.errorText2': return 'The email format you entered is wrong';
			case 'bottomSheets.signup.form.password.helperText': return 'Please enter at least 8 characters';
			case 'bottomSheets.signup.form.repeatPassword.title': return 'Repeat password';
			case 'bottomSheets.signup.form.repeatPassword.hintText': return 'Please enter your password again';
			case 'bottomSheets.signup.form.repeatPassword.errorText': return 'Please enter your password again';
			case 'bottomSheets.signup.form.repeatPassword.errorText2': return 'The passwords entered twice are different';
			case 'bottomSheets.signup.tips.prefix': return 'No account yet, ';
			case 'bottomSheets.signup.tips.suffix': return 'go to register';
			case 'bottomSheets.store.title': return 'Please select to continue';
			case 'bottomSheets.store.code.title': return 'Copy Taobao code';
			case 'bottomSheets.store.code.description': return 'Get the live broadcast platform, time, etc.';
			case 'bottomSheets.store.link.title': return 'Open store link';
			case 'bottomSheets.store.link.description': return 'The cold wave is coming! Bring on a sweatshirt~~';
			case 'dialogs.license.title': return 'Terms and Conditions';
			case 'dialogs.license.contentContent': return 'Protecting user\'s privacy and personal information is a fundamental principle of Homing Pigeon.';
			case 'dialogs.license.contentTip': return 'Below is a list of permissions required by this APP:';
			case 'dialogs.license.contentPrefix': return 'Before you use this APP\'s services, please carefully read and agree to the ';
			case 'dialogs.license.contentUserAgreement': return 'User Agreement';
			case 'dialogs.license.contentAnd': return ' and ';
			case 'dialogs.license.contentPrivacyAgreement': return 'Privacy Agreement';
			case 'dialogs.license.contentSuffix': return ', start using our services after you agree and accept all terms.';
			case 'dialogs.license.iosPermissions.0': return 'For you to take pictures, Homing Pigeon needs access to your Camera. (NSCameraUsageDescription)';
			case 'dialogs.license.iosPermissions.1': return 'For you to upload pictures, Homing Pigeon needs access to your Photos. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.license.androidPermissions.0': return 'Used for data interaction between the application and the server, Homing Pigeon needs access to your Internet. (android.permission.INTERNET)';
			case 'dialogs.license.androidPermissions.1': return 'In order to send you notifications, Homing Pigeon needs access to your permission. (android.permission.POST_NOTIFICATIONS)';
			case 'dialogs.license.androidPermissions.2': return 'For you to upload pictures, Homing Pigeon needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.3': return 'For you to save pictures, Homing Pigeon needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.4': return 'For you to upload pictures, Homing Pigeon needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.license.androidPermissions.5': return 'For you to upload videos, Homing Pigeon needs access to your Videos. (android.permission.READ_MEDIA_VIDEO)';
			case 'dialogs.license.androidPermissions.6': return 'For you to take pictures, Homing Pigeon needs access to your Camera. (android.permission.CAMERA)';
			case 'dialogs.license.androidPermissions.7': return 'In order to send you local notifications, Homing Pigeon needs access to your permission. (android.permission.RECEIVE_BOOT_COMPLETED)';
			case 'dialogs.album.title': return 'Allow access to your album';
			case 'dialogs.album.description': return 'Please go to your phone Settings to grant Homing Pigeon the permission to visit your album.';
			case 'locales.en': return 'English';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

extension on _StringsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return '信鸽';
			case 'common.copied': return '已复制';
			case 'common.success': return '成功啦😊';
			case 'common.failure': return '失败啦😭';
			case 'common.noData': return '没有数据, 点击以重新加载😭';
			case 'pages.home.primary.title': return '主要功能';
			case 'pages.home.primary.rating.title': return '电影打分系统';
			case 'pages.home.primary.rating.description': return '给看过的电影打个分吧~~';
			case 'pages.home.primary.live.title': return '直播预告';
			case 'pages.home.primary.live.description': return '查看详情';
			case 'pages.home.primary.settings.title': return '开播通知设置';
			case 'pages.home.other.title': return '其他功能';
			case 'pages.home.other.notifications.title': return '直播信息/提醒群';
			case 'pages.home.other.notifications.description': return '直播平台、时间等';
			case 'pages.home.other.store.title': return '小德官方店: 喜瑞斯';
			case 'pages.home.other.store.description': return '寒潮啦! 来件卫衣吧~~';
			case 'pages.home.other.emoji.title': return '小德表情包🐱';
			case 'pages.home.other.emoji.description': return '欢迎投稿~~';
			case 'pages.home.other.feedback.title': return '意见/建议';
			case 'pages.home.other.feedback.description': return '无论您遇到任何问题、意见或建议, 均可反馈...';
			case 'pages.home.other.roadmap.title': return '路线图';
			case 'pages.home.other.roadmap.description': return '查看开发计划和进度😄';
			case 'pages.home.version': return '版本号';
			case 'pages.emoji.title': return '表情库～';
			case 'pages.emoji.tips.title': return '欢迎投稿，嗷呜~';
			case 'pages.emoji.tips.prefix': return '欢迎';
			case 'pages.emoji.tips.button': return ' [点击此处] ';
			case 'pages.emoji.tips.suffix': return '投稿，可以是表情包，可以是文案创意，也可以是一些令猫尴尬的图片或截图等~😄';
			case 'pages.emoji.dialogs.upload.buttons.upload': return '上传';
			case 'pages.emoji.dialogs.upload.header': return '请选择要上传的表情';
			case 'pages.emoji.dialogs.upload.tips.prefix': return '您最多可以上传9张图片';
			case 'pages.emoji.dialogs.upload.tips.suffix': return '图片大小必须在50KB到15MB之间';
			case 'pages.emoji.dialogs.upload.form.emojis.errorText': return '请选择要上传的表情';
			case 'pages.emoji.dialogs.upload.uploadFailed': return '文件上传失败😭';
			case 'pages.feedback.title': return '意见或建议';
			case 'pages.feedback.tips.title': return '欢迎提意见或建议，嗷呜~';
			case 'pages.feedback.tips.prefix': return '无论您遇到任何问题、意见或建议，均可';
			case 'pages.feedback.tips.button': return ' [点击此处] ';
			case 'pages.feedback.tips.suffix': return '进行反馈.';
			case 'pages.feedback.dialogs.upload.buttons.upload': return '提交';
			case 'pages.feedback.dialogs.upload.header': return '请填写反馈内容';
			case 'pages.feedback.dialogs.upload.form.title.title': return '标题';
			case 'pages.feedback.dialogs.upload.form.title.hintText': return '请输入标题';
			case 'pages.feedback.dialogs.upload.form.title.errorText': return '请输入标题';
			case 'pages.feedback.dialogs.upload.form.description.title': return '描述';
			case 'pages.feedback.dialogs.upload.form.description.hintText': return '请输入描述';
			case 'pages.feedback.dialogs.upload.form.description.errorText': return '请输入描述';
			case 'pages.feedback.dialogs.upload.form.assets.title': return '图片或视频';
			case 'pages.feedback.dialogs.upload.form.assets.prefix': return '您最多可以上传9张图片或视频';
			case 'pages.feedback.dialogs.upload.form.assets.suffix': return '图片大小必须在50KB到15MB之间, 视频大小必须在50KB到20MB之间';
			case 'pages.feedback.dialogs.upload.error.image': return '上传的图片必须在15KB至15MB之间';
			case 'pages.feedback.dialogs.upload.error.video': return '上传的视频必须在15KB至20MB之间';
			case 'pages.feedback.dialogs.upload.uploadFailed': return '文件上传失败😭';
			case 'pages.feedbackDetail.title': return '反馈详情';
			case 'pages.live.title': return '直播～';
			case 'pages.movie.title': return '电影';
			case 'pages.roadmap.title': return '路线图';
			case 'pages.social.title': return '社交';
			case 'buttons.agree': return '同意';
			case 'buttons.cancel': return '再想想';
			case 'buttons.login': return '登录';
			case 'buttons.signup': return '注册';
			case 'buttons.logout': return '退出';
			case 'buttons.ignore': return '忽略';
			case 'buttons.turnOn': return '开启';
			case 'buttons.turnOff': return '关闭';
			case 'bottomSheets.login.header': return '请填写登录信息';
			case 'bottomSheets.login.form.account.title': return '账号';
			case 'bottomSheets.login.form.account.hintText': return '请输入账号';
			case 'bottomSheets.login.form.account.errorText': return '请输入账号';
			case 'bottomSheets.login.form.account.errorText2': return '请输入至少8个字符';
			case 'bottomSheets.login.form.password.title': return '密码';
			case 'bottomSheets.login.form.password.hintText': return '请输入密码';
			case 'bottomSheets.login.form.password.errorText': return '请输入密码';
			case 'bottomSheets.login.form.password.errorText2': return '请输入至少8个字符';
			case 'bottomSheets.login.form.privacy.title': return '隐私协议';
			case 'bottomSheets.login.form.privacy.prefix': return '我已仔细阅读并同意';
			case 'bottomSheets.login.form.privacy.privacy': return '隐私政策';
			case 'bottomSheets.login.form.privacy.and': return '以及';
			case 'bottomSheets.login.form.privacy.terms': return '条款和条件';
			case 'bottomSheets.login.form.privacy.errorText': return '请同意隐私协议';
			case 'bottomSheets.login.tips.prefix': return '已有账号, ';
			case 'bottomSheets.login.tips.suffix': return '去登录';
			case 'bottomSheets.signup.header': return '请填写注册信息';
			case 'bottomSheets.signup.form.account.helperText': return '只能包含英文, 数字或下划线, 且只能以字母开头, 至少8个字符';
			case 'bottomSheets.signup.form.account.errorText2': return '账号只能包含英文,数字或下划线, 且只能以字母开头, 至少8个字符';
			case 'bottomSheets.signup.form.nickname.title': return '昵称';
			case 'bottomSheets.signup.form.nickname.hintText': return '请输入昵称';
			case 'bottomSheets.signup.form.nickname.helperText': return '不能多于20个字符';
			case 'bottomSheets.signup.form.nickname.errorText': return '昵称长度不能大于20';
			case 'bottomSheets.signup.form.email.title': return '邮箱';
			case 'bottomSheets.signup.form.email.hintText': return '请输入邮箱';
			case 'bottomSheets.signup.form.email.errorText': return '请输入邮箱';
			case 'bottomSheets.signup.form.email.errorText2': return '邮箱格式错误';
			case 'bottomSheets.signup.form.password.helperText': return '请输入至少8个字符';
			case 'bottomSheets.signup.form.repeatPassword.title': return '账号';
			case 'bottomSheets.signup.form.repeatPassword.hintText': return '请再次输入密码';
			case 'bottomSheets.signup.form.repeatPassword.errorText': return '请再次输入密码';
			case 'bottomSheets.signup.form.repeatPassword.errorText2': return '两次输入的密码不一样';
			case 'bottomSheets.signup.tips.prefix': return '还没有账号, ';
			case 'bottomSheets.signup.tips.suffix': return '去注册';
			case 'bottomSheets.store.title': return '请选择您的操作';
			case 'bottomSheets.store.code.title': return '复制淘口令';
			case 'bottomSheets.store.code.description': return '直播平台、时间等';
			case 'bottomSheets.store.link.title': return '打开淘宝店地址';
			case 'bottomSheets.store.link.description': return '寒潮啦! 来件卫衣吧~~';
			case 'dialogs.license.title': return '隐私条款';
			case 'dialogs.license.contentContent': return '信鸽 非常重视你的隐私保护和个人信息保护.';
			case 'dialogs.license.contentTip': return '以下是该APP所需的权限列表:';
			case 'dialogs.license.contentPrefix': return '在使用APP服务前，请认真阅读 ';
			case 'dialogs.license.contentUserAgreement': return '《隐私政策》';
			case 'dialogs.license.contentAnd': return '和';
			case 'dialogs.license.contentPrivacyAgreement': return '《用户服务协议》';
			case 'dialogs.license.contentSuffix': return ', 你同意并接受全部条款后开始使用我们的服务.';
			case 'dialogs.license.iosPermissions.0': return '为了让您拍摄照片, 信鸽 需要访问您的相机. (NSCameraUsageDescription)';
			case 'dialogs.license.iosPermissions.1': return '为了让您上传图片, 信鸽 需要访问您的照片. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.license.androidPermissions.0': return '用于应用程序和服务器之间的数据交互，信鸽 需要访问您的互联网. (android.permission.INTERNET)';
			case 'dialogs.license.androidPermissions.1': return '为了给您发送通知, 信鸽 需要获取您的权限. (android.permission.POST_NOTIFICATIONS)';
			case 'dialogs.license.androidPermissions.2': return '为了让您上传图片, 信鸽 需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.3': return '为了让您保存图片, 信鸽 需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.4': return '为了让您上传图片, 信鸽 需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.license.androidPermissions.5': return '为了让您上传视频, 信鸽 需要访问您的视频. (android.permission.READ_MEDIA_VIDEO)';
			case 'dialogs.license.androidPermissions.6': return '为了让您拍摄照片, 信鸽 需要访问您的相机. (android.permission.CAMERA)';
			case 'dialogs.license.androidPermissions.7': return '为了向您发送本地通知, 信鸽 需要访问您的权限. (android.permission.RECEIVE_BOOT_COMPLETED)';
			case 'dialogs.album.title': return '允许访问您的相册';
			case 'dialogs.album.description': return '请前往您的手机设置授予信鸽访问您相册的权限.';
			case 'locales.en': return 'English';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}
