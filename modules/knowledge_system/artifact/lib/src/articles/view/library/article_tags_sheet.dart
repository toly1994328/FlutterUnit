import 'package:flutter/material.dart';
import '../../data/exp.dart';

/// 展开当前文章全部标签，不改变检索条件或打开文章。
Future<void> showArticleTags(BuildContext context, List<ArticleTopic> topics) {
  FocusScope.of(context).unfocus();
  Widget sheet(BuildContext context) => _ArticleTagsSheet(topics: topics);
  return showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      constraints: const BoxConstraints(minWidth: double.infinity),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: sheet);
}

class _ArticleTagsSheet extends StatelessWidget {
  /// 包含已显示和被收起标签的完整列表，保持原始顺序。
  final List<ArticleTopic> topics;
  const _ArticleTagsSheet({required this.topics});

  @override
  Widget build(BuildContext context) => SafeArea(
      top: false,
      child: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * .65),
          child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('全部标签（${topics.length}）',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 16),
                    Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: topics
                            .map((ArticleTopic topic) => _tag(context, topic))
                            .toList()),
                  ]))));

  Widget _tag(BuildContext context, ArticleTopic topic) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return DecoratedBox(
        decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: .08),
            borderRadius: BorderRadius.circular(6)),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Text(topic.name,
                style: TextStyle(fontSize: 13, color: colors.primary))));
  }
}
