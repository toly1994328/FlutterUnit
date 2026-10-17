import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

/// 行内代码嵌入原文字流，圆角和内边距不影响正文换行。
class ReadingInlineCodeBuilder extends MarkdownElementBuilder {
  /// 沿用阅读主题中的等宽字体、字号和底色。
  final TextStyle style;
  ReadingInlineCodeBuilder({required this.style});

  @override
  Widget visitElementAfterWithContext(BuildContext context, md.Element element,
          TextStyle? preferredStyle, TextStyle? parentStyle) =>
      Text.rich(
          TextSpan(children: <InlineSpan>[
            WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: ReadingInlineCode(
                    source: element.textContent, style: style)),
          ]),
          style: parentStyle);
}

/// 文字底色通过容器绘制，左右留出空间，避免背景紧贴字符。
class ReadingInlineCode extends StatelessWidget {
  /// Markdown 解析后的原始代码文字。
  final String source;

  /// 当前阅读主题的行内代码样式。
  final TextStyle style;
  const ReadingInlineCode(
      {super.key, required this.source, required this.style});

  @override
  Widget build(BuildContext context) => DecoratedBox(
      decoration: BoxDecoration(
          color: style.backgroundColor, borderRadius: BorderRadius.circular(4)),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          child: Text(source,
              style: style.copyWith(
                  backgroundColor: Colors.transparent, height: 1.3))));
}
