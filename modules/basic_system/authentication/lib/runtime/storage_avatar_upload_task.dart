import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:fx_user_core/fx_user_core.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:unit_env/unit_env.dart';
import 'package:uuid/uuid.dart';

/// 通过 FlutterUnit 统一存储服务上传用户头像。
final class FlutterUnitStorageAvatarUploadTask implements FxAvatarUploadTask {
  final FlutterUnitHost host;

  const FlutterUnitStorageAvatarUploadTask(this.host);

  @override
  Future<Uri> upload({
    required Uint8List bytes,
    required UserCredential credential,
  }) async {
    if (credential is! BearerCredential) {
      throw StateError('Avatar upload requires bearer authentication.');
    }
    final FormData form = FormData.fromMap(<String, Object>{
      'file': MultipartFile.fromBytes(bytes, filename: 'avatar.png'),
      'hash': sha256.convert(bytes).toString(),
      'upload_id': const Uuid().v4(),
    });
    final result = await host.post<Map<String, dynamic>>(
      '/storage/upload/image',
      data: form,
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer ${credential.accessToken}',
        },
      ),
    );
    if (!result.success) {
      throw StateError('Avatar upload request failed.');
    }
    final String? rawUrl = result.data['url']?.toString();
    if (rawUrl == null || rawUrl.isEmpty) {
      throw StateError('Avatar upload returned an empty URL.');
    }
    return FlutterUnitHost.resolveResource(rawUrl);
  }
}
