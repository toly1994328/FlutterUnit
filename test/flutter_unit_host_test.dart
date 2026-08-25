import 'package:flutter_test/flutter_test.dart';
import 'package:unit_env/unit_env.dart';

void main() {
  test('FlutterUnitHost 使用统一客户端环境配置', () {
    const FlutterUnitHost host = FlutterUnitHost();

    expect(host.url(), FlutterUnitHost.serverUrl);
    expect(host.url(), FlutterUnitHost.serverUri.toString());
  });
}
