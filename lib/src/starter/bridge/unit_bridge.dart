import 'package:fx_dio/fx_dio.dart';
import 'package:fx_dio/src/client/host.dart';
import 'package:note/note.dart';
import 'package:app/app.dart';

class UnitNoteBridge with NoteModuleBridge{

  @override
  Host get host => FxDio()<ScienceHostPure>();
}