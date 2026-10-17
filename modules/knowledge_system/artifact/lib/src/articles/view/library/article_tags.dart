import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../data/exp.dart';
import 'article_tags_sheet.dart';

/// 按可用宽度和行数排列主题标签，余下标签用数量提示收起。
class ArticleTags extends StatelessWidget {
  /// 服务端返回的完整主题列表。
  final List<ArticleTopic> topics;

  /// 手机阅读列表使用稍大的标签，桌面卡片沿用原字号。
  final double fontSize;

  /// 手机限制一行，桌面默认保留两行。
  final int maxRows;
  const ArticleTags(
      {super.key, required this.topics, this.fontSize = 10, this.maxRows = 2})
      : assert(maxRows > 0);

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: _layout);

  /// 测量标签宽度并为剩余数量预留空间，避免超出允许行数。
  Widget _layout(BuildContext context, BoxConstraints box) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final TextStyle style = DefaultTextStyle.of(context).style.copyWith(
        fontSize: fontSize,
        height: 1.2,
        color: colors.primary,
        fontWeight: FontWeight.normal);
    final double maxWidth = math.min(box.maxWidth, 130);
    final TextPainter painter = TextPainter(
        textDirection: Directionality.of(context),
        textScaler: MediaQuery.textScalerOf(context),
        maxLines: 1);
    double widthOf(String label) {
      painter.text = TextSpan(text: label, style: style);
      painter.layout();
      return math.min(painter.width.ceilToDouble() + 12, maxWidth);
    }

    final List<double> widths = topics.map(_topicName).map(widthOf).toList();
    int visible = topics.length;
    while (visible > 0) {
      final List<double> candidate = widths.take(visible).toList();
      if (visible < topics.length) {
        candidate.add(widthOf('+${topics.length - visible}'));
      }
      if (_fits(candidate, box.maxWidth)) break;
      visible--;
    }
    painter.dispose();
    return Wrap(spacing: 4, runSpacing: 4, children: <Widget>[
      for (final ArticleTopic topic in topics.take(visible))
        _chip(topic.name, style, colors, maxWidth),
      if (visible < topics.length)
        _more(context, topics.length - visible, style, colors, maxWidth),
    ]);
  }

  /// 仅数量入口响应点击，嵌套按钮拦截手势，不触发整张文章卡片。
  Widget _more(BuildContext context, int hidden, TextStyle style,
          ColorScheme colors, double maxWidth) =>
      Semantics(
          button: true,
          excludeSemantics: true,
          label: '查看全部 ${topics.length} 个标签',
          onTap: () => showArticleTags(context, topics),
          child: Material(
              type: MaterialType.transparency,
              borderRadius: BorderRadius.circular(4),
              child: InkWell(
                  onTap: () => showArticleTags(context, topics),
                  borderRadius: BorderRadius.circular(4),
                  child: _chip('+$hidden', style, colors, maxWidth))));

  /// 使用与 Wrap 相同的间距规则，判断是否能在指定行数内显示。
  bool _fits(List<double> widths, double available) {
    int rows = 1;
    double used = 0;
    for (final double width in widths) {
      final double next = used == 0 ? width : used + 4 + width;
      if (next > available && used > 0) {
        rows++;
        used = width;
      } else {
        used = next;
      }
      if (rows > maxRows) return false;
    }
    return true;
  }

  Widget _chip(
          String label, TextStyle style, ColorScheme colors, double maxWidth) =>
      Container(
          constraints: BoxConstraints(maxWidth: maxWidth),
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: .08),
              borderRadius: BorderRadius.circular(4)),
          child: Text(label,
              maxLines: 1, overflow: TextOverflow.ellipsis, style: style));

  String _topicName(ArticleTopic topic) => topic.name;
}
