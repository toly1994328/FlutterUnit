import 'package:authentication/runtime/user_runtime.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_session/fx_user_session.dart';

void main() {
  test('身份投影公开用户签名字段', () {
    const FxUser source = FxUser(
      id: '42',
      displayName: 'FlutterUnit',
      profile: <String, dynamic>{'signature': '一切皆组件'},
    );

    final FxIdentity identity = const FxUserIdentityCodec().decode(source);

    expect(identity.id, '42');
    expect(identity.displayName, 'FlutterUnit');
    expect(identity.read<String>(FxIdentityFields.signature), '一切皆组件');
  });
}
