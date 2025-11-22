import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of PkgL10n
/// returned by `PkgL10n.of(context)`.
///
/// Applications need to include `PkgL10n.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PkgL10n.localizationsDelegates,
///   supportedLocales: PkgL10n.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the PkgL10n.supportedLocales
/// property.
abstract class PkgL10n {
  PkgL10n(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PkgL10n of(BuildContext context) {
    return Localizations.of<PkgL10n>(context, PkgL10n)!;
  }

  static const LocalizationsDelegate<PkgL10n> delegate = _PkgL10nDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  /// No description provided for @monthsAgo.
  ///
  /// In zh, this message translates to:
  /// **'{diff}个月前'**
  String monthsAgo(Object diff);

  /// No description provided for @yearsAgo.
  ///
  /// In zh, this message translates to:
  /// **'{diff}年前'**
  String yearsAgo(Object diff);

  /// No description provided for @weeksAgo.
  ///
  /// In zh, this message translates to:
  /// **'{diff}周前'**
  String weeksAgo(Object diff);

  /// No description provided for @daysAgo.
  ///
  /// In zh, this message translates to:
  /// **'{diff}天前'**
  String daysAgo(Object diff);

  /// No description provided for @hoursAgo.
  ///
  /// In zh, this message translates to:
  /// **'{diff}小时前'**
  String hoursAgo(Object diff);

  /// No description provided for @minutesAgo.
  ///
  /// In zh, this message translates to:
  /// **'{diff}分钟前'**
  String minutesAgo(Object diff);

  /// No description provided for @commentsOfPackage.
  ///
  /// In zh, this message translates to:
  /// **'{packageName} 的评论'**
  String commentsOfPackage(Object packageName);

  /// No description provided for @downloadsLast30Days.
  ///
  /// In zh, this message translates to:
  /// **'30 日下载量'**
  String get downloadsLast30Days;

  /// No description provided for @flutterPluginRepo.
  ///
  /// In zh, this message translates to:
  /// **'Flutter插件库'**
  String get flutterPluginRepo;

  /// No description provided for @downloads.
  ///
  /// In zh, this message translates to:
  /// **'下载量'**
  String get downloads;

  /// No description provided for @home.
  ///
  /// In zh, this message translates to:
  /// **'主页'**
  String get home;

  /// No description provided for @theme.
  ///
  /// In zh, this message translates to:
  /// **'主题'**
  String get theme;

  /// No description provided for @today.
  ///
  /// In zh, this message translates to:
  /// **'今天'**
  String get today;

  /// No description provided for @repository.
  ///
  /// In zh, this message translates to:
  /// **'仓库:'**
  String get repository;

  /// No description provided for @dependencies.
  ///
  /// In zh, this message translates to:
  /// **'依赖关系'**
  String get dependencies;

  /// No description provided for @saveImage.
  ///
  /// In zh, this message translates to:
  /// **'保存图片'**
  String get saveImage;

  /// No description provided for @saveFailed.
  ///
  /// In zh, this message translates to:
  /// **'保存失败: {error}'**
  String saveFailed(Object error);

  /// No description provided for @allComments.
  ///
  /// In zh, this message translates to:
  /// **'全部评论'**
  String get allComments;

  /// No description provided for @others.
  ///
  /// In zh, this message translates to:
  /// **'其他'**
  String get others;

  /// No description provided for @writeReplyHint.
  ///
  /// In zh, this message translates to:
  /// **'写下你的回复...'**
  String get writeReplyHint;

  /// No description provided for @writeCommentHint.
  ///
  /// In zh, this message translates to:
  /// **'写下你的评论...'**
  String get writeCommentHint;

  /// No description provided for @writeComment.
  ///
  /// In zh, this message translates to:
  /// **'写评论'**
  String get writeComment;

  /// No description provided for @share.
  ///
  /// In zh, this message translates to:
  /// **'分享'**
  String get share;

  /// No description provided for @shareFeatureDeveloping.
  ///
  /// In zh, this message translates to:
  /// **'分享功能开发中...'**
  String get shareFeatureDeveloping;

  /// No description provided for @shareCard.
  ///
  /// In zh, this message translates to:
  /// **'分享卡片'**
  String get shareCard;

  /// No description provided for @score.
  ///
  /// In zh, this message translates to:
  /// **'分数'**
  String get score;

  /// No description provided for @justNow.
  ///
  /// In zh, this message translates to:
  /// **'刚刚'**
  String get justNow;

  /// No description provided for @loadFailed.
  ///
  /// In zh, this message translates to:
  /// **'加载失败'**
  String get loadFailed;

  /// No description provided for @loadFailedWithMessage.
  ///
  /// In zh, this message translates to:
  /// **'加载失败: {message}'**
  String loadFailedWithMessage(Object message);

  /// No description provided for @loadMore10.
  ///
  /// In zh, this message translates to:
  /// **'加载更多(10)'**
  String get loadMore10;

  /// No description provided for @loadingComments.
  ///
  /// In zh, this message translates to:
  /// **'加载评论中...'**
  String get loadingComments;

  /// No description provided for @packageNameLabel.
  ///
  /// In zh, this message translates to:
  /// **'包名称'**
  String get packageNameLabel;

  /// No description provided for @packageFeatures.
  ///
  /// In zh, this message translates to:
  /// **'包的特点'**
  String get packageFeatures;

  /// No description provided for @publishTime.
  ///
  /// In zh, this message translates to:
  /// **'发布时间'**
  String get publishTime;

  /// No description provided for @publisher.
  ///
  /// In zh, this message translates to:
  /// **'发布者'**
  String get publisher;

  /// No description provided for @send.
  ///
  /// In zh, this message translates to:
  /// **'发送'**
  String get send;

  /// No description provided for @cancel.
  ///
  /// In zh, this message translates to:
  /// **'取消'**
  String get cancel;

  /// No description provided for @like.
  ///
  /// In zh, this message translates to:
  /// **'喜欢'**
  String get like;

  /// No description provided for @likeCount.
  ///
  /// In zh, this message translates to:
  /// **'喜欢人数'**
  String get likeCount;

  /// No description provided for @likes.
  ///
  /// In zh, this message translates to:
  /// **'喜欢数'**
  String get likes;

  /// No description provided for @reply.
  ///
  /// In zh, this message translates to:
  /// **'回复'**
  String get reply;

  /// No description provided for @replyToGuest.
  ///
  /// In zh, this message translates to:
  /// **'回复 {guestName}'**
  String replyToGuest(Object guestName);

  /// No description provided for @replyToParent.
  ///
  /// In zh, this message translates to:
  /// **'回复 @{parentGuestName}'**
  String replyToParent(Object parentGuestName);

  /// No description provided for @replyCommentHint.
  ///
  /// In zh, this message translates to:
  /// **'回复评论...'**
  String get replyCommentHint;

  /// No description provided for @replyDetails.
  ///
  /// In zh, this message translates to:
  /// **'回复详情'**
  String get replyDetails;

  /// No description provided for @copyLink.
  ///
  /// In zh, this message translates to:
  /// **'复制链接'**
  String get copyLink;

  /// No description provided for @platform.
  ///
  /// In zh, this message translates to:
  /// **'平台'**
  String get platform;

  /// No description provided for @firstCommentPrompt.
  ///
  /// In zh, this message translates to:
  /// **'成为第一个评论的人吧'**
  String get firstCommentPrompt;

  /// No description provided for @sortMethod.
  ///
  /// In zh, this message translates to:
  /// **'排序方式'**
  String get sortMethod;

  /// No description provided for @recommendNotice.
  ///
  /// In zh, this message translates to:
  /// **'推荐后，经过审核采纳，该包将收录到 FlutterUnit 插件库中，供更多开发者发现和使用。'**
  String get recommendNotice;

  /// No description provided for @recommendSubmitted.
  ///
  /// In zh, this message translates to:
  /// **'推荐已提交，感谢您的贡献！'**
  String get recommendSubmitted;

  /// No description provided for @recommendPlugin.
  ///
  /// In zh, this message translates to:
  /// **'推荐插件'**
  String get recommendPlugin;

  /// No description provided for @recommendDescription.
  ///
  /// In zh, this message translates to:
  /// **'推荐说明'**
  String get recommendDescription;

  /// No description provided for @submitFailedWithMsg.
  ///
  /// In zh, this message translates to:
  /// **'提交失败：{msg}'**
  String submitFailedWithMsg(Object msg);

  /// No description provided for @submitFailedNetwork.
  ///
  /// In zh, this message translates to:
  /// **'提交失败：网络错误'**
  String get submitFailedNetwork;

  /// No description provided for @submitRecommendation.
  ///
  /// In zh, this message translates to:
  /// **'提交推荐'**
  String get submitRecommendation;

  /// No description provided for @plugin.
  ///
  /// In zh, this message translates to:
  /// **'插件'**
  String get plugin;

  /// No description provided for @pluginScore.
  ///
  /// In zh, this message translates to:
  /// **'插件分数'**
  String get pluginScore;

  /// No description provided for @yesterday.
  ///
  /// In zh, this message translates to:
  /// **'昨天'**
  String get yesterday;

  /// No description provided for @noReply.
  ///
  /// In zh, this message translates to:
  /// **'暂无回复'**
  String get noReply;

  /// No description provided for @noDescription.
  ///
  /// In zh, this message translates to:
  /// **'暂无描述'**
  String get noDescription;

  /// No description provided for @noData.
  ///
  /// In zh, this message translates to:
  /// **'暂无数据'**
  String get noData;

  /// No description provided for @noComments.
  ///
  /// In zh, this message translates to:
  /// **'暂无评论'**
  String get noComments;

  /// No description provided for @lastRelease.
  ///
  /// In zh, this message translates to:
  /// **'最后发布'**
  String get lastRelease;

  /// No description provided for @unknownCategory.
  ///
  /// In zh, this message translates to:
  /// **'未知分类'**
  String get unknownCategory;

  /// No description provided for @unknownPublisher.
  ///
  /// In zh, this message translates to:
  /// **'未知发布者'**
  String get unknownPublisher;

  /// No description provided for @unknownUser.
  ///
  /// In zh, this message translates to:
  /// **'未知用户'**
  String get unknownUser;

  /// No description provided for @viewAll.
  ///
  /// In zh, this message translates to:
  /// **'查看所有'**
  String get viewAll;

  /// No description provided for @viewMoreReplies.
  ///
  /// In zh, this message translates to:
  /// **'查看更多 {moreCount} 条回复'**
  String viewMoreReplies(Object moreCount);

  /// No description provided for @tagList.
  ///
  /// In zh, this message translates to:
  /// **'标签一览'**
  String get tagList;

  /// No description provided for @addComment.
  ///
  /// In zh, this message translates to:
  /// **'添加评论'**
  String get addComment;

  /// No description provided for @guest.
  ///
  /// In zh, this message translates to:
  /// **'游客'**
  String get guest;

  /// No description provided for @type.
  ///
  /// In zh, this message translates to:
  /// **'类型'**
  String get type;

  /// No description provided for @highlightAnswer.
  ///
  /// In zh, this message translates to:
  /// **'精答'**
  String get highlightAnswer;

  /// No description provided for @license.
  ///
  /// In zh, this message translates to:
  /// **'许可证'**
  String get license;

  /// No description provided for @commentContent.
  ///
  /// In zh, this message translates to:
  /// **'评论内容'**
  String get commentContent;

  /// No description provided for @describePackageFeatureHint.
  ///
  /// In zh, this message translates to:
  /// **'请描述包的特点'**
  String get describePackageFeatureHint;

  /// No description provided for @describePluginForRecommend.
  ///
  /// In zh, this message translates to:
  /// **'请描述这个包的主要功能和特点，为什么推荐它...'**
  String get describePluginForRecommend;

  /// No description provided for @requestSuccess.
  ///
  /// In zh, this message translates to:
  /// **'请求成功!'**
  String get requestSuccess;

  /// No description provided for @minDescriptionLength.
  ///
  /// In zh, this message translates to:
  /// **'请至少输入10个字符的描述'**
  String get minDescriptionLength;

  /// No description provided for @enterPackageName.
  ///
  /// In zh, this message translates to:
  /// **'请输入包名称'**
  String get enterPackageName;

  /// No description provided for @enterPackageExample.
  ///
  /// In zh, this message translates to:
  /// **'请输入包名称，如：dio'**
  String get enterPackageExample;

  /// No description provided for @linkCopied.
  ///
  /// In zh, this message translates to:
  /// **'链接已复制到剪贴板'**
  String get linkCopied;

  /// No description provided for @needGalleryPermission.
  ///
  /// In zh, this message translates to:
  /// **'需要相册权限才能保存图片'**
  String get needGalleryPermission;
}

class _PkgL10nDelegate extends LocalizationsDelegate<PkgL10n> {
  const _PkgL10nDelegate();

  @override
  Future<PkgL10n> load(Locale locale) {
    return SynchronousFuture<PkgL10n>(lookupPkgL10n(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_PkgL10nDelegate old) => false;
}

PkgL10n lookupPkgL10n(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return PkgL10nEn();
    case 'zh': return PkgL10nZh();
  }

  throw FlutterError(
    'PkgL10n.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
