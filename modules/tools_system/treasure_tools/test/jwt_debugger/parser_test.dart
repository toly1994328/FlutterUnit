import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:treasure_tools/src/jwt_debugger/models.dart';
import 'package:treasure_tools/src/jwt_debugger/parser.dart';

void main() {
  final JwtParser parser = JwtParser();

  test('解析标准三段式 JWT', () {
    final String token = _token(
      {'alg': 'HS256', 'typ': 'JWT'},
      {'sub': '42', 'exp': 4102444800},
      'signature',
    );

    final JwtDebugResult result = parser.parse(token);

    expect(result.header['alg'], 'HS256');
    expect(result.payload['sub'], '42');
    expect(result.signature, 'signature');
    expect(result.isExpired, isFalse);
  });

  test('识别已过期 Token', () {
    final String token = _token(
      {'alg': 'none'},
      {'exp': 1},
      '',
    );

    expect(parser.parse(token).isExpired, isTrue);
  });

  test('拒绝非三段式输入', () {
    expect(
      () => parser.parse('header.payload'),
      throwsA(isA<JwtDecodeException>()),
    );
  });

  test('拒绝非 JSON 对象 Payload', () {
    final String token = _token({'alg': 'none'}, ['value'], '');

    expect(
      () => parser.parse(token),
      throwsA(
        isA<JwtDecodeException>().having(
          (JwtDecodeException error) => error.message,
          'message',
          contains('Payload 必须是 JSON 对象'),
        ),
      ),
    );
  });
}

String _token(Object header, Object payload, String signature) {
  final String headerSegment = _segment(header);
  final String payloadSegment = _segment(payload);
  return '$headerSegment.$payloadSegment.$signature';
}

String _segment(Object value) {
  return base64Url.encode(utf8.encode(jsonEncode(value))).replaceAll('=', '');
}
