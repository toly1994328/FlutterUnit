import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_unit/src/navigation/model/app_tab.dart';

void main() {
  test('移动端主导航使用组件、三方库、知识、工具和我的入口', () {
    expect(
      AppTab.mobileTabs,
      [
        AppTab.widgets,
        AppTab.packages,
        AppTab.knowledge,
        AppTab.tools,
        AppTab.mine,
      ],
    );
    expect(
      AppTab.values.map((AppTab tab) => tab.path),
      isNot(contains('/painter')),
    );
  });
}
