import 'package:flutter/material.dart';

import 'catalog.dart';

typedef ToolSelected = void Function(DeveloperTool tool);
typedef FavoriteChanged = void Function(DeveloperTool tool);

/// 带标题的工具条目分组。
class ToolSectionList extends StatelessWidget {
  /// 列表标题。
  final String title;

  /// 列表图标。
  final IconData icon;

  /// 可选图标颜色。
  final Color? iconColor;

  /// 列表工具。
  final List<DeveloperTool> tools;

  /// 当前工具。
  final DeveloperTool selectedTool;

  /// 收藏集合。
  final Set<DeveloperTool> favoriteTools;

  /// 工具选择回调。
  final ToolSelected onSelected;

  /// 收藏切换回调。
  final FavoriteChanged onFavoriteChanged;

  /// 空列表说明。
  final String? emptyMessage;

  /// 创建工具分组列表。
  const ToolSectionList({
    super.key,
    required this.title,
    required this.icon,
    required this.tools,
    required this.selectedTool,
    required this.favoriteTools,
    required this.onSelected,
    required this.onFavoriteChanged,
    this.iconColor,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            child: Row(
              children: [
                Icon(icon, size: 14, color: iconColor),
                const SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          if (tools.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(34, 5, 8, 8),
              child: Text(
                emptyMessage ?? '暂无工具',
                style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            )
          else
            ...tools.map(_buildToolTile),
        ],
      ),
    );
  }

  Widget _buildToolTile(DeveloperTool tool) {
    return ToolDirectoryTile(
      tool: tool,
      selected: tool == selectedTool,
      favorite: favoriteTools.contains(tool),
      onSelected: onSelected,
      onFavoriteChanged: onFavoriteChanged,
    );
  }
}

/// 可展开的工具分类。
class ToolCategorySection extends StatelessWidget {
  /// 工具分类。
  final ToolCategory category;

  /// 分类下工具。
  final List<DeveloperTool> tools;

  /// 当前工具。
  final DeveloperTool selectedTool;

  /// 收藏集合。
  final Set<DeveloperTool> favoriteTools;

  /// 工具选择回调。
  final ToolSelected onSelected;

  /// 收藏切换回调。
  final FavoriteChanged onFavoriteChanged;

  /// 创建可展开工具分类。
  const ToolCategorySection({
    super.key,
    required this.category,
    required this.tools,
    required this.selectedTool,
    required this.favoriteTools,
    required this.onSelected,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 3, 8, 4),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 28,
            child: Row(
              children: <Widget>[
                const SizedBox(width: 6),
                Icon(category.icon, size: 14),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    category.label,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  '${tools.length}',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(width: 6),
              ],
            ),
          ),
          ...tools.map(_buildToolTile),
        ],
      ),
    );
  }

  Widget _buildToolTile(DeveloperTool tool) {
    return ToolDirectoryTile(
      tool: tool,
      selected: tool == selectedTool,
      favorite: favoriteTools.contains(tool),
      onSelected: onSelected,
      onFavoriteChanged: onFavoriteChanged,
    );
  }
}

/// 工具目录中的单个可选择条目。
class ToolDirectoryTile extends StatelessWidget {
  /// 工具信息。
  final DeveloperTool tool;

  /// 是否为当前工具。
  final bool selected;

  /// 是否已收藏。
  final bool favorite;

  /// 工具选择回调。
  final ToolSelected onSelected;

  /// 收藏切换回调。
  final FavoriteChanged onFavoriteChanged;

  /// 创建工具条目。
  const ToolDirectoryTile({
    super.key,
    required this.tool,
    required this.selected,
    required this.favorite,
    required this.onSelected,
    required this.onFavoriteChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color accentColor =
        isDark ? const Color(0xff69a7ff) : const Color(0xff2468b4);
    final Color normalTextColor = Theme.of(context).colorScheme.onSurface;
    final Color background = selected
        ? isDark
            ? const Color(0xff243142)
            : const Color(0xffeef4fb)
        : Colors.transparent;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => onSelected(tool),
        child: Container(
          height: 32,
          decoration: BoxDecoration(
            color: background,
            border: selected
                ? Border(left: BorderSide(color: accentColor, width: 2))
                : null,
          ),
          padding: EdgeInsets.only(left: selected ? 8 : 10, right: 4),
          child: Row(
            children: <Widget>[
              Icon(
                tool.icon,
                size: 15,
                color: selected ? accentColor : normalTextColor,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  tool.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    color: normalTextColor,
                  ),
                ),
              ),
              Tooltip(
                message: favorite ? '取消收藏' : '收藏工具',
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => onFavoriteChanged(tool),
                    child: SizedBox(
                      width: 24,
                      height: 28,
                      child: Icon(
                        favorite
                            ? Icons.push_pin_rounded
                            : Icons.push_pin_outlined,
                        size: 14,
                        color: favorite
                            ? accentColor
                            : Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 工具分类区标题。
class ToolDirectoryLabel extends StatelessWidget {
  /// 创建分类标题。
  const ToolDirectoryLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(18, 10, 18, 6),
      child: Row(
        children: [
          Icon(Icons.tune_rounded, size: 14),
          SizedBox(width: 6),
          Text('工具目录',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

/// 最近、收藏与分类之间的分隔线。
class ToolDirectoryDivider extends StatelessWidget {
  /// 创建侧栏分隔线。
  const ToolDirectoryDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 17,
      indent: 18,
      endIndent: 18,
      color: Theme.of(context).colorScheme.outlineVariant,
    );
  }
}
