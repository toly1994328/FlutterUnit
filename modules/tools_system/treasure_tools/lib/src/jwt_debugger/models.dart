/// JWT 解码后的完整数据。
class JwtDebugResult {
  /// 解码后的 JOSE Header。
  final Map<String, Object?> header;

  /// 解码后的 Payload。
  final Map<String, Object?> payload;

  /// 原始签名段。
  final String signature;

  /// 创建 JWT 解码结果。
  const JwtDebugResult({
    required this.header,
    required this.payload,
    required this.signature,
  });

  /// 返回指定 NumericDate 声明对应的 UTC 时间。
  DateTime? dateClaim(String name) {
    final Object? value = payload[name];
    if (value is! num) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(
      (value * Duration.millisecondsPerSecond).round(),
      isUtc: true,
    );
  }

  /// 当前 Token 是否已经超过 exp 声明。
  bool get isExpired {
    final DateTime? expiresAt = dateClaim('exp');
    return expiresAt != null && !expiresAt.isAfter(DateTime.now().toUtc());
  }

  /// 当前 Token 是否尚未到 nbf 声明指定的生效时间。
  bool get isNotActiveYet {
    final DateTime? notBefore = dateClaim('nbf');
    return notBefore != null && notBefore.isAfter(DateTime.now().toUtc());
  }
}

/// JWT 输入无法解码时抛出的领域异常。
class JwtDecodeException implements Exception {
  /// 面向用户的错误说明。
  final String message;

  /// 创建 JWT 解码异常。
  const JwtDecodeException(this.message);

  @override
  String toString() => message;
}
