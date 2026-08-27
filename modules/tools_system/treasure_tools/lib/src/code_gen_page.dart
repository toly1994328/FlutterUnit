import 'package:flutter/material.dart';

import 'toolbox/catalog.dart';
import 'toolbox/header.dart';
import 'toolbox/sidebar.dart';

/// 桌面端开发工具工作台。
class CodeGenPage extends StatefulWidget {
  /// 创建工具工作台页面。
  const CodeGenPage({super.key});

  @override
  State<CodeGenPage> createState() => _CodeGenPageState();
}

class _CodeGenPageState extends State<CodeGenPage> {
  /// 当前打开的工具。
  DeveloperTool _selectedTool = DeveloperTool.jwtDebugger;

  /// 当前会话内按最近访问顺序排列的工具。
  final List<DeveloperTool> _recentTools = [
    DeveloperTool.jwtDebugger,
    DeveloperTool.jsonParser,
    DeveloperTool.base64Codec,
  ];

  /// 当前会话收藏的工具。
  final Set<DeveloperTool> _favoriteTools = {
    DeveloperTool.jwtDebugger,
    DeveloperTool.jsonParser,
    DeveloperTool.urlCodec,
  };

  /// 切换工具，并将其移动到最近使用列表首位。
  void _selectTool(DeveloperTool tool) {
    setState(() {
      _selectedTool = tool;
      _recentTools
        ..remove(tool)
        ..insert(0, tool);
      if (_recentTools.length > 4) {
        _recentTools.removeLast();
      }
    });
  }

  void _toggleFavorite(DeveloperTool tool) {
    setState(() {
      if (!_favoriteTools.remove(tool)) {
        _favoriteTools.add(tool);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          ToolLibrarySidebar(
            selectedTool: _selectedTool,
            recentTools: _recentTools,
            favoriteTools: _favoriteTools,
            onSelected: _selectTool,
            onFavoriteChanged: _toggleFavorite,
          ),
          VerticalDivider(
            width: 1,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          Expanded(
            child: Column(
              children: [
                ToolboxHeader(tool: _selectedTool),
                Divider(
                  height: 1,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                Expanded(
                  child: IndexedStack(
                    index: DeveloperTool.values.indexOf(_selectedTool),
                    children: DeveloperTool.values
                        .map((DeveloperTool tool) => tool.buildView())
                        .toList(growable: false),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
