import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';
import 'package:utils/utils.dart';

import 'avatar_crop_page.dart';

/// 在多个用户页面间复用的头像选择、裁剪与上传流程。
abstract final class AvatarUpdateFlow {
  /// 允许上传的头像文件扩展名。
  static const Set<String> _allowedExtensions = {
    'jpg',
    'jpeg',
    'png',
    'heic',
    'heif',
  };

  /// 完成一次头像选择、裁剪和上传，用户取消或失败时返回 false。
  static Future<bool> start(BuildContext context) async {
    try {
      final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
        withData: true,
      );
      if (result == null || result.files.isEmpty) return false;
      final PlatformFile file = result.files.single;
      debugPrint('选中图片路径: ${file.path ?? '浏览器未提供本地路径'}');
      final String extension = file.extension?.toLowerCase() ?? '';
      if (!_allowedExtensions.contains(extension)) {
        if (context.mounted) {
          Toast.warning(context, context.l10n.unsupportedAvatarFormat);
        }
        return false;
      }
      final Uint8List? sourceBytes = file.bytes;
      if (sourceBytes == null || sourceBytes.isEmpty || !context.mounted) {
        return false;
      }
      final Uint8List? croppedBytes = await AvatarCropPage.open(
        context,
        imageBytes: sourceBytes,
      );
      if (croppedBytes == null || croppedBytes.isEmpty || !context.mounted) {
        return false;
      }
      await context.read<FxUserSessionCubit>().updateAvatar(croppedBytes);
      if (context.mounted) Toast.success(context, context.l10n.avatarUpdated);
      return true;
    } catch (_) {
      if (context.mounted) {
        Toast.error(context, context.l10n.avatarUploadFailed);
      }
      return false;
    }
  }
}
