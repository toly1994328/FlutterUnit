import 'dart:io';
import 'dart:ui';
import 'package:storage/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:package_info_plus/package_info_plus.dart';

double px1 = 1 / window.devicePixelRatio;

bool kIsDesk =
    kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux;

late AppMeta kAppMeta;

class AppMeta {
  final String appVersion;
  final String appId;
  final String uuid;

  String get platform => Platform.operatingSystem;

  AppMeta(this.appVersion, this.appId, this.uuid);

  Map<String, dynamic> toHeaderJson() => {
        'X-App-Version': appVersion,
        'X-App-Id': appId,
        'X-Platform': platform,
        'X-Uuid': uuid,
      };
}

Future<void> initAppMeta() async {
  String? uuid = SpStorage().spf.getString('uuid');
  if (uuid == null) {
    uuid = const Uuid().v4();
    SpStorage().spf.setString('uuid', uuid);
  }
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  String appId = '1';
  kAppMeta = AppMeta(version, appId, uuid);
}
