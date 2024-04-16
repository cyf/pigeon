/// Generated file. Do not edit.
///
/// Original: lib/i18n
/// To regenerate, run: `dart run slang`
///
/// Locales: 2
/// Strings: 48 (24 per locale)
///
/// Built on 2024-04-16 at 11:36 UTC

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
	late final _StringsPagesEn pages = _StringsPagesEn._(_root);
	late final _StringsButtonsEn buttons = _StringsButtonsEn._(_root);
	late final _StringsDialogsEn dialogs = _StringsDialogsEn._(_root);
	Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: pages
class _StringsPagesEn {
	_StringsPagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsPagesHomePageEn homePage = _StringsPagesHomePageEn._(_root);
}

// Path: buttons
class _StringsButtonsEn {
	_StringsButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get agree => 'Agree';
	String get cancel => 'Cancel';
}

// Path: dialogs
class _StringsDialogsEn {
	_StringsDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final _StringsDialogsLicenseDialogEn licenseDialog = _StringsDialogsLicenseDialogEn._(_root);
}

// Path: pages.homePage
class _StringsPagesHomePageEn {
	_StringsPagesHomePageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Homing Pigeon';
}

// Path: dialogs.licenseDialog
class _StringsDialogsLicenseDialogEn {
	_StringsDialogsLicenseDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get licenseDialogTitle => 'Terms and Conditions';
	String get licenseDialogContentContent => 'Protecting user\'s privacy and personal information is a fundamental principle of Homing Pigeon.';
	String get licenseDialogContentTip => 'Below is a list of permissions required by this APP:';
	String get licenseDialogContentPrefix => 'Before you use this APP\'s services, please carefully read and agree to the ';
	String get licenseDialogContentUserAgreement => 'User Agreement';
	String get licenseDialogContentAnd => ' and ';
	String get licenseDialogContentPrivacyAgreement => 'Privacy Agreement';
	String get licenseDialogContentSuffix => ', start using our services after you agree and accept all terms.';
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
	@override late final _StringsPagesZh pages = _StringsPagesZh._(_root);
	@override late final _StringsButtonsZh buttons = _StringsButtonsZh._(_root);
	@override late final _StringsDialogsZh dialogs = _StringsDialogsZh._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: pages
class _StringsPagesZh implements _StringsPagesEn {
	_StringsPagesZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsPagesHomePageZh homePage = _StringsPagesHomePageZh._(_root);
}

// Path: buttons
class _StringsButtonsZh implements _StringsButtonsEn {
	_StringsButtonsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get agree => '同意';
	@override String get cancel => '再想想';
}

// Path: dialogs
class _StringsDialogsZh implements _StringsDialogsEn {
	_StringsDialogsZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override late final _StringsDialogsLicenseDialogZh licenseDialog = _StringsDialogsLicenseDialogZh._(_root);
}

// Path: pages.homePage
class _StringsPagesHomePageZh implements _StringsPagesHomePageEn {
	_StringsPagesHomePageZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '信鸽';
}

// Path: dialogs.licenseDialog
class _StringsDialogsLicenseDialogZh implements _StringsDialogsLicenseDialogEn {
	_StringsDialogsLicenseDialogZh._(this._root);

	@override final _StringsZh _root; // ignore: unused_field

