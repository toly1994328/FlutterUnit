// import 'package:dio/dio.dart';
// import 'task_result.dart';
//
// // 拦截返回数据，进行统一处理
// class ResponseInterceptors<T> extends InterceptorsWrapper {
//   @override
//   onResponse(Response response) async {
//     RequestOptions option = response.request;
//
//     if (option.contentType != null && option.contentType.contains("text")) {
//       return ResultBean<T>(data: response.data, status: true, msg: '');
//     }
//
//     ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
//     if (response.statusCode == 200 || response.statusCode == 201) {
//       ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
//       bool status = response.data["status"];
//       String msg = response.data["msg"];
//       var result = response.data;
//       return ResultBean<T>(
//         data: result,
//         status: status,
//         msg: msg,
//       );
//     }
//   }
// }
