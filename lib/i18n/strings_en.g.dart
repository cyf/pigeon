///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations implements BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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
	String get appName => 'Pigeon';
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsPagesEn pages = TranslationsPagesEn._(_root);
	late final TranslationsButtonsEn buttons = TranslationsButtonsEn._(_root);
	late final TranslationsBottomSheetsEn bottomSheets = TranslationsBottomSheetsEn._(_root);
	late final TranslationsDialogsEn dialogs = TranslationsDialogsEn._(_root);
	Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get copied => 'Copied';
	String get success => 'Succeeded😊';
	String get failure => 'Failed😭';
	String get noData => 'No data, click to reload😭';
}

// Path: pages
class TranslationsPagesEn {
	TranslationsPagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesHomeEn home = TranslationsPagesHomeEn._(_root);
	late final TranslationsPagesEmojiEn emoji = TranslationsPagesEmojiEn._(_root);
	late final TranslationsPagesFeedbackEn feedback = TranslationsPagesFeedbackEn._(_root);
	late final TranslationsPagesFeedbackDetailEn feedbackDetail = TranslationsPagesFeedbackDetailEn._(_root);
	late final TranslationsPagesLiveEn live = TranslationsPagesLiveEn._(_root);
	late final TranslationsPagesMovieEn movie = TranslationsPagesMovieEn._(_root);
	late final TranslationsPagesRoadmapEn roadmap = TranslationsPagesRoadmapEn._(_root);
	late final TranslationsPagesSocialEn social = TranslationsPagesSocialEn._(_root);
}

