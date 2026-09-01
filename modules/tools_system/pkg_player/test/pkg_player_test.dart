import 'package:flutter_test/flutter_test.dart';
import 'package:pkg_player/pkg_player.dart';

void main() {
  test('公开用户资料正确解析可选字段', () {
    final PublicUserProfile profile = PublicUserProfile.fromJson({
      'user_id': 7,
      'nickname': '测试用户',
      'avatar': null,
      'signature': '保持好奇',
    });

    expect(profile.userId, 7);
    expect(profile.nickname, '测试用户');
    expect(profile.avatar, isNull);
    expect(profile.signature, '保持好奇');
  });
}
