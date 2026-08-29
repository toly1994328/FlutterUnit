import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import '../../toolbox/catalog.dart';

/// 移动端工具宝箱目录页。
class MobileToolPage extends StatelessWidget {
  const MobileToolPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String title = context.l10n.treasureTools;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
          children: ToolCategory.values
              .where(_hasMobileTool)
              .map(_buildCategorySection)
              .toList(growable: false),
        ),
      ),
    );
  }

  bool _hasMobileTool(ToolCategory category) {
    return DeveloperTool.values.any(
      (DeveloperTool tool) => tool.category == category && tool.supportsMobile,
    );
  }

  /// 按业务分类构建移动端工具入口。
  Widget _buildCategorySection(ToolCategory category) {
    final List<DeveloperTool> tools = DeveloperTool.values
        .where(
          (DeveloperTool tool) =>
              tool.category == category && tool.supportsMobile,
        )
        .toList(growable: false);
    return _ToolCategorySection(category: category, tools: tools);
  }
}

class _ToolCategorySection extends StatelessWidget {
  /// 当前工具分类。
  final ToolCategory category;

  /// 分类下的工具列表。
  final List<DeveloperTool> tools;

  const _ToolCategorySection({required this.category, required this.tools});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Row(
              children: <Widget>[
                Icon(
                  category.icon,
                  size: 17,
                  color: const Color(0xff66707c),
                ),
                const SizedBox(width: 7),
                Text(
                  category.label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff424954),
                  ),
                ),
              ],
            ),
          ),
          Material(
            color: const Color(0xfff6f7f9),
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(14),
            child: Column(
              children: tools
                  .map((DeveloperTool tool) => _ToolEntry(tool: tool))
                  .toList(growable: false),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToolEntry extends StatelessWidget {
  /// 当前工具入口数据。
  final DeveloperTool tool;

  const _ToolEntry({required this.tool});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
      leading: Container(
        width: 36,
        height: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xffe8f0fb),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(tool.icon, size: 20, color: const Color(0xff366ca8)),
      ),
      title: Text(
        tool.label,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        tool.description,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 12, color: Color(0xff7b818b)),
      ),
      trailing: const Icon(
        Icons.chevron_right_rounded,
        size: 20,
        color: Color(0xff9aa0a8),
      ),
      onTap: () => _openTool(context),
    );
  }

  /// 打开独立的移动端工具详情页。
  void _openTool(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => _MobileToolDetailPage(tool: tool),
      ),
    );
  }
}

class _MobileToolDetailPage extends StatelessWidget {
  /// 当前展示的工具。
  final DeveloperTool tool;

  const _MobileToolDetailPage({required this.tool});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(tool.label)),
      body: tool.buildView(),
    );
  }
}
