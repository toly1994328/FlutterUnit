import 'package:flutter/material.dart';
import '../../data/exp.dart';

/// 参考管理器按分组组织主题，使用多列标签和文章计数。
class TopicOptions extends StatelessWidget {
  /// 优先展示语言、技术和主题，保留其余服务端分组。
  static const List<String> _groupOrder = <String>[
    '语言与框架',
    '技术领域',
    '主题',
    '图形技术',
    '状态方案',
    '语言特性',
    '工程工具',
    '项目',
    '算法类型',
    '应用场景',
    '游戏案例',
    'AI 工具',
    '内容形式',
  ];
  const TopicOptions(
      {super.key,
      required this.topics,
      required this.selected,
      required this.query,
      required this.onToggle});

  /// 当前可见文章关联的主题。
  final List<ArticleTopic> topics;

  /// 已经勾选的主题标识。
  final Set<String> selected;

  /// 主题名或分组的搜索关键字。
  final String query;

  /// 点击标签时切换选择。
  final ValueChanged<String> onToggle;
  @override
  Widget build(BuildContext context) {
    final Map<String, List<ArticleTopic>> groups =
        <String, List<ArticleTopic>>{};
    for (final ArticleTopic topic in topics) {
      final String group = topic.group.isEmpty ? '其他主题' : topic.group;
      if (!'${topic.name} $group'.toLowerCase().contains(query)) continue;
      groups.putIfAbsent(group, () => <ArticleTopic>[]).add(topic);
    }
    if (groups.isEmpty) {
      return const Padding(
          padding: EdgeInsets.all(24), child: Center(child: Text('没有匹配的主题')));
    }
    Widget section(MapEntry<String, List<ArticleTopic>> group) =>
        _group(context, group.key, group.value);
    final List<MapEntry<String, List<ArticleTopic>>> entries =
        groups.entries.toList()..sort(_compareGroups);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: entries.map(section).toList());
  }

  int _compareGroups(MapEntry<String, List<ArticleTopic>> left,
      MapEntry<String, List<ArticleTopic>> right) {
    final int leftIndex = _groupOrder.indexOf(left.key);
    final int rightIndex = _groupOrder.indexOf(right.key);
    return (leftIndex < 0 ? _groupOrder.length : leftIndex)
        .compareTo(rightIndex < 0 ? _groupOrder.length : rightIndex);
  }

  Widget _group(BuildContext context, String name, List<ArticleTopic> items) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    Widget options(BuildContext context, BoxConstraints box) =>
        _optionsLayout(context, box, items);
    return Padding(
        padding: const EdgeInsets.only(bottom: 16, right: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(children: <Widget>[
                Text(name,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colors.onSurfaceVariant)),
                const SizedBox(width: 8),
                Text('${items.length}',
                    style: TextStyle(
                        fontSize: 11,
                        color: colors.onSurfaceVariant.withValues(alpha: .7))),
                const SizedBox(width: 12),
                Expanded(
                    child: Divider(
                        color: colors.outlineVariant.withValues(alpha: .6))),
              ]),
              const SizedBox(height: 8),
              LayoutBuilder(builder: options),
            ]));
  }

  Widget _optionsLayout(
      BuildContext context, BoxConstraints box, List<ArticleTopic> items) {
    final int columns = box.maxWidth >= 420 ? 3 : 2;
    final double width = (box.maxWidth - (columns - 1) * 8) / columns;
    Widget option(ArticleTopic topic) =>
        SizedBox(width: width, child: _option(context, topic));
    return Wrap(
        spacing: 8, runSpacing: 8, children: items.map(option).toList());
  }

  Widget _option(BuildContext context, ArticleTopic topic) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool checked = selected.contains(topic.id);
    final bool enabled = checked || selected.length < 20;
    final Color foreground = checked ? colors.primary : colors.onSurface;
    return Semantics(
        key: ValueKey<String>('topic-option-${topic.id}'),
        button: true,
        selected: checked,
        enabled: enabled,
        label: '${topic.name}，${topic.count} 篇文章',
        child: Material(
            color: checked
                ? colors.primary.withValues(alpha: .07)
                : colors.surface,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                    color: checked
                        ? colors.primary.withValues(alpha: .5)
                        : colors.outlineVariant.withValues(alpha: .7),
                    width: .75)),
            child: InkWell(
                onTap: enabled ? () => onToggle(topic.id) : null,
                mouseCursor: SystemMouseCursors.click,
                hoverColor: colors.primary.withValues(alpha: .04),
                splashFactory: NoSplash.splashFactory,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: Row(children: <Widget>[
                      Expanded(
                          child: Text(topic.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: checked
                                      ? FontWeight.w500
                                      : FontWeight.normal,
                                  color: enabled
                                      ? foreground
                                      : colors.onSurfaceVariant))),
                      const SizedBox(width: 8),
                      Text('${topic.count}',
                          style: TextStyle(
                              fontSize: 10,
                              color: checked
                                  ? colors.primary
                                  : colors.onSurfaceVariant)),
                      const SizedBox(width: 6),
                      SizedBox(
                          width: 14,
                          child: checked
                              ? Icon(Icons.check_rounded,
                                  size: 14, color: colors.primary)
                              : null),
                    ])))));
  }
}
