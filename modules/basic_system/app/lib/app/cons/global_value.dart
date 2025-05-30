import 'dart:io';
import 'dart:ui';
import 'package:storage/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

double px1 = 1 / window.devicePixelRatio;

String get kAppVersion => "3.2.0";

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
  String version = kAppVersion;
  String appId = '1';
  kAppMeta = AppMeta(version, appId, uuid);
}
