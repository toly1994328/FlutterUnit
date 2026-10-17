import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'outline_entry.dart';
import 'reading_inline_code.dart';

/// 从解析后的真实标题构建导航目标，代码块中的井号不会进入此构建器。
class ReadingHeadingBuilder extends MarkdownElementBuilder {
  /// 当前正文样式，标题与行内格式保持同一套排版。
  final MarkdownStyleSheet style;

  /// 标题内链接沿用文章链接处理。
  final MarkdownTapLinkCallback onTapLink;

  /// 本轮解析的标题序号。
  int _nextId = 0;

  /// 重名标题片段的计数，确保文内链接和目录目标不冲突。
  final Map<String, int> _duplicates = <String, int>{};
  ReadingHeadingBuilder({required this.style, required this.onTapLink});

  /// 一轮解析完成后复位，依赖变化导致重新解析时仍使用稳定序号。
  void reset() {
    _nextId = 0;
    _duplicates.clear();
  }

  @override
  bool isBlockElement() => true;

  /// 保持解析器的行内栈正常闭合，实际文字由标题组件完整绘制。
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) =>
      const SizedBox.shrink();

  @override
  Widget visitElementAfterWithContext(BuildContext context, md.Element element,
      TextStyle? preferredStyle, TextStyle? parentStyle) {
    final String title = element.textContent.trim();
    final String base = outlineFragment(title);
    final int duplicate = _duplicates[base] ?? 0;
    _duplicates[base] = duplicate + 1;
    final OutlineEntry entry = OutlineEntry(
        id: _nextId++,
        level: int.parse(element.tag.substring(1)),
        title: title.isEmpty ? '未命名章节' : title,
        fragment: duplicate == 0 ? base : '$base-$duplicate');
    return ReadingHeading(
        key: ValueKey<String>('reading-heading-${entry.id}'),
        entry: entry,
        element: element,
        style: style,
        onTapLink: onTapLink);
  }
}

/// 导航标题保留原本的强调、行内代码和链接，不重新拆分文章 Markdown。
class ReadingHeading extends StatefulWidget {
  /// 该标题的目录信息。
  final OutlineEntry entry;

  /// Markdown 解析器已经处理过的标题节点。
  final md.Element element;

  /// 当前阅读样式。
  final MarkdownStyleSheet style;

  /// 文章统一链接回调。
  final MarkdownTapLinkCallback onTapLink;
  const ReadingHeading(
      {super.key,
      required this.entry,
      required this.element,
      required this.style,
      required this.onTapLink});

  @override
  State<ReadingHeading> createState() => _ReadingHeadingState();
}

class _ReadingHeadingState extends State<ReadingHeading> {
  /// 标题中创建的链接识别器随组件更新和销毁释放。
  final List<TapGestureRecognizer> _links = <TapGestureRecognizer>[];

  void _clearLinks() {
    for (final TapGestureRecognizer link in _links) {
      link.dispose();
    }
    _links.clear();
  }

  @override
  void dispose() {
    _clearLinks();
    super.dispose();
  }

  /// 递归保留标题的行内语义和链接点击目标。
  InlineSpan _span(md.Node node, TextStyle style,
      [TapGestureRecognizer? link]) {
    if (node is md.Text) {
      return TextSpan(text: node.text, style: style, recognizer: link);
    }
    if (node is! md.Element) return const TextSpan();
    if (node.tag == 'code') {
      return WidgetSpan(
          alignment: PlaceholderAlignment.middle,
          child: ReadingInlineCode(
              source: node.textContent, style: widget.style.code ?? style));
    }
    final TextStyle nested = style.merge(widget.style.styles[node.tag]);
    TapGestureRecognizer? target = link;
    if (node.tag == 'a') {
      void open() => widget.onTapLink(node.textContent, node.attributes['href'],
          node.attributes['title'] ?? '');
      target = TapGestureRecognizer()..onTap = open;
      _links.add(target);
    }
    return TextSpan(children: <InlineSpan>[
      if (node.tag == 'img') TextSpan(text: node.attributes['alt'] ?? ''),
      for (final md.Node child in node.children ?? <md.Node>[])
        _span(child, nested, target),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    _clearLinks();
    final TextStyle style = widget.style.styles[widget.element.tag]!;
    final EdgeInsets padding = switch (widget.entry.level) {
      1 => widget.style.h1Padding!,
      2 => widget.style.h2Padding!,
      3 => widget.style.h3Padding!,
      4 => widget.style.h4Padding!,
      5 => widget.style.h5Padding!,
      _ => widget.style.h6Padding!,
    };
    return Semantics(
        header: true,
        child: Padding(
            padding: padding,
            child: Text.rich(_span(widget.element, style), style: style)));
  }
}
