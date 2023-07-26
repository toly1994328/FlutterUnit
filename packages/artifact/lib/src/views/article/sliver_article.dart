import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/exp.dart';
import '../../repositories/exp.dart';
import 'article_detail_page.dart';
import 'columnize_page_view.dart';

class SliverArticlePanel extends StatelessWidget {
  const SliverArticlePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticleState state = context.watch<ArticleBloc>().state;
    return switch (state) {
      ArticleLoading() => SliverToBoxAdapter(
          child: const CupertinoActivityIndicator(),
        ),
      ArticleWithData() => SliverArticle(
          data: state.data,
        ),
      ArticleFailed() => SliverToBoxAdapter(
          child: Text('error'),
        ),
    };
  }
}

class SliverArticle extends StatelessWidget {
  final List<Article> data;
  const SliverArticle({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: const EdgeInsets.only(bottom: 0),
        sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
          _buildItem,
          childCount: data.length,
        )));
  }

  Widget? _buildItem(BuildContext context, int index) {
    return ArticlePanel(article: data[index]);
  }
}

class ArticlePanel extends StatelessWidget {
  final Article article;

  const ArticlePanel({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ArticleDetailPage(article: article),
          ),
        );
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: EdgeInsets.only(bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
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
                        style:
                            TextStyle(color: Color(0xff6A6D76), fontSize: 12))),
                Text(
                  '掘金',
                  style: TextStyle(fontSize: 12, color: Color(0xff6A6D76)),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                article.title,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  '${article.subtitle}',
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(
                        0xffA3A3A3,
                      )),
                )),
                if (article.cover != null && article.cover!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          article.cover!,
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
                Spacer(),
                Text(
                  '更新时间: ${formatLong.format(DateTime.fromMillisecondsSinceEpoch(article.update, isUtc: true))}',
                  style: TextStyle(
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
