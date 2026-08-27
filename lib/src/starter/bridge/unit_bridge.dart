import 'package:fx_dio/fx_dio.dart';
import 'package:note/note.dart';
import 'package:app/app.dart';

class UnitNoteBridge with NoteModuleBridge {
  @override
  RequestHost<HostEnv> get host => FxDio()<FlutterUnitHost>();
}
