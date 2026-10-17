import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../data/exp.dart';

/// 将文章标题、作者日期与主题放在正文前统一呈现。
class ReadingHeader extends StatelessWidget {
  /// 当前文章目录信息。
  final Article article;

  /// 本次加载的实际文档标题。
  final String title;
  const ReadingHeader({super.key, required this.article, required this.title});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final String date = article.authoredAt == null
        ? '创作时间未知'
        : DateFormat('yyyy-MM-dd').format(article.authoredAt!.toLocal());
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(spacing: 12, runSpacing: 6, children: <Widget>[
            Text('捷特文库', style: TextStyle(fontSize: 12, color: colors.primary)),
            Text(article.username.isEmpty ? '张风捷特烈' : article.username,
                style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant)),
            Text(date,
                style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant)),
          ]),
          const SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 20,
                  height: 1.3,
                  fontWeight: FontWeight.w700,
                  color: colors.onSurface)),
          if (article.subtitle.trim().isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            Text(article.subtitle,
                style: TextStyle(
                    fontSize: 13, height: 1.7, color: colors.onSurfaceVariant)),
          ],
          if (article.tags.isNotEmpty) ...<Widget>[
            const SizedBox(height: 12),
            Wrap(
                spacing: 6,
                runSpacing: 6,
                children: article.tags
                    .map((ArticleTopic topic) => _topic(context, topic))
                    .toList()),
          ],
          const SizedBox(height: 24),
          Divider(height: 1, thickness: .5, color: colors.outlineVariant),
        ]);
  }

  Widget _topic(BuildContext context, ArticleTopic topic) => DecoratedBox(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Text('#${topic.name}',
              style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary))));
}
