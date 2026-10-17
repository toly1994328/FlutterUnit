import 'package:fx_dio/fx_dio.dart';
import 'package:artifact/artifact.dart';
import 'package:note/note.dart';
import 'package:app/app.dart';

class UnitNoteBridge with NoteModuleBridge {
  @override
  RequestHost<HostEnv> get host => FxDio()<FlutterUnitHost>();
}

/// 文章目录使用与应用相同的测试或线上 HTTP 主机。
class UnitArtifactBridge with ArtifactModuleBridge {
  @override
  RequestHost<HostEnv> get host => FxDio()<FlutterUnitHost>();

  @override
  String resolveResource(String location) =>
      FlutterUnitHost.resolveResource(location).toString();
}
