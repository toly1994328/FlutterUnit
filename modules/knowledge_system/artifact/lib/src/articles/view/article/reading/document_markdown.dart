import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'reading_heading.dart';
import 'reading_navigation.dart';
import 'reading_markdown_state.dart';

/// 文档说明与 Markdown 共享滚动列表，图片按可见区域懒加载。
class DocumentMarkdown extends MarkdownWidget {
  /// 作者、日期与主题说明。
  final Widget header;

  /// 正文、目录和章节位置共享的导航控制器。
  final ReadingNavigation navigation;
  const DocumentMarkdown(
      {super.key,
      required super.data,
      required this.header,
      required this.navigation,
      super.styleSheet,
      super.builders,
      super.onTapLink,
      super.sizedImageBuilder})
      : super(selectable: false);
  @override
  State<DocumentMarkdown> createState() => ReadingMarkdownState();
  @override
  Widget build(BuildContext context, List<Widget>? children) {
    final List<Widget> blocks = <Widget>[
      header,
      const SizedBox(height: 24),
      ...?children,
      const Padding(
          padding: EdgeInsets.only(top: 48, bottom: 24),
          child: Center(child: Text('已读完全文'))),
    ];
    for (final MarkdownElementBuilder builder in builders.values.toSet()) {
      if (builder is ReadingHeadingBuilder) builder.reset();
    }
    navigation.bind(blocks);
    Widget item(BuildContext context, int index) => blocks[index];
    Widget layout(BuildContext context, BoxConstraints box) {
      final bool compact = MediaQuery.sizeOf(context).width < 600;
      final double topInset = MediaQuery.paddingOf(context).top;
      navigation.updateViewport(box.maxHeight, topInset);
      return ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: ScrollablePositionedList.builder(
              key: const ValueKey<String>('reading-document-scroll'),
              itemScrollController: navigation.scroll,
              itemPositionsListener: navigation.positions,
              itemCount: blocks.length,
              itemBuilder: item,
              padding: EdgeInsets.fromLTRB(
                  compact ? 20 : 40, topInset + 16, compact ? 20 : 40, 32)));
    }

    // 正文不再自动生成内侧滚动条，阅读进度统一显示在页面最右侧。
    // 由统一选择区域处理含行内组件的段落，保留正文文字选择能力。
    return SelectionArea(child: LayoutBuilder(builder: layout));
  }
}
