import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class PkgL10nZh extends PkgL10n {
  PkgL10nZh([String locale = 'zh']) : super(locale);

  @override
  String monthsAgo(Object diff) {
    return '$diff个月前';
  }

  @override
  String yearsAgo(Object diff) {
    return '$diff年前';
  }

  @override
  String weeksAgo(Object diff) {
    return '$diff周前';
  }

  @override
  String daysAgo(Object diff) {
    return '$diff天前';
  }

  @override
  String hoursAgo(Object diff) {
    return '$diff小时前';
  }

  @override
  String minutesAgo(Object diff) {
    return '$diff分钟前';
  }

  @override
  String commentsOfPackage(Object packageName) {
    return '$packageName 的评论';
  }

  @override
  String get downloadsLast30Days => '30 日下载量';

  @override
  String get flutterPluginRepo => 'Flutter插件库';

  @override
  String get downloads => '下载量';

  @override
  String get home => '主页';

  @override
  String get theme => '主题';

  @override
  String get today => '今天';

  @override
  String get repository => '仓库:';

  @override
  String get dependencies => '依赖关系';

  @override
  String get saveImage => '保存图片';

  @override
  String saveFailed(Object error) {
    return '保存失败: $error';
  }

  @override
  String get allComments => '全部评论';

  @override
  String get others => '其他';

  @override
  String get writeReplyHint => '写下你的回复...';

  @override
  String get writeCommentHint => '写下你的评论...';

  @override
  String get writeComment => '写评论';

  @override
  String get share => '分享';

  @override
  String get shareFeatureDeveloping => '分享功能开发中...';

  @override
  String get shareCard => '分享卡片';

  @override
  String get score => '分数';

  @override
  String get justNow => '刚刚';

  @override
  String get loadFailed => '加载失败';

  @override
  String loadFailedWithMessage(Object message) {
    return '加载失败: $message';
  }

  @override
  String get loadMore10 => '加载更多(10)';

  @override
  String get loadingComments => '加载评论中...';

  @override
  String get packageNameLabel => '包名称';

  @override
  String get packageFeatures => '包的特点';

  @override
  String get publishTime => '发布时间';

  @override
  String get publisher => '发布者';

  @override
  String get send => '发送';

  @override
  String get cancel => '取消';

  @override
  String get like => '喜欢';

  @override
  String get likeCount => '喜欢人数';

  @override
  String get likes => '喜欢数';

  @override
  String get reply => '回复';

  @override
  String replyToGuest(Object guestName) {
    return '回复 $guestName';
  }

  @override
  String replyToParent(Object parentGuestName) {
    return '回复 @$parentGuestName';
  }

  @override
  String get replyCommentHint => '回复评论...';

  @override
  String get replyDetails => '回复详情';

  @override
  String get copyLink => '复制链接';

  @override
  String get platform => '平台';

  @override
  String get firstCommentPrompt => '成为第一个评论的人吧';

  @override
  String get sortMethod => '排序方式';

  @override
  String get recommendNotice => '推荐后，经过审核采纳，该包将收录到 FlutterUnit 插件库中，供更多开发者发现和使用。';

  @override
  String get recommendSubmitted => '推荐已提交，感谢您的贡献！';

  @override
  String get recommendPlugin => '推荐插件';

  @override
  String get recommendDescription => '推荐说明';

  @override
  String submitFailedWithMsg(Object msg) {
    return '提交失败：$msg';
  }

  @override
  String get submitFailedNetwork => '提交失败：网络错误';

  @override
  String get submitRecommendation => '提交推荐';

  @override
  String get plugin => '插件';

  @override
  String get pluginScore => '插件分数';

  @override
  String get yesterday => '昨天';

  @override
  String get noReply => '暂无回复';

  @override
  String get noDescription => '暂无描述';

  @override
  String get noData => '暂无数据';

  @override
  String get noComments => '暂无评论';

  @override
  String get lastRelease => '最后发布';

  @override
  String get unknownCategory => '未知分类';

  @override
  String get unknownPublisher => '未知发布者';

  @override
  String get unknownUser => '未知用户';

  @override
  String get viewAll => '查看所有';

  @override
  String viewMoreReplies(Object moreCount) {
    return '查看更多 $moreCount 条回复';
  }

  @override
  String get tagList => '标签一览';

  @override
  String get addComment => '添加评论';

  @override
  String get guest => '游客';

  @override
  String get type => '类型';

  @override
  String get highlightAnswer => '精答';

  @override
  String get license => '许可证';

  @override
  String get commentContent => '评论内容';

  @override
  String get describePackageFeatureHint => '请描述包的特点';

  @override
  String get describePluginForRecommend => '请描述这个包的主要功能和特点，为什么推荐它...';

  @override
  String get requestSuccess => '请求成功!';

  @override
  String get minDescriptionLength => '请至少输入10个字符的描述';

  @override
  String get enterPackageName => '请输入包名称';

  @override
  String get enterPackageExample => '请输入包名称，如：dio';

  @override
  String get linkCopied => '链接已复制到剪贴板';

  @override
  String get needGalleryPermission => '需要相册权限才能保存图片';
}
