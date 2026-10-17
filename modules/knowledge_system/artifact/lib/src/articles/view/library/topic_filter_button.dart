import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';
import 'topic_picker.dart';
import 'library_bottom_sheets.dart';

/// 手机从底部打开主题筛选，桌面使用 TolyUI 锚定悬浮面板。
class TopicFilterButton extends StatefulWidget {
  const TopicFilterButton(
      {super.key,
      required this.selected,
      required this.loadTopics,
      required this.onApply,
      this.compact = false});

  /// 当前已生效的主题标识。
  final List<String> selected;

  /// 每次打开或重试时获取最新主题及文章数。
  final TopicLoader loadTopics;

  /// 用户确认后提交筛选条件。
  final ValueChanged<List<String>> onApply;

  /// 手机检索栏使用无边框图标和已选数量角标。
  final bool compact;
  @override
  State<TopicFilterButton> createState() => _TopicFilterButtonState();
}

class _TopicFilterButtonState extends State<TopicFilterButton> {
  /// 面板控制器，负责点击外部、滚动和窗口变化时收起。
  final PopoverController _popover = PopoverController();

  /// 按钮当前是否展开。
  bool _open = false;
  void _opened() => setState(() => _open = true);
  void _closed() => setState(() => _open = false);

  /// 使用面板的相对定位入口，避免旧版自动避让反复切换方位。
  Future<void> _toggle() async {
    if (widget.compact) {
      await _openBottomSheet();
      return;
    }
    if (_open) {
      _popover.close();
      return;
    }
    final RenderBox trigger = context.findRenderObject()! as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject()! as RenderBox;
    final Offset origin = trigger.localToGlobal(Offset.zero, ancestor: overlay);
    final double width = math.min(520, overlay.size.width - 32);
    final double height = math.min(600, overlay.size.height - 48);
    final double left = (origin.dx + trigger.size.width - width)
        .clamp(16, overlay.size.width - width - 16);
    double top = origin.dy + trigger.size.height + 8;
    if (top + height > overlay.size.height - 16) {
      top =
          (origin.dy - height - 8).clamp(16, overlay.size.height - height - 16);
    }
    _popover.open(position: Offset(left - origin.dx, top - origin.dy));
  }

  /// 底部弹框关闭或取消不修改主题，确认后才更新查询。
  Future<void> _openBottomSheet() async {
    if (_open) return;
    FocusScope.of(context).unfocus();
    _opened();
    try {
      final List<String>? selected =
          await showLibraryTopics(context, widget.selected, widget.loadTopics);
      if (mounted && selected != null) widget.onApply(selected);
    } finally {
      if (mounted) _closed();
    }
  }

  void _apply(List<String> selected) {
    _popover.close();
    widget.onApply(selected);
  }

  Widget _panel(BuildContext context, PopoverController controller) =>
      TooltipVisibility(
          visible: false,
          child: TopicPicker(
              loadTopics: widget.loadTopics,
              selected: widget.selected,
              onApply: _apply,
              onCancel: controller.close));
  Decoration _decoration(PopoverDecoration decoration) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black.withValues(alpha: .12),
              blurRadius: 28,
              offset: const Offset(0, 8))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final Size viewport = MediaQuery.sizeOf(context);
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool active = _open || widget.selected.isNotEmpty;
    if (widget.compact) return _compactTrigger(colors, active);
    return TolyPopover(
        controller: _popover,
        placement: Placement.bottomEnd,
        gap: 8,
        margin: const EdgeInsets.all(16),
        maxWidth: math.min(520, viewport.width - 32),
        maxHeight: math.min(600, viewport.height - 48),
        onOpen: _opened,
        onClose: _closed,
        overlayBuilder: _panel,
        overlayDecorationBuilder: _decoration,
        child: SizedBox(
            height: 40,
            child: OutlinedButton.icon(
                onPressed: _toggle,
                style: OutlinedButton.styleFrom(
                    backgroundColor:
                        active ? colors.primary.withValues(alpha: .06) : null,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    side: BorderSide(
                        color: active ? colors.primary : colors.outlineVariant),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                icon: const Icon(Icons.filter_alt_outlined, size: 18),
                label: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                  Text(
                      widget.selected.isEmpty
                          ? '主题筛选'
                          : '已选 ${widget.selected.length} 个主题',
                      style: const TextStyle(fontSize: 13)),
                  const SizedBox(width: 6),
                  Icon(_open ? Icons.expand_less : Icons.expand_more, size: 16),
                ]))));
  }

  Widget _compactTrigger(ColorScheme colors, bool active) => Semantics(
      label: widget.selected.isEmpty
          ? '主题筛选'
          : '主题筛选，已选 ${widget.selected.length} 个主题',
      button: true,
      child: SizedBox.square(
          dimension: 44,
          child: IconButton(
              onPressed: _toggle,
              style: IconButton.styleFrom(
                  foregroundColor:
                      active ? colors.primary : colors.onSurfaceVariant,
                  backgroundColor: active
                      ? colors.primary.withValues(alpha: .08)
                      : colors.onSurface.withValues(alpha: .035),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              icon: Badge(
                  isLabelVisible: widget.selected.isNotEmpty,
                  backgroundColor: colors.primary,
                  textColor: colors.onPrimary,
                  label: Text('${widget.selected.length}'),
                  child: const Icon(Icons.tune_rounded, size: 20)))));
}
