import 'dart:convert';

import 'package:cryptography/cryptography.dart';

/// AES 工作模式。
enum AesCipherMode {
  gcm('AES-GCM'),
  cbc('AES-CBC / PKCS7 / HMAC-SHA256');

  /// 界面显示名称。
  final String label;

  const AesCipherMode(this.label);
}

/// AES 密钥规格。
enum AesKeySize {
  bits128(128, 16),
  bits192(192, 24),
  bits256(256, 32);

  /// 密钥位数。
  final int bits;

  /// 密钥字节数。
  final int bytes;

  const AesKeySize(this.bits, this.bytes);
}

/// AES 加解密所需的输入参数。
class AesCipherRequest {
  /// 工作模式。
  final AesCipherMode mode;

  /// 密钥规格。
  final AesKeySize keySize;

  /// Base64 编码的密钥。
  final String key;

  /// Base64 编码的 IV 或 Nonce。
  final String nonce;

  /// 明文或 Base64 密文。
  final String input;

  const AesCipherRequest({
    required this.mode,
    required this.keySize,
    required this.key,
    required this.nonce,
    required this.input,
  });
}

/// AES 工具的无状态加解密服务。
class AesCipherService {
  const AesCipherService();

  /// 生成符合模式和密钥规格的 Base64 密钥。
  Future<String> generateKey(AesCipherMode mode, AesKeySize keySize) async {
    final Cipher cipher = _createCipher(mode, keySize);
    final SecretKey secretKey = await cipher.newSecretKey();
    final List<int> bytes = await secretKey.extractBytes();
    return base64Encode(bytes);
  }

  /// 生成符合当前模式长度要求的 Base64 IV 或 Nonce。
  String generateNonce(AesCipherMode mode, AesKeySize keySize) {
    final Cipher cipher = _createCipher(mode, keySize);
    return base64Encode(cipher.newNonce());
  }

  /// 将 UTF-8 明文加密为“密文 + 认证码”的 Base64 字符串。
  Future<String> encrypt(AesCipherRequest request) async {
    final Cipher cipher = _createCipher(request.mode, request.keySize);
    final List<int> keyBytes = _decodeKey(request);
    final List<int> nonceBytes = _decodeNonce(request, cipher);
    final SecretBox secretBox = await cipher.encrypt(
      utf8.encode(request.input),
      secretKey: SecretKey(keyBytes),
      nonce: nonceBytes,
    );
    return base64Encode(<int>[
      ...secretBox.cipherText,
      ...secretBox.mac.bytes,
    ]);
  }

  /// 将“密文 + 认证码”的 Base64 字符串解密为 UTF-8 明文。
  Future<String> decrypt(AesCipherRequest request) async {
    final Cipher cipher = _createCipher(request.mode, request.keySize);
    final List<int> keyBytes = _decodeKey(request);
    final List<int> nonceBytes = _decodeNonce(request, cipher);
    final List<int> payload = base64Decode(request.input.trim());
    final int macLength = cipher.macAlgorithm.macLength;
    if (payload.length <= macLength) {
      throw const FormatException('密文长度不足，无法读取认证码。');
    }
    final int cipherTextEnd = payload.length - macLength;
    final SecretBox secretBox = SecretBox(
      payload.sublist(0, cipherTextEnd),
      nonce: nonceBytes,
      mac: Mac(payload.sublist(cipherTextEnd)),
    );
    final List<int> clearText = await cipher.decrypt(
      secretBox,
      secretKey: SecretKey(keyBytes),
    );
    return utf8.decode(clearText);
  }

  Cipher _createCipher(AesCipherMode mode, AesKeySize keySize) {
    return switch ((mode, keySize)) {
      (AesCipherMode.gcm, AesKeySize.bits128) => AesGcm.with128bits(),
      (AesCipherMode.gcm, AesKeySize.bits192) => AesGcm.with192bits(),
      (AesCipherMode.gcm, AesKeySize.bits256) => AesGcm.with256bits(),
      (AesCipherMode.cbc, AesKeySize.bits128) =>
        AesCbc.with128bits(macAlgorithm: Hmac.sha256()),
      (AesCipherMode.cbc, AesKeySize.bits192) =>
        AesCbc.with192bits(macAlgorithm: Hmac.sha256()),
      (AesCipherMode.cbc, AesKeySize.bits256) =>
        AesCbc.with256bits(macAlgorithm: Hmac.sha256()),
    };
  }

  List<int> _decodeKey(AesCipherRequest request) {
    final List<int> bytes = base64Decode(request.key.trim());
    if (bytes.length != request.keySize.bytes) {
      throw FormatException(
        '${request.keySize.bits} 位密钥必须是 ${request.keySize.bytes} 字节。',
      );
    }
    return bytes;
  }

  List<int> _decodeNonce(AesCipherRequest request, Cipher cipher) {
    final List<int> bytes = base64Decode(request.nonce.trim());
    if (bytes.length != cipher.nonceLength) {
      throw FormatException('当前模式的 IV / Nonce 必须是 ${cipher.nonceLength} 字节。');
    }
    return bytes;
  }
}
