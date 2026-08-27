import 'dart:convert';

import 'models.dart';

/// 解析标准三段式 compact JWT，不执行签名验证。
class JwtParser {
  /// 将 JWT 文本解码为 Header、Payload 和签名段。
  JwtDebugResult parse(String source) {
    final String token = source.trim();
    if (token.isEmpty) {
      throw const JwtDecodeException('请输入 JWT');
    }

    final List<String> segments = token.split('.');
    if (segments.length != 3) {
      throw const JwtDecodeException('JWT 应由 Header、Payload、Signature 三段组成');
    }

    final Map<String, Object?> header = _decodeObject(segments[0], 'Header');
    final Map<String, Object?> payload = _decodeObject(segments[1], 'Payload');
    return JwtDebugResult(
      header: header,
      payload: payload,
      signature: segments[2],
    );
  }

  Map<String, Object?> _decodeObject(String segment, String label) {
    if (segment.isEmpty) {
      throw JwtDecodeException('$label 不能为空');
    }

    try {
      final String normalized = base64Url.normalize(segment);
      final String jsonText = utf8.decode(base64Url.decode(normalized));
      final Object? data = jsonDecode(jsonText);
      if (data is! Map) {
        throw JwtDecodeException('$label 必须是 JSON 对象');
      }
      return data.map<String, Object?>(
        (Object? key, Object? value) => MapEntry<String, Object?>(
          key.toString(),
          value,
        ),
      );
    } on JwtDecodeException {
      rethrow;
    } on FormatException catch (error) {
      throw JwtDecodeException('$label 无法解码：${error.message}');
    } catch (error) {
      throw JwtDecodeException('$label 无法解码：$error');
    }
  }
}
