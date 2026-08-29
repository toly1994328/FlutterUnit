import 'package:flutter_test/flutter_test.dart';
import 'package:treasure_tools/src/view/aes/aes_cipher.dart';

void main() {
  const AesCipherService service = AesCipherService();

  for (final AesCipherMode mode in AesCipherMode.values) {
    test('${mode.label} 可以完成 UTF-8 数据加解密往返', () async {
      const AesKeySize keySize = AesKeySize.bits256;
      final String key = await service.generateKey(mode, keySize);
      final String nonce = service.generateNonce(mode, keySize);
      final AesCipherRequest encryptRequest = AesCipherRequest(
        mode: mode,
        keySize: keySize,
        key: key,
        nonce: nonce,
        input: 'FlutterUnit · AES 加解密',
      );

      final String encrypted = await service.encrypt(encryptRequest);
      final String decrypted = await service.decrypt(
        AesCipherRequest(
          mode: mode,
          keySize: keySize,
          key: key,
          nonce: nonce,
          input: encrypted,
        ),
      );

      expect(decrypted, 'FlutterUnit · AES 加解密');
    });
  }

  test('密钥长度不匹配时拒绝加密', () async {
    final String nonce = service.generateNonce(
      AesCipherMode.gcm,
      AesKeySize.bits256,
    );
    final AesCipherRequest request = AesCipherRequest(
      mode: AesCipherMode.gcm,
      keySize: AesKeySize.bits256,
      key: 'aW52YWxpZA==',
      nonce: nonce,
      input: 'invalid key',
    );

    await expectLater(service.encrypt(request), throwsFormatException);
  });
}
