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
      padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Icon(icon, size: 18, color: iconColor),
                const SizedBox(width: 8),
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
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
    return ExpansionTile(
      initiallyExpanded: tools.contains(selectedTool),
      tilePadding: const EdgeInsets.symmetric(horizontal: 18),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      leading: Icon(category.icon, size: 18),
      title: Text(category.label, style: const TextStyle(fontSize: 13)),
      trailing: Text(
        '${tools.length}',
        style: TextStyle(
          fontSize: 11,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
      children: tools.map(_buildToolTile).toList(growable: false),
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
    final Color primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: selected
            ? primaryColor.withValues(alpha: 0.11)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(7),
        child: InkWell(
          borderRadius: BorderRadius.circular(7),
          onTap: () => onSelected(tool),
          child: SizedBox(
            height: 42,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 2),
              child: Row(
                children: [
                  Icon(
                    tool.icon,
                    size: 18,
                    color: selected ? primaryColor : null,
                  ),
                  const SizedBox(width: 9),
                  Expanded(
                    child: Text(
                      tool.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight:
                            selected ? FontWeight.w600 : FontWeight.w400,
                        color: selected ? primaryColor : null,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: favorite ? '取消收藏' : '收藏工具',
                    onPressed: () => onFavoriteChanged(tool),
                    visualDensity: VisualDensity.compact,
                    icon: Icon(
                      favorite
                          ? Icons.push_pin_rounded
                          : Icons.push_pin_outlined,
                      size: 16,
                      color: favorite
                          ? primaryColor
                          : Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
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
          Icon(Icons.tune_rounded, size: 18),
          SizedBox(width: 8),
          Text('分类', style: TextStyle(fontWeight: FontWeight.w700)),
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
