import 'package:flutter/material.dart';

import 'toolbox/catalog.dart';
import 'toolbox/desktop_theme.dart';
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

  /// 按打开顺序排列的桌面工具标签。
  final List<DeveloperTool> _openTools = [DeveloperTool.jwtDebugger];

  /// 当前会话收藏的工具。
  final Set<DeveloperTool> _favoriteTools = {
    DeveloperTool.jwtDebugger,
    DeveloperTool.jsonParser,
    DeveloperTool.urlCodec,
  };

  /// 打开或激活工具对应的桌面标签。
  void _selectTool(DeveloperTool tool) {
    setState(() {
      if (!_openTools.contains(tool)) {
        _openTools.add(tool);
      }
      _selectedTool = tool;
    });
  }

  /// 关闭指定标签，并在必要时激活相邻工具。
  void _closeTool(DeveloperTool tool) {
    if (_openTools.length == 1) {
      return;
    }
    setState(() {
      final int closingIndex = _openTools.indexOf(tool);
      _openTools.remove(tool);
      if (_selectedTool == tool) {
        final int nextIndex =
            closingIndex.clamp(0, _openTools.length - 1).toInt();
        _selectedTool = _openTools[nextIndex];
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
    return Theme(
      data: buildToolboxDesktopTheme(context),
      child: Scaffold(
        body: Row(
          children: <Widget>[
            ToolLibrarySidebar(
              selectedTool: _selectedTool,
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
                  ToolboxHeader(
                    tools: _openTools,
                    selectedTool: _selectedTool,
                    onSelected: _selectTool,
                    onClosed: _closeTool,
                  ),
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
      ),
    );
  }
}
