import 'package:fx_user_http/fx_user_http.dart';
import 'package:unit_env/unit_env.dart';

/// 补齐当前用户 SDK 丢失的密码修改失败原因。
class FlutterUnitUserRepository extends HttpFxUserRepository {
  FlutterUnitUserRepository({required super.host});

  /// 失败时保留服务端公开错误，让表单能够提示旧密码错误等具体原因。
  @override
  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final ApiRet<void> result = await host.put<void>(
      '/user/password',
      data: <String, dynamic>{
        'old_password': oldPassword,
        'new_password': newPassword,
      },
      convertor: _decodeVoid,
    );
    if (result.success) return true;
    final Object? error = result.trace?.error;
    final Response<dynamic>? response =
        error is DioException ? error.response : null;
    final dynamic body = response?.data;
    throw RequestException(
      RequestErrorCode.exception,
      body is Map ? (body['message'] ?? body['msg'])?.toString() : null,
      null,
      null,
      response?.statusCode,
      body is Map ? body['code']?.toString() : null,
    );
  }

  static void _decodeVoid(dynamic data) {}
}