// Path: buttons
class TranslationsButtonsEn {
	TranslationsButtonsEn._(this._root);

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
class TranslationsBottomSheetsEn {
	TranslationsBottomSheetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBottomSheetsLoginEn login = TranslationsBottomSheetsLoginEn._(_root);
	late final TranslationsBottomSheetsSignupEn signup = TranslationsBottomSheetsSignupEn._(_root);
	late final TranslationsBottomSheetsStoreEn store = TranslationsBottomSheetsStoreEn._(_root);
}

// Path: dialogs
class TranslationsDialogsEn {
	TranslationsDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsDialogsLicenseEn license = TranslationsDialogsLicenseEn._(_root);
	late final TranslationsDialogsAlbumEn album = TranslationsDialogsAlbumEn._(_root);
}

// Path: pages.home
class TranslationsPagesHomeEn {
	TranslationsPagesHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesHomePrimaryEn primary = TranslationsPagesHomePrimaryEn._(_root);
	late final TranslationsPagesHomeOtherEn other = TranslationsPagesHomeOtherEn._(_root);
	String get version => 'Version';
}

// Path: pages.emoji
class TranslationsPagesEmojiEn {
	TranslationsPagesEmojiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Emojis～';
	late final TranslationsPagesEmojiTipsEn tips = TranslationsPagesEmojiTipsEn._(_root);
	late final TranslationsPagesEmojiDialogsEn dialogs = TranslationsPagesEmojiDialogsEn._(_root);
}

// Path: pages.feedback
class TranslationsPagesFeedbackEn {
	TranslationsPagesFeedbackEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback';
	late final TranslationsPagesFeedbackTipsEn tips = TranslationsPagesFeedbackTipsEn._(_root);
	late final TranslationsPagesFeedbackDialogsEn dialogs = TranslationsPagesFeedbackDialogsEn._(_root);
}

// Path: pages.feedbackDetail
class TranslationsPagesFeedbackDetailEn {
	TranslationsPagesFeedbackDetailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback details';
}

// Path: pages.live
class TranslationsPagesLiveEn {
	TranslationsPagesLiveEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Live streaming～';
}

// Path: pages.movie
class TranslationsPagesMovieEn {
	TranslationsPagesMovieEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Movie';
}

// Path: pages.roadmap
class TranslationsPagesRoadmapEn {
	TranslationsPagesRoadmapEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Roadmap';
}

// Path: pages.social
class TranslationsPagesSocialEn {
	TranslationsPagesSocialEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Social';
}

// Path: bottomSheets.login
class TranslationsBottomSheetsLoginEn {
	TranslationsBottomSheetsLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get header => 'Please fill in your login information';
	late final TranslationsBottomSheetsLoginFormEn form = TranslationsBottomSheetsLoginFormEn._(_root);
	late final TranslationsBottomSheetsLoginTipsEn tips = TranslationsBottomSheetsLoginTipsEn._(_root);
}

// Path: bottomSheets.signup
class TranslationsBottomSheetsSignupEn {
	TranslationsBottomSheetsSignupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get header => 'Please fill in the registration information';
	late final TranslationsBottomSheetsSignupFormEn form = TranslationsBottomSheetsSignupFormEn._(_root);
	late final TranslationsBottomSheetsSignupTipsEn tips = TranslationsBottomSheetsSignupTipsEn._(_root);
}

// Path: bottomSheets.store
class TranslationsBottomSheetsStoreEn {
	TranslationsBottomSheetsStoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Please select to continue';
	late final TranslationsBottomSheetsStoreCodeEn code = TranslationsBottomSheetsStoreCodeEn._(_root);
	late final TranslationsBottomSheetsStoreLinkEn link = TranslationsBottomSheetsStoreLinkEn._(_root);
}

// Path: dialogs.license
class TranslationsDialogsLicenseEn {
	TranslationsDialogsLicenseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Terms and Conditions';
	String get contentContent => 'Protecting user\'s privacy and personal information is a fundamental principle of Pigeon.';
	String get contentTip => 'Below is a list of permissions required by this APP:';
	String get contentPrefix => 'Before you use this APP\'s services, please carefully read and agree to the ';
	String get contentUserAgreement => 'User Agreement';
	String get contentAnd => ' and ';
	String get contentPrivacyAgreement => 'Privacy Agreement';
	String get contentSuffix => ', start using our services after you agree and accept all terms.';
	List<String> get iosPermissions => [
		'For you to take pictures, Pigeon needs access to your Camera. (NSCameraUsageDescription)',
		'For you to upload pictures, Pigeon needs access to your Photos. (NSPhotoLibraryUsageDescription)',
	];
	List<String> get androidPermissions => [
		'Used for data interaction between the application and the server, Pigeon needs access to your Internet. (android.permission.INTERNET)',
		'In order to send you notifications, Pigeon needs access to your permission. (android.permission.POST_NOTIFICATIONS)',
		'For you to upload pictures, Pigeon needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)',
		'For you to save pictures, Pigeon needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)',
		'For you to upload pictures, Pigeon needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)',
		'For you to upload videos, Pigeon needs access to your Videos. (android.permission.READ_MEDIA_VIDEO)',
		'For you to take pictures, Pigeon needs access to your Camera. (android.permission.CAMERA)',
		'In order to send you local notifications, Pigeon needs access to your permission. (android.permission.RECEIVE_BOOT_COMPLETED)',
	];
}

// Path: dialogs.album
class TranslationsDialogsAlbumEn {
	TranslationsDialogsAlbumEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Allow access to your album';
	String get description => 'Please go to your phone Settings to grant Pigeon the permission to visit your album.';
}

// Path: pages.home.primary
class TranslationsPagesHomePrimaryEn {
	TranslationsPagesHomePrimaryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Primary';
	late final TranslationsPagesHomePrimaryRatingEn rating = TranslationsPagesHomePrimaryRatingEn._(_root);
	late final TranslationsPagesHomePrimaryLiveEn live = TranslationsPagesHomePrimaryLiveEn._(_root);
	late final TranslationsPagesHomePrimarySettingsEn settings = TranslationsPagesHomePrimarySettingsEn._(_root);
}

// Path: pages.home.other
class TranslationsPagesHomeOtherEn {
	TranslationsPagesHomeOtherEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Others';
	late final TranslationsPagesHomeOtherNotificationsEn notifications = TranslationsPagesHomeOtherNotificationsEn._(_root);
	late final TranslationsPagesHomeOtherStoreEn store = TranslationsPagesHomeOtherStoreEn._(_root);
	late final TranslationsPagesHomeOtherEmojiEn emoji = TranslationsPagesHomeOtherEmojiEn._(_root);
	late final TranslationsPagesHomeOtherFeedbackEn feedback = TranslationsPagesHomeOtherFeedbackEn._(_root);
	late final TranslationsPagesHomeOtherRoadmapEn roadmap = TranslationsPagesHomeOtherRoadmapEn._(_root);
}

// Path: pages.emoji.tips
class TranslationsPagesEmojiTipsEn {
	TranslationsPagesEmojiTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Contributions are welcome, Wow~';
	String get prefix => 'Welcome';
	String get button => ' [click here] ';
	String get suffix => 'to contribute, it can be emoticons, creative copywriting, or some embarrassing pictures or screenshots of cats, etc.😄';
}

// Path: pages.emoji.dialogs
class TranslationsPagesEmojiDialogsEn {
	TranslationsPagesEmojiDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesEmojiDialogsUploadEn upload = TranslationsPagesEmojiDialogsUploadEn._(_root);
}

// Path: pages.feedback.tips
class TranslationsPagesFeedbackTipsEn {
	TranslationsPagesFeedbackTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Comments or suggestions are welcome, wow~';
	String get prefix => 'No matter you encounter any questions, comments or suggestions, you can';
	String get button => ' [click here] ';
	String get suffix => 'to give feedback.';
}

// Path: pages.feedback.dialogs
class TranslationsPagesFeedbackDialogsEn {
	TranslationsPagesFeedbackDialogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesFeedbackDialogsUploadEn upload = TranslationsPagesFeedbackDialogsUploadEn._(_root);
}

// Path: bottomSheets.login.form
class TranslationsBottomSheetsLoginFormEn {
	TranslationsBottomSheetsLoginFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBottomSheetsLoginFormAccountEn account = TranslationsBottomSheetsLoginFormAccountEn._(_root);
	late final TranslationsBottomSheetsLoginFormPasswordEn password = TranslationsBottomSheetsLoginFormPasswordEn._(_root);
	late final TranslationsBottomSheetsLoginFormPrivacyEn privacy = TranslationsBottomSheetsLoginFormPrivacyEn._(_root);
}

// Path: bottomSheets.login.tips
class TranslationsBottomSheetsLoginTipsEn {
	TranslationsBottomSheetsLoginTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get prefix => 'Already have an account, ';
	String get suffix => 'go to login';
}

// Path: bottomSheets.signup.form
class TranslationsBottomSheetsSignupFormEn {
	TranslationsBottomSheetsSignupFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsBottomSheetsSignupFormAccountEn account = TranslationsBottomSheetsSignupFormAccountEn._(_root);
	late final TranslationsBottomSheetsSignupFormNicknameEn nickname = TranslationsBottomSheetsSignupFormNicknameEn._(_root);
	late final TranslationsBottomSheetsSignupFormEmailEn email = TranslationsBottomSheetsSignupFormEmailEn._(_root);
	late final TranslationsBottomSheetsSignupFormPasswordEn password = TranslationsBottomSheetsSignupFormPasswordEn._(_root);
	late final TranslationsBottomSheetsSignupFormRepeatPasswordEn repeatPassword = TranslationsBottomSheetsSignupFormRepeatPasswordEn._(_root);
}

// Path: bottomSheets.signup.tips
class TranslationsBottomSheetsSignupTipsEn {
	TranslationsBottomSheetsSignupTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get prefix => 'No account yet, ';
	String get suffix => 'go to register';
}

// Path: bottomSheets.store.code
class TranslationsBottomSheetsStoreCodeEn {
	TranslationsBottomSheetsStoreCodeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Copy Taobao code';
	String get description => 'Get the live broadcast platform, time, etc.';
}

// Path: bottomSheets.store.link
class TranslationsBottomSheetsStoreLinkEn {
	TranslationsBottomSheetsStoreLinkEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Open store link';
	String get description => 'The cold wave is coming! Bring on a sweatshirt~~';
}

// Path: pages.home.primary.rating
class TranslationsPagesHomePrimaryRatingEn {
	TranslationsPagesHomePrimaryRatingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Movie rating';
	String get description => 'Rate the movies you’ve watched~~';
}

// Path: pages.home.primary.live
class TranslationsPagesHomePrimaryLiveEn {
	TranslationsPagesHomePrimaryLiveEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Live broadcast preview';
	String get description => 'Go to the details';
}

// Path: pages.home.primary.settings
class TranslationsPagesHomePrimarySettingsEn {
	TranslationsPagesHomePrimarySettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Settings';
}

// Path: pages.home.other.notifications
class TranslationsPagesHomeOtherNotificationsEn {
	TranslationsPagesHomeOtherNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Reminders';
	String get description => 'Get the live broadcast platform, time, etc.';
}

// Path: pages.home.other.store
class TranslationsPagesHomeOtherStoreEn {
	TranslationsPagesHomeOtherStoreEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'TAOBAO: Serious';
	String get description => 'The cold wave is coming! Bring on a sweatshirt~~';
}

// Path: pages.home.other.emoji
class TranslationsPagesHomeOtherEmojiEn {
	TranslationsPagesHomeOtherEmojiEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Emojis🐱';
	String get description => 'Contributions welcome~~';
}

// Path: pages.home.other.feedback
class TranslationsPagesHomeOtherFeedbackEn {
	TranslationsPagesHomeOtherFeedbackEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Feedback';
	String get description => 'No matter you encounter any questions, comments or suggestions, you can give us feedback...';
}

// Path: pages.home.other.roadmap
class TranslationsPagesHomeOtherRoadmapEn {
	TranslationsPagesHomeOtherRoadmapEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Roadmap';
	String get description => 'View development plans and progress😄';
}

// Path: pages.emoji.dialogs.upload
class TranslationsPagesEmojiDialogsUploadEn {
	TranslationsPagesEmojiDialogsUploadEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesEmojiDialogsUploadButtonsEn buttons = TranslationsPagesEmojiDialogsUploadButtonsEn._(_root);
	String get header => 'Please select emojis you want to upload';
	late final TranslationsPagesEmojiDialogsUploadTipsEn tips = TranslationsPagesEmojiDialogsUploadTipsEn._(_root);
	late final TranslationsPagesEmojiDialogsUploadFormEn form = TranslationsPagesEmojiDialogsUploadFormEn._(_root);
	String get uploadFailed => 'File upload failed😭';
}

// Path: pages.feedback.dialogs.upload
class TranslationsPagesFeedbackDialogsUploadEn {
	TranslationsPagesFeedbackDialogsUploadEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesFeedbackDialogsUploadButtonsEn buttons = TranslationsPagesFeedbackDialogsUploadButtonsEn._(_root);
	String get header => 'Please fill in the feedback info';
	late final TranslationsPagesFeedbackDialogsUploadFormEn form = TranslationsPagesFeedbackDialogsUploadFormEn._(_root);
	late final TranslationsPagesFeedbackDialogsUploadErrorEn error = TranslationsPagesFeedbackDialogsUploadErrorEn._(_root);
	String get uploadFailed => '文件上传失败😭';
}

// Path: bottomSheets.login.form.account
class TranslationsBottomSheetsLoginFormAccountEn {
	TranslationsBottomSheetsLoginFormAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Account';
	String get hintText => 'Please enter your account';
	String get errorText => 'Please enter your account';
	String get errorText2 => 'Please enter at least 8 characters';
}

// Path: bottomSheets.login.form.password
class TranslationsBottomSheetsLoginFormPasswordEn {
	TranslationsBottomSheetsLoginFormPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Password';
	String get hintText => 'Please enter your password';
	String get errorText => 'Please enter your password';
	String get errorText2 => 'Please enter at least 8 characters';
}

// Path: bottomSheets.login.form.privacy
class TranslationsBottomSheetsLoginFormPrivacyEn {
	TranslationsBottomSheetsLoginFormPrivacyEn._(this._root);

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
class TranslationsBottomSheetsSignupFormAccountEn {
	TranslationsBottomSheetsSignupFormAccountEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get helperText => 'The account number can only contain letters, numbers or underscores, and can only start with a letter and be at least 8 characters long.';
	String get errorText2 => 'The account number can only contain letters, numbers or underscores, and can only start with a letter and be at least 8 characters long.';
}

// Path: bottomSheets.signup.form.nickname
class TranslationsBottomSheetsSignupFormNicknameEn {
	TranslationsBottomSheetsSignupFormNicknameEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Nickname';
	String get hintText => 'Please enter your nickname';
	String get helperText => 'Nickname cannot be longer than 20 characters';
	String get errorText => 'Nickname cannot be longer than 20 characters';
}

// Path: bottomSheets.signup.form.email
class TranslationsBottomSheetsSignupFormEmailEn {
	TranslationsBottomSheetsSignupFormEmailEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Email';
	String get hintText => 'Please enter your email';
	String get errorText => 'Please enter your email';
	String get errorText2 => 'The email format you entered is wrong';
}

// Path: bottomSheets.signup.form.password
class TranslationsBottomSheetsSignupFormPasswordEn {
	TranslationsBottomSheetsSignupFormPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get helperText => 'Please enter at least 8 characters';
}

// Path: bottomSheets.signup.form.repeatPassword
class TranslationsBottomSheetsSignupFormRepeatPasswordEn {
	TranslationsBottomSheetsSignupFormRepeatPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Repeat password';
	String get hintText => 'Please enter your password again';
	String get errorText => 'Please enter your password again';
	String get errorText2 => 'The passwords entered twice are different';
}

// Path: pages.emoji.dialogs.upload.buttons
class TranslationsPagesEmojiDialogsUploadButtonsEn {
	TranslationsPagesEmojiDialogsUploadButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get upload => 'Upload';
}

// Path: pages.emoji.dialogs.upload.tips
class TranslationsPagesEmojiDialogsUploadTipsEn {
	TranslationsPagesEmojiDialogsUploadTipsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get prefix => 'You can upload up to 9 images';
	String get suffix => 'Image size must be between 50KB and 15MB';
}

// Path: pages.emoji.dialogs.upload.form
class TranslationsPagesEmojiDialogsUploadFormEn {
	TranslationsPagesEmojiDialogsUploadFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesEmojiDialogsUploadFormEmojisEn emojis = TranslationsPagesEmojiDialogsUploadFormEmojisEn._(_root);
}

// Path: pages.feedback.dialogs.upload.buttons
class TranslationsPagesFeedbackDialogsUploadButtonsEn {
	TranslationsPagesFeedbackDialogsUploadButtonsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get upload => 'Submit';
}

// Path: pages.feedback.dialogs.upload.form
class TranslationsPagesFeedbackDialogsUploadFormEn {
	TranslationsPagesFeedbackDialogsUploadFormEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsPagesFeedbackDialogsUploadFormTitleEn title = TranslationsPagesFeedbackDialogsUploadFormTitleEn._(_root);
	late final TranslationsPagesFeedbackDialogsUploadFormDescriptionEn description = TranslationsPagesFeedbackDialogsUploadFormDescriptionEn._(_root);
	late final TranslationsPagesFeedbackDialogsUploadFormAssetsEn assets = TranslationsPagesFeedbackDialogsUploadFormAssetsEn._(_root);
}

// Path: pages.feedback.dialogs.upload.error
class TranslationsPagesFeedbackDialogsUploadErrorEn {
	TranslationsPagesFeedbackDialogsUploadErrorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get image => 'Uploaded images must be between 15KB and 15MB';
	String get video => 'Uploaded videos must be between 15KB and 15MB';
}

// Path: pages.emoji.dialogs.upload.form.emojis
class TranslationsPagesEmojiDialogsUploadFormEmojisEn {
	TranslationsPagesEmojiDialogsUploadFormEmojisEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get errorText => 'Please select emojis you want to upload';
}

// Path: pages.feedback.dialogs.upload.form.title
class TranslationsPagesFeedbackDialogsUploadFormTitleEn {
	TranslationsPagesFeedbackDialogsUploadFormTitleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Title';
	String get hintText => 'Please enter a title';
	String get errorText => 'Please enter a title';
}

// Path: pages.feedback.dialogs.upload.form.description
class TranslationsPagesFeedbackDialogsUploadFormDescriptionEn {
	TranslationsPagesFeedbackDialogsUploadFormDescriptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Description';
	String get hintText => 'Please enter a description';
	String get errorText => 'Please enter a description';
}

// Path: pages.feedback.dialogs.upload.form.assets
class TranslationsPagesFeedbackDialogsUploadFormAssetsEn {
	TranslationsPagesFeedbackDialogsUploadFormAssetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	String get title => 'Picture or video';
	String get prefix => 'You can upload up to 9 pictures or videos';
	String get suffix => 'Image size must be between 50KB and 15MB, video size must be between 50KB and 20MB';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on Translations {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Pigeon';
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
			case 'dialogs.license.contentContent': return 'Protecting user\'s privacy and personal information is a fundamental principle of Pigeon.';
			case 'dialogs.license.contentTip': return 'Below is a list of permissions required by this APP:';
			case 'dialogs.license.contentPrefix': return 'Before you use this APP\'s services, please carefully read and agree to the ';
			case 'dialogs.license.contentUserAgreement': return 'User Agreement';
			case 'dialogs.license.contentAnd': return ' and ';
			case 'dialogs.license.contentPrivacyAgreement': return 'Privacy Agreement';
			case 'dialogs.license.contentSuffix': return ', start using our services after you agree and accept all terms.';
			case 'dialogs.license.iosPermissions.0': return 'For you to take pictures, Pigeon needs access to your Camera. (NSCameraUsageDescription)';
			case 'dialogs.license.iosPermissions.1': return 'For you to upload pictures, Pigeon needs access to your Photos. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.license.androidPermissions.0': return 'Used for data interaction between the application and the server, Pigeon needs access to your Internet. (android.permission.INTERNET)';
			case 'dialogs.license.androidPermissions.1': return 'In order to send you notifications, Pigeon needs access to your permission. (android.permission.POST_NOTIFICATIONS)';
			case 'dialogs.license.androidPermissions.2': return 'For you to upload pictures, Pigeon needs access to your Storage. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.3': return 'For you to save pictures, Pigeon needs access to your Storage. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.4': return 'For you to upload pictures, Pigeon needs access to your Photos. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.license.androidPermissions.5': return 'For you to upload videos, Pigeon needs access to your Videos. (android.permission.READ_MEDIA_VIDEO)';
			case 'dialogs.license.androidPermissions.6': return 'For you to take pictures, Pigeon needs access to your Camera. (android.permission.CAMERA)';
			case 'dialogs.license.androidPermissions.7': return 'In order to send you local notifications, Pigeon needs access to your permission. (android.permission.RECEIVE_BOOT_COMPLETED)';
			case 'dialogs.album.title': return 'Allow access to your album';
			case 'dialogs.album.description': return 'Please go to your phone Settings to grant Pigeon the permission to visit your album.';
			case 'locales.en': return 'English';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

