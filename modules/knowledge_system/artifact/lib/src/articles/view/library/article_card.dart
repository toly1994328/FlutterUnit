import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/exp.dart';
import '../../env/artifact_env.dart';
import '../article/markdown_article_page.dart';
import 'article_tags.dart';
import 'article_cover_url.dart';
import '../loading/skeleton_loading.dart';

/// 文库文章卡片，展示标题、创作信息和主题标签。
class LibraryArticleCard extends StatelessWidget {
  /// 当前目录项。
  final Article article;

  /// 沿用所在列表的在线仓储，避免详情切换到另一数据环境。
  final ArticleRepository repository;

  /// 手机使用通栏阅读条目，桌面沿用独立卡片。
  final bool flat;
  const LibraryArticleCard(
      {super.key,
      required this.article,
      this.repository = const ArticleRepository(),
      this.flat = false});

  /// 本站文章直接阅读 Markdown，外链在系统浏览器打开。
  Future<void> _open(BuildContext context) async {
    if (article.type == 2) {
      await Navigator.of(context)
          .push(MaterialPageRoute<void>(builder: _reader));
      return;
    }
    final Uri? target = Uri.tryParse(article.url);
    if (target == null || !<String>['http', 'https'].contains(target.scheme)) {
      return;
    }
    try {
      if (!await launchUrl(target, mode: LaunchMode.externalApplication)) {
        throw StateError('链接无法打开');
      }
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('链接无法打开，请稍后重试')));
    }
  }

  Widget _reader(BuildContext context) =>
      MarkdownArticlePage(article: article, repository: repository);

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    if (flat) {
      return Material(
          color: colors.surface,
          child: InkWell(
              onTap: () => _open(context),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: LayoutBuilder(builder: _flatContent))));
    }
    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      color: Theme.of(context).listTileTheme.tileColor ?? colors.surface,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), side: BorderSide.none),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
          onTap: () => _open(context),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: LayoutBuilder(builder: _content),
          )),
    );
  }

  /// 手机图文按实际内容收缩，作者与日期在卡片底部分列。
  Widget _flatContent(BuildContext context, BoxConstraints box) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double coverWidth = (box.maxWidth * .28).clamp(88, 96);
    final bool summary = article.subtitle.trim().isNotEmpty;
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 15, height: 1.4, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            if (article.cover.isNotEmpty) ...<Widget>[
              ArticleCover(
                  url: article.cover, width: coverWidth, height: coverWidth),
              const SizedBox(width: 12),
            ],
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  if (summary) ...<Widget>[
                    Text(article.subtitle.trim(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 13,
                            height: 1.45,
                            color: colors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                  ],
                  if (article.tags.isNotEmpty)
                    ArticleTags(topics: article.tags, fontSize: 11, maxRows: 1),
                ])),
          ]),
          const SizedBox(height: 8),
          _metadata(context),
        ]);
  }

  /// 作者靠左、创作日期靠右，作者过长时省略以保留日期空间。
  Widget _metadata(BuildContext context,
      {double fontSize = 12, double lineHeight = 1.4}) {
    final String date = article.authoredAt == null
        ? '创作时间未知'
        : DateFormat('yyyy-MM-dd').format(article.authoredAt!.toLocal());
    return DefaultTextStyle(
        style: TextStyle(
            fontSize: fontSize,
            height: lineHeight,
            color: Theme.of(context).colorScheme.onSurfaceVariant),
        child: Row(children: <Widget>[
          Expanded(
              child: Text(article.username.isEmpty ? '张风捷特烈' : article.username,
                  maxLines: 1, overflow: TextOverflow.ellipsis)),
          const SizedBox(width: 12),
          Text(date),
        ]));
  }

  /// 标题和图文按实际内容占高，底部作者与日期分列左右。
  Widget _content(BuildContext context, BoxConstraints box) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double coverWidth = (box.maxWidth * .3).clamp(72, 112);
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: 14, height: 1.4, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            if (article.cover.isNotEmpty) ...<Widget>[
              Align(
                  alignment: Alignment.topLeft,
                  child: ArticleCover(
                      url: article.cover,
                      width: coverWidth,
                      height: coverWidth)),
              const SizedBox(width: 12),
            ],
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                  if (article.subtitle.trim().isNotEmpty) ...<Widget>[
                    Text(article.subtitle.trim(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 12,
                            height: 1.4,
                            color: colors.onSurfaceVariant)),
                    const SizedBox(height: 8),
                  ],
                  if (article.tags.isNotEmpty)
                    ArticleTags(topics: article.tags),
                ])),
          ]),
          const SizedBox(height: 8),
          _metadata(context, fontSize: 10, lineHeight: 1.2),
        ]);
  }
}

class ArticleCover extends StatelessWidget {
  /// 服务端缩略图地址。
  final String url;

  /// 封面容器宽度。
  final double width;

  /// 封面容器高度，卡片使用正方形裁切图片。
  final double height;
  const ArticleCover(
      {super.key, required this.url, this.width = 144, this.height = 144});
  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        foregroundDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: Theme.of(context).colorScheme.outlineVariant,
                width: .75)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image(
              image: CachedNetworkImageProvider(articleCoverUrl(
                  ArtifactEnv().resolveResource(url),
                  width: width,
                  height: height,
                  pixelRatio: MediaQuery.devicePixelRatioOf(context))),
              width: width,
              height: height,
              fit: BoxFit.cover,
              errorBuilder: _error,
              frameBuilder: _frame),
        ),
      );
  Widget _error(BuildContext context, Object error, StackTrace? stack) =>
      _placeholder(context);
  Widget _frame(
          BuildContext context, Widget child, int? frame, bool synchronous) =>
      synchronous || frame != null
          ? child
          : SkeletonLoading(
              label: '正在加载文章封面',
              child: SkeletonBlock(width: width, height: height, radius: 8));
  Widget _placeholder(BuildContext context) => Container(
      width: width,
      height: height,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: const Icon(Icons.image_outlined));
}
