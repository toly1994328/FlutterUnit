import 'package:fx_dio/fx_dio.dart';

class NoteEnv with NoteModuleBridge {
  static NoteEnv? _instance;

  NoteEnv._();

  factory NoteEnv() {
    _instance ??= NoteEnv._();
    return _instance!;
  }

  NoteModuleBridge? _bridge;

  void attachBridge(NoteModuleBridge bridge) {
    _bridge = bridge;
  }

  @override
  RequestHost<HostEnv> get host => _bridge!.host;
}

mixin NoteModuleBridge {
  RequestHost<HostEnv> get host;
}
