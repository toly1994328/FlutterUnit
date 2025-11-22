import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:pkg_player/pkg_player.dart';
import 'package:unit_env/unit_env.dart';

void main() async {
  PackageRequest request = PackageRequest();
  String mockDir = p.join(
    Directory.current.path,
    'test',
    'science_server',
    'moke',
    'output',
  );

  setUpAll(() async {
    FxDio().register(Unit3Host());
  });

  Future<void> getPackageComments() async {
    ApiRet<CommentsResponse> ret = await request.getPackageComments(83);
    if (ret.success) {
      File file = File(p.join(mockDir, 'api_comments.json'));
      await file.parent.create(recursive: true);
      String formattedJson = const JsonEncoder.withIndent('  ').convert({
        'status': true,
        'msg': '请求成功!',
        ...ret.data.toJson(),
      });
      await file.writeAsString(formattedJson);
      print('Comments saved to ${file.path}');
      print('Total comments: ${ret.data.total}');
    } else {
      print('Failed to get comments: ${ret.msg}');
    }
  }

  group('Comments API Tests', () {
    test('/packages/83/comments', getPackageComments);
  });
}
