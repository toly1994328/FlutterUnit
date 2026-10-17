import 'package:app/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../bloc/exp.dart';

import '../../data/exp.dart';
import 'article_detail_page.dart';
import 'markdown_article_page.dart';
import 'columnize_page_view.dart';

class SliverArticlePanel extends StatelessWidget {
  const SliverArticlePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticleBloc bloc = context.watch<ArticleBloc>();
    final ArticleState state = bloc.state;
    return SliverMainAxisGroup(slivers: <Widget>[
      if (state.data.isNotEmpty) SliverArticle(data: state.data),
      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: _buildFooter(bloc, state),
        ),
      ),
    ]);
  }

  /// 首屏和追加请求共用加载、重试与末页状态。
  Widget _buildFooter(ArticleBloc bloc, ArticleState state) {
    if (state is ArticleLoading) {
      return const Center(child: CupertinoActivityIndicator());
    }
    if (state is ArticleFailed) {
      return Column(children: <Widget>[
        const Text('文章加载失败，请重试'),
        TextButton(onPressed: bloc.retry, child: const Text('重试')),
      ]);
    }
    return Column(children: <Widget>[
      Text(state.data.isEmpty
          ? '暂无文章'
          : '已加载 ${state.data.length} / ${(state as ArticleWithData).total} 篇'),
      if (bloc.hasMore)
        TextButton(onPressed: bloc.loadNextPageMore, child: const Text('加载更多')),
      TextButton(onPressed: bloc.refresh, child: const Text('刷新文章')),
    ]);
  }
}

class SliverArticle extends StatelessWidget {
  final List<Article> data;

  const SliverArticle({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const SliverGridDelegate deskGridDelegate =
        SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 420,
      mainAxisSpacing: 8,
      mainAxisExtent: 188,
      crossAxisSpacing: 8,
    );

    Widget child = kIsDesk
        ? SliverGrid(
            delegate: SliverChildBuilderDelegate(
              _buildItem,
              childCount: data.length,
            ),
            gridDelegate: deskGridDelegate)
        : SliverList(
            delegate: SliverChildBuilderDelegate(
            _buildItem,
            childCount: data.length,
          ));

    return SliverPadding(
        padding: const EdgeInsets.only(bottom: 0), sliver: child);
  }

  Widget? _buildItem(BuildContext context, int index) {
    return ArticlePanel(article: data[index]);
  }
}

class ArticlePanel extends StatelessWidget {
  final Article article;

  const ArticlePanel({Key? key, required this.article}) : super(key: key);

  void toArticleDetail(BuildContext context) {
    if (article.type == 2) {
      Navigator.of(context).push(MaterialPageRoute<void>(
        builder: _buildMarkdownPage,
      ));
      return;
    }
    if (!kIsWeb &&
        (defaultTargetPlatform == TargetPlatform.android ||
            defaultTargetPlatform == TargetPlatform.iOS)) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ArticleDetailPage(article: article),
        ),
      );
    } else {
      _launchURL(article.url);
    }
  }

  Widget _buildMarkdownPage(BuildContext context) =>
      MarkdownArticlePage(article: article);

  void _launchURL(String url) async {
    print(url);
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => toArticleDetail(context),
      child: Container(
        color: Theme.of(context).listTileTheme.tileColor,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.only(bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(
                    'assets/images/icon_head.webp',
                  ),
                  backgroundColor: Colors.transparent,
                  radius: 10,
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                    child: Text('${article.username}',
                        style: const TextStyle(
                            color: Color(0xff6A6D76), fontSize: 12))),
                Text(
                  article.type == 2 ? '本站' : '掘金',
                  style:
                      const TextStyle(fontSize: 12, color: Color(0xff6A6D76)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                article.title,
                maxLines: 2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  '${article.subtitle}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(
                        0xffA3A3A3,
                      )),
                )),
                if (article.cover.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image(
                          image: CachedNetworkImageProvider(article.cover),
                          width: 110,
                        )),
                  )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                const Spacer(),
                Text(
                  '更新时间: ${formatLong.format(DateTime.fromMillisecondsSinceEpoch(article.update, isUtc: true))}',
                  style: const TextStyle(
                      color: Color(
                        0xff6A6D76,
                      ),
                      fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
