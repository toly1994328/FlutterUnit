import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'reading_code_highlight.dart';

/// 围栏代码使用独立组件，行内代码继续沿用 Markdown 的文本样式。
class ReadingCodeBuilder extends MarkdownElementBuilder {
  /// 代码字号随正文阅读字号变化。
  final double fontSize;
  ReadingCodeBuilder({required this.fontSize});

  @override
  bool isBlockElement() => true;

  /// 让默认解析器闭合代码的行内栈，避免格式延续到下一段正文。
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
    return ReadingCode(
        source: element.textContent,
        language: match?.group(1)?.toLowerCase() ?? '',
        fontSize: fontSize);
  }
}

/// 带语言标识、复制入口和横向滚动的代码块，保留原代码字节对应的文本。
class ReadingCode extends StatefulWidget {
  /// 未重新排版的代码文本，复制时保留缩进和换行。
  final String source;

  /// 围栏声明的语言；为空时尝试识别，无法识别时显示 TEXT。
  final String language;

  /// 等宽代码字号。
  final double fontSize;
  const ReadingCode(
      {super.key,
      required this.source,
      required this.language,
      required this.fontSize});

  @override
  State<ReadingCode> createState() => _ReadingCodeState();
}

class _ReadingCodeState extends State<ReadingCode> {
  /// 语法分析只在源码或语言变化时执行，避免滚动时重复高亮。
  late ReadingCodeHighlight _highlighted;

  /// 每个代码块独立滚动，避免多个横向滚动条共享阅读页控制器。
  final ScrollController _horizontal = ScrollController();

  @override
  void initState() {
    super.initState();
    _highlighted = highlightReadingCode(widget.source, widget.language);
  }

  @override
  void didUpdateWidget(ReadingCode oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.source != oldWidget.source ||
        widget.language != oldWidget.language) {
      _highlighted = highlightReadingCode(widget.source, widget.language);
    }
  }

  @override
  void dispose() {
    _horizontal.dispose();
    super.dispose();
  }

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.source));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('代码已复制')));
  }

  /// 行号固定在左侧，源码独立横向滚动；统一行高避免中文注释导致错行。
  Widget _codeBody() {
    final TextStyle style = TextStyle(
        fontFamily: 'Consolas',
        fontFamilyFallback: const <String>['Menlo', 'monospace'],
        fontSize: widget.fontSize,
        letterSpacing: 0,
        height: 1.8,
        color: const Color(0xffABB2BF));
    final StrutStyle strut =
        StrutStyle.fromTextStyle(style, forceStrutHeight: true);
    final int count =
        '\n'.allMatches(_highlighted.span.toPlainText()).length + 1;
    final String numbers =
        List<String>.generate(count, (int index) => '${index + 1}').join('\n');
    return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SelectionContainer.disabled(
                  child: ExcludeSemantics(
                      child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.only(left: 16, right: 12),
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Color(0xff343544)))),
                          child: Text(numbers,
                              textAlign: TextAlign.right,
                              strutStyle: strut,
                              style: style.copyWith(
                                  color: const Color(0xff6B7280)))))),
              Expanded(
                  child: Scrollbar(
                      controller: _horizontal,
                      child: SingleChildScrollView(
                          controller: _horizontal,
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.only(right: 20),
                          child: SelectableText.rich(_highlighted.span,
                              strutStyle: strut, style: style)))),
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: const Color(0xff1E1E2E),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                  height: 32,
                  padding: const EdgeInsets.only(left: 20, right: 4),
                  child: Row(children: <Widget>[
                    Text(_highlighted.language.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: Color(0xff9CA3AF))),
                    const Spacer(),
                    IconButton(
                        onPressed: _copy,
                        tooltip: '复制代码',
                        color: const Color(0xffABB2BF),
                        icon: const Icon(Icons.copy_outlined, size: 16)),
                  ])),
              _codeBody(),
            ]));
  }
}
