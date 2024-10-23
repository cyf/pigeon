///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZh implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
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

	late final TranslationsZh _root = this; // ignore: unused_field

	// Translations
	@override String get appName => 'Pigeon';
	@override late final _TranslationsCommonZh common = _TranslationsCommonZh._(_root);
	@override late final _TranslationsPagesZh pages = _TranslationsPagesZh._(_root);
	@override late final _TranslationsButtonsZh buttons = _TranslationsButtonsZh._(_root);
	@override late final _TranslationsBottomSheetsZh bottomSheets = _TranslationsBottomSheetsZh._(_root);
	@override late final _TranslationsDialogsZh dialogs = _TranslationsDialogsZh._(_root);
	@override Map<String, String> get locales => {
		'en': 'English',
		'zh': '中文',
	};
}

// Path: common
class _TranslationsCommonZh implements TranslationsCommonEn {
	_TranslationsCommonZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get copied => '已复制';
	@override String get success => '成功啦😊';
	@override String get failure => '失败啦😭';
	@override String get noData => '没有数据, 点击以重新加载😭';
}

// Path: pages
class _TranslationsPagesZh implements TranslationsPagesEn {
	_TranslationsPagesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesHomeZh home = _TranslationsPagesHomeZh._(_root);
	@override late final _TranslationsPagesEmojiZh emoji = _TranslationsPagesEmojiZh._(_root);
	@override late final _TranslationsPagesFeedbackZh feedback = _TranslationsPagesFeedbackZh._(_root);
	@override late final _TranslationsPagesFeedbackDetailZh feedbackDetail = _TranslationsPagesFeedbackDetailZh._(_root);
	@override late final _TranslationsPagesLiveZh live = _TranslationsPagesLiveZh._(_root);
	@override late final _TranslationsPagesMovieZh movie = _TranslationsPagesMovieZh._(_root);
	@override late final _TranslationsPagesRoadmapZh roadmap = _TranslationsPagesRoadmapZh._(_root);
	@override late final _TranslationsPagesSocialZh social = _TranslationsPagesSocialZh._(_root);
}