	// Translations
	@override String get licenseDialogTitle => '隐私条款';
	@override String get licenseDialogContentContent => '信鸽 非常重视你的隐私保护和个人信息保护.';
	@override String get licenseDialogContentTip => '以下是该APP所需的权限列表:';
	@override String get licenseDialogContentPrefix => '在使用APP服务前，请认真阅读 ';
	@override String get licenseDialogContentUserAgreement => '《隐私政策》';
	@override String get licenseDialogContentAnd => '和';
	@override String get licenseDialogContentPrivacyAgreement => '《用户服务协议》';
	@override String get licenseDialogContentSuffix => ', 你同意并接受全部条款后开始使用我们的服务.';
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

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.

extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Homing Pigeon';
			case 'pages.homePage.title': return 'Homing Pigeon';
			case 'buttons.agree': return 'Agree';
			case 'buttons.cancel': return 'Cancel';
			case 'dialogs.licenseDialog.licenseDialogTitle': return 'Terms and Conditions';
			case 'dialogs.licenseDialog.licenseDialogContentContent': return 'Protecting user\'s privacy and personal information is a fundamental principle of Homing Pigeon.';
			case 'dialogs.licenseDialog.licenseDialogContentTip': return 'Below is a list of permissions required by this APP:';
			case 'dialogs.licenseDialog.licenseDialogContentPrefix': return 'Before you use this APP\'s services, please carefully read and agree to the ';
			case 'dialogs.licenseDialog.licenseDialogContentUserAgreement': return 'User Agreement';
			case 'dialogs.licenseDialog.licenseDialogContentAnd': return ' and ';
			case 'dialogs.licenseDialog.licenseDialogContentPrivacyAgreement': return 'Privacy Agreement';
			case 'dialogs.licenseDialog.licenseDialogContentSuffix': return ', start using our services after you agree and accept all terms.';
			case 'dialogs.licenseDialog.iosPermissions.0': return 'For you to take pictures, Homing Pigeon needs access to your Camera. (NSCameraUsageDescription)';
			case 'dialogs.licenseDialog.iosPermissions.1': return 'For you to upload pictures, Homing Pigeon needs access to your Photos. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.licenseDialog.androidPermissions.0': return 'Used for data interaction between the application and the server, Homing Pigeon needs access to your Internet. (android.permission.INTERNET)';
			case 'dialogs.licenseDialog.androidPermissions.1': return 'In order to send you notifications, Homing Pigeon needs access to your permission. (android.permission.POST_NOTIFICATIONS)';
			case 'dialogs.licenseDialog.androidPermissions.2': return 'For you to upload pictures, Homing Pigeon needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.3': return 'For you to save pictures, Homing Pigeon needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.4': return 'For you to upload pictures, Homing Pigeon needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.licenseDialog.androidPermissions.5': return 'For you to upload videos, Homing Pigeon needs access to your Videos. (android.permission.READ_MEDIA_VIDEO)';
			case 'dialogs.licenseDialog.androidPermissions.6': return 'For you to take pictures, Homing Pigeon needs access to your Camera. (android.permission.CAMERA)';
			case 'dialogs.licenseDialog.androidPermissions.7': return 'In order to send you local notifications, Homing Pigeon needs access to your permission. (android.permission.RECEIVE_BOOT_COMPLETED)';
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
			case 'pages.homePage.title': return '信鸽';
			case 'buttons.agree': return '同意';
			case 'buttons.cancel': return '再想想';
			case 'dialogs.licenseDialog.licenseDialogTitle': return '隐私条款';
			case 'dialogs.licenseDialog.licenseDialogContentContent': return '信鸽 非常重视你的隐私保护和个人信息保护.';
			case 'dialogs.licenseDialog.licenseDialogContentTip': return '以下是该APP所需的权限列表:';
			case 'dialogs.licenseDialog.licenseDialogContentPrefix': return '在使用APP服务前，请认真阅读 ';
			case 'dialogs.licenseDialog.licenseDialogContentUserAgreement': return '《隐私政策》';
			case 'dialogs.licenseDialog.licenseDialogContentAnd': return '和';
			case 'dialogs.licenseDialog.licenseDialogContentPrivacyAgreement': return '《用户服务协议》';
			case 'dialogs.licenseDialog.licenseDialogContentSuffix': return ', 你同意并接受全部条款后开始使用我们的服务.';
			case 'dialogs.licenseDialog.iosPermissions.0': return '为了让您拍摄照片, 信鸽 需要访问您的相机. (NSCameraUsageDescription)';
			case 'dialogs.licenseDialog.iosPermissions.1': return '为了让您上传图片, 信鸽 需要访问您的照片. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.licenseDialog.androidPermissions.0': return '用于应用程序和服务器之间的数据交互，信鸽 需要访问您的互联网. (android.permission.INTERNET)';
			case 'dialogs.licenseDialog.androidPermissions.1': return '为了给您发送通知, 信鸽 需要获取您的权限. (android.permission.POST_NOTIFICATIONS)';
			case 'dialogs.licenseDialog.androidPermissions.2': return '为了让您上传图片, 信鸽 需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.3': return '为了让您保存图片, 信鸽 需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.licenseDialog.androidPermissions.4': return '为了让您上传图片, 信鸽 需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.licenseDialog.androidPermissions.5': return '为了让您上传视频, 信鸽 需要访问您的视频. (android.permission.READ_MEDIA_VIDEO)';
			case 'dialogs.licenseDialog.androidPermissions.6': return '为了让您拍摄照片, 信鸽 需要访问您的相机. (android.permission.CAMERA)';
			case 'dialogs.licenseDialog.androidPermissions.7': return '为了向您发送本地通知, 信鸽 需要访问您的权限. (android.permission.RECEIVE_BOOT_COMPLETED)';
			case 'locales.en': return 'English';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}
