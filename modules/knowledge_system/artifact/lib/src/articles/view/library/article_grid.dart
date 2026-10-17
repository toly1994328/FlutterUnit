import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../../data/exp.dart';
import 'article_card.dart';

/// 按最大卡片宽度自动换列，每行高度由文章实际内容决定。
class LibraryArticleGrid extends StatelessWidget {
  /// 当前已经加载的文章，保持接口顺序。
  final List<Article> articles;

  /// 详情阅读沿用列表的数据环境。
  final ArticleRepository repository;

  /// 手机展示带间隙的通栏阅读列表，宽屏仍使用自适应卡片网格。
  final bool flat;

  const LibraryArticleGrid(
      {super.key,
      required this.articles,
      required this.repository,
      this.flat = false});

  @override
  Widget build(BuildContext context) => SliverLayoutBuilder(builder: _layout);

  /// 继续使用首页的最大宽度策略，避免固定行高在卡片下方留下空白。
  Widget _layout(BuildContext context, SliverConstraints constraints) {
    final int columns = flat
        ? 1
        : math.max(1, ((constraints.crossAxisExtent + 12) / (400 + 12)).ceil());
    Widget buildRow(BuildContext context, int index) =>
        _row(context, index, columns);
    return SliverList.builder(
        itemCount: (articles.length / columns).ceil(), itemBuilder: buildRow);
  }

  /// 不足一行的文章保留相同列宽，行内卡片各自按内容收缩。
  Widget _row(BuildContext context, int index, int columns) {
    final List<Widget> children = <Widget>[];
    for (int column = 0; column < columns; column++) {
      if (column > 0) children.add(const SizedBox(width: 12));
      final int articleIndex = index * columns + column;
      children.add(Expanded(
          child: articleIndex < articles.length
              ? LibraryArticleCard(
                  article: articles[articleIndex],
                  repository: repository,
                  flat: flat)
              : const SizedBox.shrink()));
    }
    return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, children: children));
  }
}