// Path: buttons
class _TranslationsButtonsZh implements TranslationsButtonsEn {
	_TranslationsButtonsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

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
class _TranslationsBottomSheetsZh implements TranslationsBottomSheetsEn {
	_TranslationsBottomSheetsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBottomSheetsLoginZh login = _TranslationsBottomSheetsLoginZh._(_root);
	@override late final _TranslationsBottomSheetsSignupZh signup = _TranslationsBottomSheetsSignupZh._(_root);
	@override late final _TranslationsBottomSheetsStoreZh store = _TranslationsBottomSheetsStoreZh._(_root);
}

// Path: dialogs
class _TranslationsDialogsZh implements TranslationsDialogsEn {
	_TranslationsDialogsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDialogsLicenseZh license = _TranslationsDialogsLicenseZh._(_root);
	@override late final _TranslationsDialogsAlbumZh album = _TranslationsDialogsAlbumZh._(_root);
}

// Path: pages.home
class _TranslationsPagesHomeZh implements TranslationsPagesHomeEn {
	_TranslationsPagesHomeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesHomePrimaryZh primary = _TranslationsPagesHomePrimaryZh._(_root);
	@override late final _TranslationsPagesHomeOtherZh other = _TranslationsPagesHomeOtherZh._(_root);
	@override String get version => '版本号';
}

// Path: pages.emoji
class _TranslationsPagesEmojiZh implements TranslationsPagesEmojiEn {
	_TranslationsPagesEmojiZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '表情库～';
	@override late final _TranslationsPagesEmojiTipsZh tips = _TranslationsPagesEmojiTipsZh._(_root);
	@override late final _TranslationsPagesEmojiDialogsZh dialogs = _TranslationsPagesEmojiDialogsZh._(_root);
}

// Path: pages.feedback
class _TranslationsPagesFeedbackZh implements TranslationsPagesFeedbackEn {
	_TranslationsPagesFeedbackZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '意见或建议';
	@override late final _TranslationsPagesFeedbackTipsZh tips = _TranslationsPagesFeedbackTipsZh._(_root);
	@override late final _TranslationsPagesFeedbackDialogsZh dialogs = _TranslationsPagesFeedbackDialogsZh._(_root);
}

// Path: pages.feedbackDetail
class _TranslationsPagesFeedbackDetailZh implements TranslationsPagesFeedbackDetailEn {
	_TranslationsPagesFeedbackDetailZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '反馈详情';
}

// Path: pages.live
class _TranslationsPagesLiveZh implements TranslationsPagesLiveEn {
	_TranslationsPagesLiveZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '直播～';
}

// Path: pages.movie
class _TranslationsPagesMovieZh implements TranslationsPagesMovieEn {
	_TranslationsPagesMovieZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '电影';
}

// Path: pages.roadmap
class _TranslationsPagesRoadmapZh implements TranslationsPagesRoadmapEn {
	_TranslationsPagesRoadmapZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '路线图';
}

// Path: pages.social
class _TranslationsPagesSocialZh implements TranslationsPagesSocialEn {
	_TranslationsPagesSocialZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '社交';
}

// Path: bottomSheets.login
class _TranslationsBottomSheetsLoginZh implements TranslationsBottomSheetsLoginEn {
	_TranslationsBottomSheetsLoginZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get header => '请填写登录信息';
	@override late final _TranslationsBottomSheetsLoginFormZh form = _TranslationsBottomSheetsLoginFormZh._(_root);
	@override late final _TranslationsBottomSheetsLoginTipsZh tips = _TranslationsBottomSheetsLoginTipsZh._(_root);
}

// Path: bottomSheets.signup
class _TranslationsBottomSheetsSignupZh implements TranslationsBottomSheetsSignupEn {
	_TranslationsBottomSheetsSignupZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get header => '请填写注册信息';
	@override late final _TranslationsBottomSheetsSignupFormZh form = _TranslationsBottomSheetsSignupFormZh._(_root);
	@override late final _TranslationsBottomSheetsSignupTipsZh tips = _TranslationsBottomSheetsSignupTipsZh._(_root);
}

// Path: bottomSheets.store
class _TranslationsBottomSheetsStoreZh implements TranslationsBottomSheetsStoreEn {
	_TranslationsBottomSheetsStoreZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '请选择您的操作';
	@override late final _TranslationsBottomSheetsStoreCodeZh code = _TranslationsBottomSheetsStoreCodeZh._(_root);
	@override late final _TranslationsBottomSheetsStoreLinkZh link = _TranslationsBottomSheetsStoreLinkZh._(_root);
}

// Path: dialogs.license
class _TranslationsDialogsLicenseZh implements TranslationsDialogsLicenseEn {
	_TranslationsDialogsLicenseZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '隐私条款';
	@override String get contentContent => 'Pigeon 非常重视你的隐私保护和个人信息保护.';
	@override String get contentTip => '以下是该APP所需的权限列表:';
	@override String get contentPrefix => '在使用APP服务前, 请认真阅读 ';
	@override String get contentUserAgreement => '《隐私政策》';
	@override String get contentAnd => '和';
	@override String get contentPrivacyAgreement => '《用户服务协议》';
	@override String get contentSuffix => ', 你同意并接受全部条款后开始使用我们的服务.';
	@override List<String> get iosPermissions => [
		'为了让您拍摄照片, Pigeon 需要访问您的相机. (NSCameraUsageDescription)',
		'为了让您上传图片, Pigeon 需要访问您的照片. (NSPhotoLibraryUsageDescription)',
	];
	@override List<String> get androidPermissions => [
		'用于应用程序和服务器之间的数据交互, Pigeon 需要访问您的互联网. (android.permission.INTERNET)',
		'为了给您发送通知, Pigeon 需要获取您的权限. (android.permission.POST_NOTIFICATIONS)',
		'为了让您上传图片, Pigeon 需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)',
		'为了让您保存图片, Pigeon 需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)',
		'为了让您上传图片, Pigeon 需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)',
		'为了让您上传视频, Pigeon 需要访问您的视频. (android.permission.READ_MEDIA_VIDEO)',
		'为了让您拍摄照片, Pigeon 需要访问您的相机. (android.permission.CAMERA)',
		'为了向您发送本地通知, Pigeon 需要访问您的权限. (android.permission.RECEIVE_BOOT_COMPLETED)',
	];
}

// Path: dialogs.album
class _TranslationsDialogsAlbumZh implements TranslationsDialogsAlbumEn {
	_TranslationsDialogsAlbumZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '允许访问您的相册';
	@override String get description => '请前往您的手机设置授予Pigeon访问您相册的权限.';
}

// Path: pages.home.primary
class _TranslationsPagesHomePrimaryZh implements TranslationsPagesHomePrimaryEn {
	_TranslationsPagesHomePrimaryZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '主要功能';
	@override late final _TranslationsPagesHomePrimaryRatingZh rating = _TranslationsPagesHomePrimaryRatingZh._(_root);
	@override late final _TranslationsPagesHomePrimaryLiveZh live = _TranslationsPagesHomePrimaryLiveZh._(_root);
	@override late final _TranslationsPagesHomePrimarySettingsZh settings = _TranslationsPagesHomePrimarySettingsZh._(_root);
}

// Path: pages.home.other
class _TranslationsPagesHomeOtherZh implements TranslationsPagesHomeOtherEn {
	_TranslationsPagesHomeOtherZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '其他功能';
	@override late final _TranslationsPagesHomeOtherNotificationsZh notifications = _TranslationsPagesHomeOtherNotificationsZh._(_root);
	@override late final _TranslationsPagesHomeOtherStoreZh store = _TranslationsPagesHomeOtherStoreZh._(_root);
	@override late final _TranslationsPagesHomeOtherEmojiZh emoji = _TranslationsPagesHomeOtherEmojiZh._(_root);
	@override late final _TranslationsPagesHomeOtherFeedbackZh feedback = _TranslationsPagesHomeOtherFeedbackZh._(_root);
	@override late final _TranslationsPagesHomeOtherRoadmapZh roadmap = _TranslationsPagesHomeOtherRoadmapZh._(_root);
}

// Path: pages.emoji.tips
class _TranslationsPagesEmojiTipsZh implements TranslationsPagesEmojiTipsEn {
	_TranslationsPagesEmojiTipsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '欢迎投稿，嗷呜~';
	@override String get prefix => '欢迎';
	@override String get button => ' [点击此处] ';
	@override String get suffix => '投稿，可以是表情包，可以是文案创意，也可以是一些令猫尴尬的图片或截图等~😄';
}

// Path: pages.emoji.dialogs
class _TranslationsPagesEmojiDialogsZh implements TranslationsPagesEmojiDialogsEn {
	_TranslationsPagesEmojiDialogsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesEmojiDialogsUploadZh upload = _TranslationsPagesEmojiDialogsUploadZh._(_root);
}

// Path: pages.feedback.tips
class _TranslationsPagesFeedbackTipsZh implements TranslationsPagesFeedbackTipsEn {
	_TranslationsPagesFeedbackTipsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '欢迎提意见或建议，嗷呜~';
	@override String get prefix => '无论您遇到任何问题、意见或建议，均可';
	@override String get button => ' [点击此处] ';
	@override String get suffix => '进行反馈.';
}

// Path: pages.feedback.dialogs
class _TranslationsPagesFeedbackDialogsZh implements TranslationsPagesFeedbackDialogsEn {
	_TranslationsPagesFeedbackDialogsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesFeedbackDialogsUploadZh upload = _TranslationsPagesFeedbackDialogsUploadZh._(_root);
}

// Path: bottomSheets.login.form
class _TranslationsBottomSheetsLoginFormZh implements TranslationsBottomSheetsLoginFormEn {
	_TranslationsBottomSheetsLoginFormZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBottomSheetsLoginFormAccountZh account = _TranslationsBottomSheetsLoginFormAccountZh._(_root);
	@override late final _TranslationsBottomSheetsLoginFormPasswordZh password = _TranslationsBottomSheetsLoginFormPasswordZh._(_root);
	@override late final _TranslationsBottomSheetsLoginFormPrivacyZh privacy = _TranslationsBottomSheetsLoginFormPrivacyZh._(_root);
}

// Path: bottomSheets.login.tips
class _TranslationsBottomSheetsLoginTipsZh implements TranslationsBottomSheetsLoginTipsEn {
	_TranslationsBottomSheetsLoginTipsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get prefix => '已有账号, ';
	@override String get suffix => '去登录';
}

// Path: bottomSheets.signup.form
class _TranslationsBottomSheetsSignupFormZh implements TranslationsBottomSheetsSignupFormEn {
	_TranslationsBottomSheetsSignupFormZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsBottomSheetsSignupFormAccountZh account = _TranslationsBottomSheetsSignupFormAccountZh._(_root);
	@override late final _TranslationsBottomSheetsSignupFormNicknameZh nickname = _TranslationsBottomSheetsSignupFormNicknameZh._(_root);
	@override late final _TranslationsBottomSheetsSignupFormEmailZh email = _TranslationsBottomSheetsSignupFormEmailZh._(_root);
	@override late final _TranslationsBottomSheetsSignupFormPasswordZh password = _TranslationsBottomSheetsSignupFormPasswordZh._(_root);
	@override late final _TranslationsBottomSheetsSignupFormRepeatPasswordZh repeatPassword = _TranslationsBottomSheetsSignupFormRepeatPasswordZh._(_root);
}

// Path: bottomSheets.signup.tips
class _TranslationsBottomSheetsSignupTipsZh implements TranslationsBottomSheetsSignupTipsEn {
	_TranslationsBottomSheetsSignupTipsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get prefix => '还没有账号, ';
	@override String get suffix => '去注册';
}

// Path: bottomSheets.store.code
class _TranslationsBottomSheetsStoreCodeZh implements TranslationsBottomSheetsStoreCodeEn {
	_TranslationsBottomSheetsStoreCodeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '复制淘口令';
	@override String get description => '直播平台、时间等';
}

// Path: bottomSheets.store.link
class _TranslationsBottomSheetsStoreLinkZh implements TranslationsBottomSheetsStoreLinkEn {
	_TranslationsBottomSheetsStoreLinkZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '打开淘宝店地址';
	@override String get description => '寒潮啦! 来件卫衣吧~~';
}

// Path: pages.home.primary.rating
class _TranslationsPagesHomePrimaryRatingZh implements TranslationsPagesHomePrimaryRatingEn {
	_TranslationsPagesHomePrimaryRatingZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '电影打分系统';
	@override String get description => '给看过的电影打个分吧~~';
}

// Path: pages.home.primary.live
class _TranslationsPagesHomePrimaryLiveZh implements TranslationsPagesHomePrimaryLiveEn {
	_TranslationsPagesHomePrimaryLiveZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '直播预告';
	@override String get description => '查看详情';
}

// Path: pages.home.primary.settings
class _TranslationsPagesHomePrimarySettingsZh implements TranslationsPagesHomePrimarySettingsEn {
	_TranslationsPagesHomePrimarySettingsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '开播通知设置';
}

// Path: pages.home.other.notifications
class _TranslationsPagesHomeOtherNotificationsZh implements TranslationsPagesHomeOtherNotificationsEn {
	_TranslationsPagesHomeOtherNotificationsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '直播信息/提醒群';
	@override String get description => '直播平台、时间等';
}

// Path: pages.home.other.store
class _TranslationsPagesHomeOtherStoreZh implements TranslationsPagesHomeOtherStoreEn {
	_TranslationsPagesHomeOtherStoreZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '小德官方店: 喜瑞斯';
	@override String get description => '寒潮啦! 来件卫衣吧~~';
}

// Path: pages.home.other.emoji
class _TranslationsPagesHomeOtherEmojiZh implements TranslationsPagesHomeOtherEmojiEn {
	_TranslationsPagesHomeOtherEmojiZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '小德表情包🐱';
	@override String get description => '欢迎投稿~~';
}

// Path: pages.home.other.feedback
class _TranslationsPagesHomeOtherFeedbackZh implements TranslationsPagesHomeOtherFeedbackEn {
	_TranslationsPagesHomeOtherFeedbackZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '意见/建议';
	@override String get description => '无论您遇到任何问题、意见或建议, 均可反馈...';
}

// Path: pages.home.other.roadmap
class _TranslationsPagesHomeOtherRoadmapZh implements TranslationsPagesHomeOtherRoadmapEn {
	_TranslationsPagesHomeOtherRoadmapZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '路线图';
	@override String get description => '查看开发计划和进度😄';
}

// Path: pages.emoji.dialogs.upload
class _TranslationsPagesEmojiDialogsUploadZh implements TranslationsPagesEmojiDialogsUploadEn {
	_TranslationsPagesEmojiDialogsUploadZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesEmojiDialogsUploadButtonsZh buttons = _TranslationsPagesEmojiDialogsUploadButtonsZh._(_root);
	@override String get header => '请选择要上传的表情';
	@override late final _TranslationsPagesEmojiDialogsUploadTipsZh tips = _TranslationsPagesEmojiDialogsUploadTipsZh._(_root);
	@override late final _TranslationsPagesEmojiDialogsUploadFormZh form = _TranslationsPagesEmojiDialogsUploadFormZh._(_root);
	@override String get uploadFailed => '文件上传失败😭';
}

// Path: pages.feedback.dialogs.upload
class _TranslationsPagesFeedbackDialogsUploadZh implements TranslationsPagesFeedbackDialogsUploadEn {
	_TranslationsPagesFeedbackDialogsUploadZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesFeedbackDialogsUploadButtonsZh buttons = _TranslationsPagesFeedbackDialogsUploadButtonsZh._(_root);
	@override String get header => '请填写反馈内容';
	@override late final _TranslationsPagesFeedbackDialogsUploadFormZh form = _TranslationsPagesFeedbackDialogsUploadFormZh._(_root);
	@override late final _TranslationsPagesFeedbackDialogsUploadErrorZh error = _TranslationsPagesFeedbackDialogsUploadErrorZh._(_root);
	@override String get uploadFailed => '文件上传失败😭';
}

// Path: bottomSheets.login.form.account
class _TranslationsBottomSheetsLoginFormAccountZh implements TranslationsBottomSheetsLoginFormAccountEn {
	_TranslationsBottomSheetsLoginFormAccountZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '账号';
	@override String get hintText => '请输入账号';
	@override String get errorText => '请输入账号';
	@override String get errorText2 => '请输入至少8个字符';
}

// Path: bottomSheets.login.form.password
class _TranslationsBottomSheetsLoginFormPasswordZh implements TranslationsBottomSheetsLoginFormPasswordEn {
	_TranslationsBottomSheetsLoginFormPasswordZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '密码';
	@override String get hintText => '请输入密码';
	@override String get errorText => '请输入密码';
	@override String get errorText2 => '请输入至少8个字符';
}

// Path: bottomSheets.login.form.privacy
class _TranslationsBottomSheetsLoginFormPrivacyZh implements TranslationsBottomSheetsLoginFormPrivacyEn {
	_TranslationsBottomSheetsLoginFormPrivacyZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '隐私协议';
	@override String get prefix => '我已仔细阅读并同意';
	@override String get privacy => '隐私政策';
	@override String get and => '以及';
	@override String get terms => '条款和条件';
	@override String get errorText => '请同意隐私协议';
}

// Path: bottomSheets.signup.form.account
class _TranslationsBottomSheetsSignupFormAccountZh implements TranslationsBottomSheetsSignupFormAccountEn {
	_TranslationsBottomSheetsSignupFormAccountZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get helperText => '只能包含英文, 数字或下划线, 且只能以字母开头, 至少8个字符';
	@override String get errorText2 => '账号只能包含英文,数字或下划线, 且只能以字母开头, 至少8个字符';
}

// Path: bottomSheets.signup.form.nickname
class _TranslationsBottomSheetsSignupFormNicknameZh implements TranslationsBottomSheetsSignupFormNicknameEn {
	_TranslationsBottomSheetsSignupFormNicknameZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '昵称';
	@override String get hintText => '请输入昵称';
	@override String get helperText => '不能多于20个字符';
	@override String get errorText => '昵称长度不能大于20';
}

// Path: bottomSheets.signup.form.email
class _TranslationsBottomSheetsSignupFormEmailZh implements TranslationsBottomSheetsSignupFormEmailEn {
	_TranslationsBottomSheetsSignupFormEmailZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '邮箱';
	@override String get hintText => '请输入邮箱';
	@override String get errorText => '请输入邮箱';
	@override String get errorText2 => '邮箱格式错误';
}

// Path: bottomSheets.signup.form.password
class _TranslationsBottomSheetsSignupFormPasswordZh implements TranslationsBottomSheetsSignupFormPasswordEn {
	_TranslationsBottomSheetsSignupFormPasswordZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get helperText => '请输入至少8个字符';
}

// Path: bottomSheets.signup.form.repeatPassword
class _TranslationsBottomSheetsSignupFormRepeatPasswordZh implements TranslationsBottomSheetsSignupFormRepeatPasswordEn {
	_TranslationsBottomSheetsSignupFormRepeatPasswordZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '账号';
	@override String get hintText => '请再次输入密码';
	@override String get errorText => '请再次输入密码';
	@override String get errorText2 => '两次输入的密码不一样';
}

// Path: pages.emoji.dialogs.upload.buttons
class _TranslationsPagesEmojiDialogsUploadButtonsZh implements TranslationsPagesEmojiDialogsUploadButtonsEn {
	_TranslationsPagesEmojiDialogsUploadButtonsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get upload => '上传';
}

// Path: pages.emoji.dialogs.upload.tips
class _TranslationsPagesEmojiDialogsUploadTipsZh implements TranslationsPagesEmojiDialogsUploadTipsEn {
	_TranslationsPagesEmojiDialogsUploadTipsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get prefix => '您最多可以上传9张图片';
	@override String get suffix => '图片大小必须在50KB到15MB之间';
}

// Path: pages.emoji.dialogs.upload.form
class _TranslationsPagesEmojiDialogsUploadFormZh implements TranslationsPagesEmojiDialogsUploadFormEn {
	_TranslationsPagesEmojiDialogsUploadFormZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesEmojiDialogsUploadFormEmojisZh emojis = _TranslationsPagesEmojiDialogsUploadFormEmojisZh._(_root);
}

// Path: pages.feedback.dialogs.upload.buttons
class _TranslationsPagesFeedbackDialogsUploadButtonsZh implements TranslationsPagesFeedbackDialogsUploadButtonsEn {
	_TranslationsPagesFeedbackDialogsUploadButtonsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get upload => '提交';
}

// Path: pages.feedback.dialogs.upload.form
class _TranslationsPagesFeedbackDialogsUploadFormZh implements TranslationsPagesFeedbackDialogsUploadFormEn {
	_TranslationsPagesFeedbackDialogsUploadFormZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsPagesFeedbackDialogsUploadFormTitleZh title = _TranslationsPagesFeedbackDialogsUploadFormTitleZh._(_root);
	@override late final _TranslationsPagesFeedbackDialogsUploadFormDescriptionZh description = _TranslationsPagesFeedbackDialogsUploadFormDescriptionZh._(_root);
	@override late final _TranslationsPagesFeedbackDialogsUploadFormAssetsZh assets = _TranslationsPagesFeedbackDialogsUploadFormAssetsZh._(_root);
}

// Path: pages.feedback.dialogs.upload.error
class _TranslationsPagesFeedbackDialogsUploadErrorZh implements TranslationsPagesFeedbackDialogsUploadErrorEn {
	_TranslationsPagesFeedbackDialogsUploadErrorZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get image => '上传的图片必须在15KB至15MB之间';
	@override String get video => '上传的视频必须在15KB至20MB之间';
}

// Path: pages.emoji.dialogs.upload.form.emojis
class _TranslationsPagesEmojiDialogsUploadFormEmojisZh implements TranslationsPagesEmojiDialogsUploadFormEmojisEn {
	_TranslationsPagesEmojiDialogsUploadFormEmojisZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get errorText => '请选择要上传的表情';
}

// Path: pages.feedback.dialogs.upload.form.title
class _TranslationsPagesFeedbackDialogsUploadFormTitleZh implements TranslationsPagesFeedbackDialogsUploadFormTitleEn {
	_TranslationsPagesFeedbackDialogsUploadFormTitleZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '标题';
	@override String get hintText => '请输入标题';
	@override String get errorText => '请输入标题';
}

// Path: pages.feedback.dialogs.upload.form.description
class _TranslationsPagesFeedbackDialogsUploadFormDescriptionZh implements TranslationsPagesFeedbackDialogsUploadFormDescriptionEn {
	_TranslationsPagesFeedbackDialogsUploadFormDescriptionZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '描述';
	@override String get hintText => '请输入描述';
	@override String get errorText => '请输入描述';
}

// Path: pages.feedback.dialogs.upload.form.assets
class _TranslationsPagesFeedbackDialogsUploadFormAssetsZh implements TranslationsPagesFeedbackDialogsUploadFormAssetsEn {
	_TranslationsPagesFeedbackDialogsUploadFormAssetsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '图片或视频';
	@override String get prefix => '您最多可以上传9张图片或视频';
	@override String get suffix => '图片大小必须在50KB到15MB之间, 视频大小必须在50KB到20MB之间';
}

/// Flat map(s) containing all translations.
/// Only for edge cases! For simple maps, use the map function of this library.
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		switch (path) {
			case 'appName': return 'Pigeon';
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
			case 'dialogs.license.contentContent': return 'Pigeon 非常重视你的隐私保护和个人信息保护.';
			case 'dialogs.license.contentTip': return '以下是该APP所需的权限列表:';
			case 'dialogs.license.contentPrefix': return '在使用APP服务前, 请认真阅读 ';
			case 'dialogs.license.contentUserAgreement': return '《隐私政策》';
			case 'dialogs.license.contentAnd': return '和';
			case 'dialogs.license.contentPrivacyAgreement': return '《用户服务协议》';
			case 'dialogs.license.contentSuffix': return ', 你同意并接受全部条款后开始使用我们的服务.';
			case 'dialogs.license.iosPermissions.0': return '为了让您拍摄照片, Pigeon 需要访问您的相机. (NSCameraUsageDescription)';
			case 'dialogs.license.iosPermissions.1': return '为了让您上传图片, Pigeon 需要访问您的照片. (NSPhotoLibraryUsageDescription)';
			case 'dialogs.license.androidPermissions.0': return '用于应用程序和服务器之间的数据交互, Pigeon 需要访问您的互联网. (android.permission.INTERNET)';
			case 'dialogs.license.androidPermissions.1': return '为了给您发送通知, Pigeon 需要获取您的权限. (android.permission.POST_NOTIFICATIONS)';
			case 'dialogs.license.androidPermissions.2': return '为了让您上传图片, Pigeon 需要访问您的存储. (android.permission.READ_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.3': return '为了让您保存图片, Pigeon 需要访问您的存储. (android.permission.WRITE_EXTERNAL_STORAGE)';
			case 'dialogs.license.androidPermissions.4': return '为了让您上传图片, Pigeon 需要访问您的照片. (android.permission.READ_MEDIA_IMAGES)';
			case 'dialogs.license.androidPermissions.5': return '为了让您上传视频, Pigeon 需要访问您的视频. (android.permission.READ_MEDIA_VIDEO)';
			case 'dialogs.license.androidPermissions.6': return '为了让您拍摄照片, Pigeon 需要访问您的相机. (android.permission.CAMERA)';
			case 'dialogs.license.androidPermissions.7': return '为了向您发送本地通知, Pigeon 需要访问您的权限. (android.permission.RECEIVE_BOOT_COMPLETED)';
			case 'dialogs.album.title': return '允许访问您的相册';
			case 'dialogs.album.description': return '请前往您的手机设置授予Pigeon访问您相册的权限.';
			case 'locales.en': return 'English';
			case 'locales.zh': return '中文';
			default: return null;
		}
	}
}

