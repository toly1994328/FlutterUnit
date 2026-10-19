import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import 'mermaid/reading_mermaid.dart';
import 'reading_code.dart';

/// 围栏代码按语言分发，Mermaid 使用图表，其余语言继续高亮。
class ReadingCodeBuilder extends MarkdownElementBuilder {
  /// 代码字号随正文阅读字号变化。
  final double fontSize;

  ReadingCodeBuilder({required this.fontSize});

  @override
  bool isBlockElement() => true;

  /// 闭合默认解析器的行内栈，避免代码格式延续到下一段正文。
  @override
  Widget visitText(md.Text text, TextStyle? preferredStyle) =>
      const SizedBox.shrink();

  @override
  Widget visitElementAfterWithContext(BuildContext context, md.Element element,
      TextStyle? preferredStyle, TextStyle? parentStyle) {
    final Iterable<md.Element> children =
        (element.children ?? <md.Node>[]).whereType<md.Element>();
    final String classes =
        children.isEmpty ? '' : children.first.attributes['class'] ?? '';
    final RegExpMatch? match = RegExp(r'language-([^\s]+)').firstMatch(classes);
    final String language = match?.group(1)?.toLowerCase() ?? '';
    if (language == 'mermaid') {
      return ReadingMermaid(source: element.textContent, fontSize: fontSize);
    }
    return ReadingCode(
        source: element.textContent, language: language, fontSize: fontSize);
  }
}
