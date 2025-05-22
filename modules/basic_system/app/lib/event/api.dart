import 'package:app/app.dart';
import 'package:fx_dio/fx_dio.dart';

void sendEvent(int id, {String? extra}) async {
  Host host = FxDio()<ScienceHost>();
  ApiRet<bool> ret = await host.post<bool>(
    '/event',
    data: {"event": id},
    convertor: (data) => data,
  );
  print(ret.toString());
}
