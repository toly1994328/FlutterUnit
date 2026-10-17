import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;
import 'document_markdown.dart';

/// 在最终样式合并后设置列表排版，继续复用插件的解析与元素构建。
class ReadingMarkdownState extends State<DocumentMarkdown>
    implements MarkdownBuilderDelegate {
  /// 本轮解析产生的正文块。
  List<Widget> _children = <Widget>[];

  /// 链接手势随重新解析和页面销毁释放。
  final List<TapGestureRecognizer> _links = <TapGestureRecognizer>[];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _parse();
  }

  @override
  void didUpdateWidget(DocumentMarkdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data ||
        oldWidget.styleSheet != widget.styleSheet) {
      _parse();
    }
  }

  void _clearLinks() {
    for (final TapGestureRecognizer link in _links) {
      link.dispose();
    }
    _links.clear();
  }

  /// 插件默认将 li 重建为正文样式；在合并后独立指定列表行高。
  void _parse() {
    _clearLinks();
    final MarkdownStyleSheet style =
        MarkdownStyleSheet.fromTheme(Theme.of(context))
            .merge(widget.styleSheet);
    style.styles['li'] = style.p?.copyWith(height: 1.3);
    final md.Document document = md.Document(
        blockSyntaxes: widget.blockSyntaxes,
        inlineSyntaxes: widget.inlineSyntaxes,
        extensionSet: widget.extensionSet ?? md.ExtensionSet.gitHubFlavored,
        encodeHtml: false);
    final MarkdownBuilder builder = MarkdownBuilder(
        delegate: this,
        selectable: widget.selectable,
        styleSheet: style,
        imageDirectory: widget.imageDirectory,
        sizedImageBuilder: widget.sizedImageBuilder,
        checkboxBuilder: widget.checkboxBuilder,
        bulletBuilder: widget.bulletBuilder,
        builders: widget.builders,
        paddingBuilders: widget.paddingBuilders,
        listItemCrossAxisAlignment: widget.listItemCrossAxisAlignment,
        fitContent: widget.fitContent,
        onSelectionChanged: widget.onSelectionChanged,
        onTapText: widget.onTapText,
        softLineBreak: widget.softLineBreak);
    _children = builder
        .build(document.parseLines(const LineSplitter().convert(widget.data)));
  }

  @override
  GestureRecognizer createLink(String text, String? href, String title) {
    final TapGestureRecognizer link = TapGestureRecognizer()
      ..onTap = () => widget.onTapLink?.call(text, href, title);
    _links.add(link);
    return link;
  }

  @override
  TextSpan formatText(MarkdownStyleSheet styleSheet, String code) => TextSpan(
      style: styleSheet.code, text: code.replaceFirst(RegExp(r'\n$'), ''));

  @override
  Widget build(BuildContext context) => widget.build(context, _children);

  @override
  void dispose() {
    _clearLinks();
    super.dispose();
  }
}
