import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class PkgL10nEn extends PkgL10n {
  PkgL10nEn([String locale = 'en']) : super(locale);

  @override
  String monthsAgo(Object diff) {
    return '$diff months ago';
  }

  @override
  String yearsAgo(Object diff) {
    return '$diff years ago';
  }

  @override
  String weeksAgo(Object diff) {
    return '$diff weeks ago';
  }

  @override
  String daysAgo(Object diff) {
    return '$diff days ago';
  }

  @override
  String hoursAgo(Object diff) {
    return '$diff hours ago';
  }

  @override
  String minutesAgo(Object diff) {
    return '$diff minutes ago';
  }

  @override
  String commentsOfPackage(Object packageName) {
    return 'Comments of $packageName';
  }

  @override
  String get downloadsLast30Days => 'Downloads in last 30 days';

  @override
  String get flutterPluginRepo => 'Flutter Plugin Repository';

  @override
  String get downloads => 'Downloads';

  @override
  String get home => 'Home';

  @override
  String get theme => 'Theme';

  @override
  String get today => 'Today';

  @override
  String get repository => 'Repository:';

  @override
  String get dependencies => 'Dependencies';

  @override
  String get saveImage => 'Save Image';

  @override
  String saveFailed(Object error) {
    return 'Save failed: $error';
  }

  @override
  String get allComments => 'All Comments';

  @override
  String get others => 'Others';

  @override
  String get writeReplyHint => 'Write your reply...';

  @override
  String get writeCommentHint => 'Write your comment...';

  @override
  String get writeComment => 'Write Comment';

  @override
  String get share => 'Share';

  @override
  String get shareFeatureDeveloping => 'Share feature under development...';

  @override
  String get shareCard => 'Share Card';

  @override
  String get score => 'Score';

  @override
  String get justNow => 'Just now';

  @override
  String get loadFailed => 'Load failed';

  @override
  String loadFailedWithMessage(Object message) {
    return 'Load failed: $message';
  }

  @override
  String get loadMore10 => 'Load more (10)';

  @override
  String get loadingComments => 'Loading comments...';

  @override
  String get packageNameLabel => 'Package Name';

  @override
  String get packageFeatures => 'Package Features';

  @override
  String get publishTime => 'Publish Time';

  @override
  String get publisher => 'Publisher';

  @override
  String get send => 'Send';

  @override
  String get cancel => 'Cancel';

  @override
  String get like => 'Like';

  @override
  String get likeCount => 'Likes Count';

  @override
  String get likes => 'Likes';

  @override
  String get reply => 'Reply';

  @override
  String replyToGuest(Object guestName) {
    return 'Reply $guestName';
  }

  @override
  String replyToParent(Object parentGuestName) {
    return 'Reply @$parentGuestName';
  }

  @override
  String get replyCommentHint => 'Reply comment...';

  @override
  String get replyDetails => 'Reply Details';

  @override
  String get copyLink => 'Copy Link';

  @override
  String get platform => 'Platform';

  @override
  String get firstCommentPrompt => 'Be the first to comment';

  @override
  String get sortMethod => 'Sort Method';

  @override
  String get recommendNotice => 'After review and adoption, the package will be included in FlutterUnit plugin repository for more developers to discover and use.';

  @override
  String get recommendSubmitted => 'Recommendation submitted, thank you for your contribution!';

  @override
  String get recommendPlugin => 'Recommend Plugin';

  @override
  String get recommendDescription => 'Recommendation Description';

  @override
  String submitFailedWithMsg(Object msg) {
    return 'Submit failed: $msg';
  }

  @override
  String get submitFailedNetwork => 'Submit failed: Network error';

  @override
  String get submitRecommendation => 'Submit Recommendation';

  @override
  String get plugin => 'Plugin';

  @override
  String get pluginScore => 'Plugin Score';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get noReply => 'No replies';

  @override
  String get noDescription => 'No description';

  @override
  String get noData => 'No data';

  @override
  String get noComments => 'No comments';

  @override
  String get lastRelease => 'Last Release';

  @override
  String get unknownCategory => 'Unknown Category';

  @override
  String get unknownPublisher => 'Unknown Publisher';

  @override
  String get unknownUser => 'Unknown User';

  @override
  String get viewAll => 'View All';

  @override
  String viewMoreReplies(Object moreCount) {
    return 'View $moreCount more replies';
  }

  @override
  String get tagList => 'Tag List';

  @override
  String get addComment => 'Add Comment';

  @override
  String get guest => 'Guest';

  @override
  String get type => 'Type';

  @override
  String get highlightAnswer => 'Highlighted Answer';

  @override
  String get license => 'License';

  @override
  String get commentContent => 'Comment Content';

  @override
  String get describePackageFeatureHint => 'Please describe package features';

  @override
  String get describePluginForRecommend => 'Please describe the main features and functionality of this package and why you recommend it...';

  @override
  String get requestSuccess => 'Request successful!';

  @override
  String get minDescriptionLength => 'Please enter at least 10 characters';

  @override
  String get enterPackageName => 'Please enter package name';

  @override
  String get enterPackageExample => 'Please enter package name, e.g., dio';

  @override
  String get linkCopied => 'Link copied to clipboard';

  @override
  String get needGalleryPermission => 'Gallery permission required to save image';
}
