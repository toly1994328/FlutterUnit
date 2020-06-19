import 'package:dio/dio.dart';
import '../code.dart';
import '../rep_result.dart';

/// create by 张风捷特烈 on 2020/4/28
/// contact me by email 1981462002@qq.com
/// 说明:
///
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  onResponse(Response response) async {
    RequestOptions option = response.request;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if ((header != null && header.toString().contains("text"))) {
        value = new RepResult(response.data, true, Code.SUCCESS);
      } else if (response.statusCode >= 200 && response.statusCode < 300) {
        value = new RepResult(response.data, true, Code.SUCCESS,);
      }
    } catch (e) {
      print(e.toString() + option.path);
      value = new RepResult(response.data, false, response.statusCode,msg: e.toString());
    }
    return value;
  }
}
