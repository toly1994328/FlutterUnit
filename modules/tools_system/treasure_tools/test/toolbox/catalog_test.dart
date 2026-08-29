import 'package:flutter_test/flutter_test.dart';
import 'package:treasure_tools/src/toolbox/catalog.dart';

void main() {
  test('工具目录使用唯一稳定标识', () {
    final List<String> ids = DeveloperTool.values
        .map((DeveloperTool tool) => tool.id)
        .toList(growable: false);

    expect(ids.toSet().length, ids.length);
  });

  test('每个工具都归属于有效分类', () {
    for (final DeveloperTool tool in DeveloperTool.values) {
      expect(ToolCategory.values, contains(tool.category));
    }
  });

  test('移动端工具目录屏蔽 IconFont 生成器', () {
    final List<DeveloperTool> mobileTools = DeveloperTool.values
        .where((DeveloperTool tool) => tool.supportsMobile)
        .toList(growable: false);

    expect(mobileTools, isNot(contains(DeveloperTool.iconFont)));
    expect(mobileTools, contains(DeveloperTool.aesCipher));
  });
}
