import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'outline_entry.dart';
import 'reading_heading.dart';

/// 目录与惰性正文列表共享索引，支持直接跳转未构建的远处章节。
class ReadingNavigation {
  /// 正文按条目定位，不估算图片或代码块的高度。
  final ItemScrollController scroll = ItemScrollController();

  /// 可见正文条目随滚动、图片加载和字号变化更新。
  final ItemPositionsListener positions = ItemPositionsListener.create();

  /// 已加载的目录内容，单独通知目录面板和工具栏。
  final ValueNotifier<List<OutlineEntry>> entries =
      ValueNotifier<List<OutlineEntry>>(<OutlineEntry>[]);

  /// 当前阅读章节，只刷新目录选中状态。
  final ValueNotifier<int?> active = ValueNotifier<int?>(null);

  /// 按正文条目位置计算的阅读进度。
  final ValueNotifier<double> progress = ValueNotifier<double>(0);

  /// 本轮正文的目录定位数据。
  List<OutlineEntry> _headings = <OutlineEntry>[];

  /// 包含抬头和结束标记的正文列表长度。
  int _blockCount = 0;

  /// 相同目录不重复发布，避免正文和目录循环重建。
  String _signature = '';

  /// 取消已经过期的布局发布。
  int _revision = 0;

  /// 防止路由离开后处理延迟位置通知。
  bool _disposed = false;

  /// 目录跳转时避开覆盖在正文上方的玻璃工具栏。
  double _headingAlignment = .04;

  ReadingNavigation() {
    positions.itemPositions.addListener(_update);
  }

  /// 根据正文实际视口计算标题的安全定位位置。
  void updateViewport(double height, double topInset) {
    _headingAlignment =
        height <= 0 ? .04 : ((topInset + 16) / height).clamp(0, .8);
  }

  /// 使用实际渲染的根级标题，排除引用、列表及代码示例中的标题。
  void bind(List<Widget> blocks) {
    _blockCount = blocks.length;
    final List<OutlineEntry> headings = <OutlineEntry>[];
    for (int index = 0; index < blocks.length; index++) {
      final Widget block = blocks[index];
      if (block is ReadingHeading) {
        block.entry.blockIndex = index;
        headings.add(block.entry);
      }
    }
    _headings = headings;
    final String signature = headings
        .map((OutlineEntry entry) =>
            '${entry.id}/${entry.level}/${entry.blockIndex}/${entry.fragment}/${entry.title}')
        .join('\n');
    final int revision = ++_revision;
    void publish(Duration timestamp) {
      if (_disposed || revision != _revision) return;
      if (_signature != signature) {
        _signature = signature;
        entries.value = List<OutlineEntry>.unmodifiable(headings);
      }
      _update();
    }

    WidgetsBinding.instance.addPostFrameCallback(publish);
  }

  /// 以顶部附近的真实可见条目判断当前章节，不在滚动时重新解析 Markdown。
  void _update() {
    if (_disposed || _blockCount == 0) return;
    final List<ItemPosition> visible = positions.itemPositions.value
        .where((ItemPosition item) =>
            item.itemLeadingEdge < 1 && item.itemTrailingEdge > 0)
        .toList()
      ..sort(_comparePosition);
    if (visible.isEmpty) return;
    final bool atEnd = visible.last.index == _blockCount - 1 &&
        visible.last.itemTrailingEdge <= 1;
    ItemPosition current = visible.first;
    for (final ItemPosition item in visible) {
      if (item.itemLeadingEdge <= .12) current = item;
    }
    int? section;
    for (final OutlineEntry entry in _headings) {
      if (entry.blockIndex <= current.index || atEnd) section = entry.id;
    }
    active.value = section;
    final ItemPosition first = visible.first;
    final double height = first.itemTrailingEdge - first.itemLeadingEdge;
    final double fraction =
        height <= 0 ? 0 : (-first.itemLeadingEdge / height).clamp(0, 1);
    progress.value =
        atEnd ? 1 : ((first.index + fraction) / (_blockCount - 1)).clamp(0, 1);
  }

  int _comparePosition(ItemPosition a, ItemPosition b) =>
      a.index.compareTo(b.index);

  /// 重名标题使用独立索引，远处章节无需事先滚动到可见区域。
  Future<void> select(OutlineEntry entry) async {
    if (_disposed || !scroll.isAttached) return;
    await scroll.scrollTo(
        index: entry.blockIndex,
        alignment: _headingAlignment,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeInOutCubic);
    if (!_disposed) active.value = entry.id;
  }

  Future<void> top() async {
    if (_disposed || !scroll.isAttached) return;
    await scroll.scrollTo(
        index: 0,
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut);
    if (!_disposed) active.value = null;
  }

  /// 文内锚点留在当前阅读页，兼容中文与百分号编码。
  Future<bool> openFragment(String fragment) async {
    String decoded;
    try {
      decoded = Uri.decodeComponent(fragment);
    } on FormatException {
      return false;
    }
    if (decoded.isEmpty) {
      await top();
      return true;
    }
    final String target = outlineFragment(decoded);
    for (final OutlineEntry entry in _headings) {
      if (entry.fragment == target || entry.title == decoded) {
        await select(entry);
        return true;
      }
    }
    return false;
  }

  /// 刷新正文时清除旧目录和阅读位置。
  void reset() {
    if (scroll.isAttached) scroll.jumpTo(index: 0);
    _revision++;
    _signature = '';
    _headings = <OutlineEntry>[];
    _blockCount = 0;
    entries.value = <OutlineEntry>[];
    active.value = null;
    progress.value = 0;
  }

  void dispose() {
    _disposed = true;
    positions.itemPositions.removeListener(_update);
    entries.dispose();
    active.dispose();
    progress.dispose();
  }
}
