import 'package:flutter/material.dart';

import 'catalog.dart';
import 'sidebar_sections.dart';

/// 可搜索、可分类的桌面工具目录侧栏。
class ToolLibrarySidebar extends StatefulWidget {
  /// 当前选择的工具。
  final DeveloperTool selectedTool;

  /// 当前收藏的工具。
  final Set<DeveloperTool> favoriteTools;

  /// 工具选择回调。
  final ToolSelected onSelected;

  /// 收藏状态切换回调。
  final FavoriteChanged onFavoriteChanged;

  /// 创建工具目录侧栏。
  const ToolLibrarySidebar({
    super.key,
    required this.selectedTool,
    required this.favoriteTools,
    required this.onSelected,
    required this.onFavoriteChanged,
  });

  @override
  State<ToolLibrarySidebar> createState() => _ToolLibrarySidebarState();
}

class _ToolLibrarySidebarState extends State<ToolLibrarySidebar> {
  /// 工具目录在桌面工作台中的固定宽度。
  static const double _sidebarWidth = 200;

  /// 搜索输入控制器。
  final TextEditingController _searchController = TextEditingController();

  /// 当前工具查询文本。
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color background =
        isDark ? const Color(0xff1e2024) : const Color(0xfffbfcfd);
    return ColoredBox(
      color: background,
      child: SizedBox(
        width: _sidebarWidth,
        child: Column(
          children: [
            _buildHeading(context),
            Expanded(child: _buildDirectory()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '工具宝箱',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 30,
            child: TextField(
              controller: _searchController,
              onChanged: _onQueryChanged,
              style: const TextStyle(fontSize: 12),
              decoration: InputDecoration(
                hintText: '搜索工具',
                prefixIcon: const Icon(Icons.search_rounded, size: 16),
                prefixIconConstraints: const BoxConstraints(minWidth: 30),
                suffixIcon: _query.isEmpty
                    ? null
                    : IconButton(
                        tooltip: '清空搜索',
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.close_rounded, size: 15),
                      ),
                filled: true,
                fillColor: Theme.of(context).colorScheme.surface,
                border: _searchBorder(context),
                enabledBorder: _searchBorder(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder _searchBorder(BuildContext context) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(3),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.outlineVariant,
      ),
    );
  }

  Widget _buildDirectory() {
    if (_query.isNotEmpty) {
      final List<DeveloperTool> matches =
          DeveloperTool.values.where(_matchesQuery).toList(growable: false);
      return ToolSectionList(
        title: '搜索结果',
        icon: Icons.search_rounded,
        tools: matches,
        selectedTool: widget.selectedTool,
        favoriteTools: widget.favoriteTools,
        onSelected: widget.onSelected,
        onFavoriteChanged: widget.onFavoriteChanged,
        emptyMessage: '没有匹配的工具',
      );
    }

    return ListView(
      padding: const EdgeInsets.only(bottom: 16),
      children: [
        ToolSectionList(
          title: '收藏',
          icon: Icons.star_rounded,
          iconColor: Colors.orange,
          tools: DeveloperTool.values
              .where(widget.favoriteTools.contains)
              .toList(growable: false),
          selectedTool: widget.selectedTool,
          favoriteTools: widget.favoriteTools,
          onSelected: widget.onSelected,
          onFavoriteChanged: widget.onFavoriteChanged,
          emptyMessage: '点击图钉收藏常用工具',
        ),
        const ToolDirectoryDivider(),
        const ToolDirectoryLabel(),
        ...ToolCategory.values.map(_buildCategory),
      ],
    );
  }

  Widget _buildCategory(ToolCategory category) {
    final List<DeveloperTool> tools = DeveloperTool.values
        .where((DeveloperTool tool) => tool.category == category)
        .toList(growable: false);
    return ToolCategorySection(
      category: category,
      tools: tools,
      selectedTool: widget.selectedTool,
      favoriteTools: widget.favoriteTools,
      onSelected: widget.onSelected,
      onFavoriteChanged: widget.onFavoriteChanged,
    );
  }

  bool _matchesQuery(DeveloperTool tool) {
    final String normalizedQuery = _query.toLowerCase();
    return tool.label.toLowerCase().contains(normalizedQuery) ||
        tool.description.toLowerCase().contains(normalizedQuery) ||
        tool.category.label.contains(_query);
  }

  void _onQueryChanged(String value) {
    setState(() => _query = value.trim());
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }
}
