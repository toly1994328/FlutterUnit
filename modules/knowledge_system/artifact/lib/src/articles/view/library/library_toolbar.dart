import 'package:flutter/material.dart';
import 'library_bottom_sheets.dart';

/// 文库检索栏，手机使用单行轻量入口，宽窗口展示完整操作。
class LibraryToolbar extends StatelessWidget {
  /// 搜索文本控制器。
  final TextEditingController search;

  /// 输入防抖回调。
  final ValueChanged<String> onSearch;

  /// 提交当前检索。
  final ValueChanged<String> onSubmit;

  /// 当前排序。
  final String sort;

  /// 排序切换回调。
  final ValueChanged<String?> onSort;

  /// 已选择的主题数量。
  final int topicCount;

  /// 锚定在筛选按钮上的主题面板。
  final Widget topicFilter;

  /// 重置所有筛选。
  final VoidCallback onReset;

  /// 窄屏将筛选和排序折叠为图标入口。
  final bool compact;
  const LibraryToolbar(
      {super.key,
      required this.search,
      required this.onSearch,
      required this.onSubmit,
      required this.sort,
      required this.onSort,
      required this.topicCount,
      required this.topicFilter,
      required this.onReset,
      this.compact = false});

  @override
  Widget build(BuildContext context) => LayoutBuilder(builder: _layout);

  Widget _layout(BuildContext context, BoxConstraints box) {
    if (compact) return _compactToolbar(context);
    final bool filtered =
        topicCount > 0 || search.text.isNotEmpty || sort != 'recent';
    if (box.maxWidth >= 680) {
      return Row(children: <Widget>[
        Expanded(child: _searchField(context)),
        const SizedBox(width: 12),
        topicFilter,
        const SizedBox(width: 12),
        _sortField(context),
        if (filtered) ...<Widget>[
          const SizedBox(width: 8),
          TextButton(onPressed: onReset, child: const Text('重置')),
        ],
      ]);
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _searchField(context),
          const SizedBox(height: 12),
          Wrap(spacing: 12, runSpacing: 8, children: <Widget>[
            topicFilter,
            _sortField(context),
            if (filtered)
              TextButton(onPressed: onReset, child: const Text('重置')),
          ]),
        ]);
  }

  /// 搜索占据主要宽度，主题与排序紧随其后，避免操作区占两行。
  Widget _compactToolbar(BuildContext context) => Row(children: <Widget>[
        Expanded(
            child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: search, builder: _compactSearch)),
        const SizedBox(width: 8),
        topicFilter,
        const SizedBox(width: 8),
        _compactSort(context),
      ]);

  Widget _compactSearch(
      BuildContext context, TextEditingValue value, Widget? child) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none);
    final bool filtered =
        topicCount > 0 || value.text.isNotEmpty || sort != 'recent';
    return SizedBox(
        height: 44,
        child: TextField(
            controller: search,
            onChanged: onSearch,
            onSubmitted: onSubmit,
            textInputAction: TextInputAction.search,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
                hintText: '搜索文章',
                isDense: true,
                filled: true,
                fillColor: colors.surface,
                contentPadding: const EdgeInsets.symmetric(vertical: 12),
                prefixIcon: const Icon(Icons.search_rounded, size: 19),
                prefixIconConstraints:
                    const BoxConstraints(minWidth: 40, minHeight: 44),
                border: border,
                enabledBorder: border,
                focusedBorder: border.copyWith(
                    borderSide: BorderSide(
                        color: colors.primary.withValues(alpha: .4))),
                suffixIcon: filtered
                    ? IconButton(
                        onPressed: onReset,
                        tooltip: '清空筛选',
                        icon: const Icon(Icons.close_rounded, size: 16))
                    : null)));
  }

  Widget _compactSort(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Semantics(
        label: sort == 'recent' ? '排序：最新创作' : '排序：最早创作',
        button: true,
        child: SizedBox.square(
            dimension: 44,
            child: IconButton(
                onPressed: () => _openSort(context),
                style: IconButton.styleFrom(
                    backgroundColor: colors.onSurface.withValues(alpha: .035),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12))),
                icon: Icon(Icons.swap_vert_rounded,
                    size: 22,
                    color: sort == 'recent'
                        ? colors.onSurfaceVariant
                        : colors.primary))));
  }

  /// 移动端排序从底部选择，取消时保留原顺序。
  Future<void> _openSort(BuildContext context) async {
    FocusScope.of(context).unfocus();
    final String? selected = await showLibrarySort(context, sort);
    if (context.mounted && selected != null && selected != sort) {
      onSort(selected);
    }
  }

  Widget _searchField(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final OutlineInputBorder border = OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: BorderSide(color: colors.outlineVariant));
    return SizedBox(
        height: 40,
        child: TextField(
            controller: search,
            onChanged: onSearch,
            onSubmitted: onSubmit,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(
              hintText: '搜索文章标题、摘要',
              isDense: true,
              filled: true,
              fillColor: colors.surface.withValues(alpha: .5),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              prefixIcon: const Icon(Icons.search, size: 20),
              border: border,
              enabledBorder: border,
              suffixIcon: IconButton(
                  onPressed: onReset,
                  tooltip: '清空筛选',
                  icon: const Icon(Icons.close, size: 16)),
            )));
  }

  Widget _sortField(BuildContext context) => Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
          border:
              Border.all(color: Theme.of(context).colorScheme.outlineVariant),
          borderRadius: BorderRadius.circular(6)),
      child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
              value: sort,
              onChanged: onSort,
              style: TextStyle(
                  fontSize: 13, color: Theme.of(context).colorScheme.onSurface),
              items: const <DropdownMenuItem<String>>[
            DropdownMenuItem(value: 'recent', child: Text('最新创作')),
            DropdownMenuItem(value: 'oldest', child: Text('最早创作')),
          ])));
}
