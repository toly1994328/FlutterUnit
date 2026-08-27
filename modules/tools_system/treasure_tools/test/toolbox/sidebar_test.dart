import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treasure_tools/src/toolbox/catalog.dart';
import 'package:treasure_tools/src/toolbox/sidebar.dart';

void main() {
  testWidgets('搜索仅展示匹配工具并可选择', (WidgetTester tester) async {
    DeveloperTool? selected;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ToolLibrarySidebar(
            selectedTool: DeveloperTool.jwtDebugger,
            recentTools: const [DeveloperTool.jwtDebugger],
            favoriteTools: const {DeveloperTool.jwtDebugger},
            onSelected: (DeveloperTool tool) => selected = tool,
            onFavoriteChanged: (DeveloperTool tool) {},
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'IconFont');
    await tester.pump();

    expect(find.text('IconFont'), findsNWidgets(2));
    expect(find.text('JSON 解析'), findsNothing);

    await tester.tap(find.text('IconFont').last);
    expect(selected, DeveloperTool.iconFont);
  });

  testWidgets('点击图钉触发收藏切换', (WidgetTester tester) async {
    DeveloperTool? changed;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ToolLibrarySidebar(
            selectedTool: DeveloperTool.jwtDebugger,
            recentTools: const [DeveloperTool.jwtDebugger],
            favoriteTools: const {},
            onSelected: (DeveloperTool tool) {},
            onFavoriteChanged: (DeveloperTool tool) => changed = tool,
          ),
        ),
      ),
    );

    await tester.tap(find.byTooltip('收藏工具').first);

    expect(changed, DeveloperTool.jwtDebugger);
  });
}
