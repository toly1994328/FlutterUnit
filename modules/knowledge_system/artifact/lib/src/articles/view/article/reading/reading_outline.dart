import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'outline_entry.dart';
import 'reading_navigation.dart';

/// 宽屏侧栏和窄屏抽屉共用目录，当前章节变化时跟随显示。
class ReadingOutline extends StatefulWidget {
  /// 与正文共用的导航状态。
  final ReadingNavigation navigation;

  /// 点击章节时由页面处理抽屉收起与正文跳转。
  final ValueChanged<OutlineEntry> onSelected;
  const ReadingOutline(
      {super.key, required this.navigation, required this.onSelected});

  @override
  State<ReadingOutline> createState() => _ReadingOutlineState();
}

class _ReadingOutlineState extends State<ReadingOutline> {
  /// 目录列表独立定位，当前章节在长目录中仍可看见。
  final ItemScrollController _items = ItemScrollController();

  /// 判断当前章节是否已经完整显示，避免目录反复移动。
  final ItemPositionsListener _positions = ItemPositionsListener.create();

  /// 鼠标当前悬浮的章节，仅改变文字颜色。
  int? _hovered;

  @override
  void initState() {
    super.initState();
    widget.navigation.active.addListener(_follow);
  }

  @override
  void dispose() {
    widget.navigation.active.removeListener(_follow);
    super.dispose();
  }

  void _follow() {
    final int index = widget.navigation.entries.value.indexWhere(_isActive);
    if (_items.isAttached && index >= 0) {
      final bool visible = _positions.itemPositions.value.any(
          (ItemPosition item) =>
              item.index == index &&
              item.itemLeadingEdge >= 0 &&
              item.itemTrailingEdge <= 1);
      if (visible) return;
      _items.scrollTo(
          index: index,
          alignment: .35,
          duration: const Duration(milliseconds: 180));
    }
  }

  bool _isActive(OutlineEntry entry) =>
      entry.id == widget.navigation.active.value;

  @override
  Widget build(BuildContext context) =>
      ValueListenableBuilder<List<OutlineEntry>>(
          valueListenable: widget.navigation.entries, builder: _contents);

  Widget _contents(
      BuildContext context, List<OutlineEntry> entries, Widget? child) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text('目录',
                      style: TextStyle(
                          fontSize: 13,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                          color: colors.onSurfaceVariant))),
              if (entries.isEmpty)
                Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text('本文暂无章节标题',
                        style: TextStyle(
                            fontSize: 13, color: colors.onSurfaceVariant)))
              else
                Expanded(
                    child: ValueListenableBuilder<int?>(
                        valueListenable: widget.navigation.active,
                        builder: _list)),
            ]));
  }

  Widget _list(BuildContext context, int? active, Widget? child) {
    final List<OutlineEntry> entries = widget.navigation.entries.value;
    final int minimum = entries.map(_level).reduce(math.min);
    Widget item(BuildContext context, int index) =>
        _entry(context, entries[index], minimum, active);
    return ScrollablePositionedList.builder(
        itemScrollController: _items,
        itemPositionsListener: _positions,
        initialScrollIndex: math.max(0, entries.indexWhere(_isActive)),
        initialAlignment: entries.indexWhere(_isActive) > 0 ? .2 : 0,
        itemCount: entries.length,
        itemBuilder: item);
  }

  int _level(OutlineEntry entry) => entry.level;

  /// 悬浮与选中独立，鼠标移开后恢复章节原有颜色。
  void _hover(int id, bool hovering) {
    if (!hovering && _hovered != id) return;
    final int? next = hovering ? id : null;
    if (_hovered == next) return;
    setState(() => _hovered = next);
  }

  Widget _entry(
      BuildContext context, OutlineEntry entry, int minimum, int? active) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool selected = entry.id == active;
    final Color accent = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xffA5B4FC)
        : const Color(0xff6366F1);
    final Color hoverColor = Theme.of(context).brightness == Brightness.dark
        ? colors.onSurface
        : Colors.black;
    final Color textColor = _hovered == entry.id
        ? hoverColor
        : selected
            ? accent
            : colors.onSurfaceVariant;
    return Semantics(
        button: true,
        selected: selected,
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                key: ValueKey<String>('outline-entry-${entry.id}'),
                mouseCursor: SystemMouseCursors.click,
                overlayColor:
                    const WidgetStatePropertyAll<Color>(Colors.transparent),
                splashFactory: NoSplash.splashFactory,
                borderRadius: BorderRadius.circular(4),
                onHover: (bool hovering) => _hover(entry.id, hovering),
                onTap: () => widget.onSelected(entry),
                child: SizedBox(
                    height: 26,
                    child: Stack(fit: StackFit.expand, children: <Widget>[
                      Positioned(
                          left: 0,
                          top: 4,
                          bottom: 4,
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 160),
                              width: 2,
                              color: selected ? accent : Colors.transparent)),
                      Padding(
                          padding: EdgeInsets.only(
                              left:
                                  16 + (entry.level - minimum).clamp(0, 3) * 12,
                              right: 8),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(entry.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      letterSpacing: 0,
                                      fontWeight: selected
                                          ? FontWeight.w500
                                          : FontWeight.normal,
                                      color: textColor)))),
                    ])))));
  }
}
