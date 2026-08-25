import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// 接口集成测试使用的环境配置。
abstract final class ApiTestConfig {
  /// ScienceHost 服务地址。
  static const String scienceBaseUrl = String.fromEnvironment(
    'SCIENCE_BASE_URL',
    defaultValue: 'http://toly1994.com:3000/api/v1',
  );

  /// Unit3Host 服务地址。
  static const String unit3BaseUrl = String.fromEnvironment(
    'UNIT3_BASE_URL',
    defaultValue: 'http://toly1994.com:3000/api/v1',
  );

  /// UnitHost 服务地址。
  static const String unitBaseUrl = String.fromEnvironment(
    'UNIT_BASE_URL',
    defaultValue: 'http://127.0.0.1:8080/api/v1',
  );

  /// 遗留服务地址。
  static const String legacyBaseUrl = String.fromEnvironment(
    'LEGACY_BASE_URL',
    defaultValue: 'http://82.157.176.209:8080/api/v1',
  );

  /// 登录测试用户名。
  static const String username = String.fromEnvironment('API_TEST_USERNAME');

  /// 登录测试密码。
  static const String password = String.fromEnvironment('API_TEST_PASSWORD');

  /// 遗留服务鉴权 Token。
  static const String token = String.fromEnvironment('API_TEST_TOKEN');

  /// 邮箱测试地址。
  static const String email = String.fromEnvironment('API_TEST_EMAIL');

  /// 邮箱验证码。
  static const String activeCode = String.fromEnvironment(
    'API_TEST_ACTIVE_CODE',
  );

  /// 知识点 ID。
  static const int pointId = int.fromEnvironment('API_TEST_POINT_ID');

  /// 文章 ID。
  static const int articleId = int.fromEnvironment('API_TEST_ARTICLE_ID');

  /// 文章标签 ID。
  static const int articleTagId = int.fromEnvironment(
    'API_TEST_ARTICLE_TAG_ID',
  );

  /// 插件 ID。
  static const int packageId = int.fromEnvironment('API_TEST_PACKAGE_ID');

  /// 插件名称。
  static const String packageName = String.fromEnvironment(
    'API_TEST_PACKAGE_NAME',
  );

  /// 插件分类键。
  static const String categoryKey = String.fromEnvironment(
    'API_TEST_CATEGORY_KEY',
  );

  /// 评论 ID。
  static const int commentId = int.fromEnvironment('API_TEST_COMMENT_ID');

  /// 是否允许执行会改变服务端数据的测试。
  static const bool runWriteTests = bool.fromEnvironment(
    'RUN_WRITE_API_TESTS',
  );

  /// ScienceHost 请求使用的应用版本。
  static const String appVersion = String.fromEnvironment(
    'API_TEST_APP_VERSION',
    defaultValue: '3.4.1',
  );

  /// ScienceHost 请求使用的应用 ID。
  static const String appId = String.fromEnvironment(
    'API_TEST_APP_ID',
    defaultValue: '1',
  );

  /// ScienceHost 请求使用的平台名称。
  static const String platform = String.fromEnvironment(
    'API_TEST_PLATFORM',
    defaultValue: 'ios',
  );

  /// ScienceHost 的应用标识请求头。
  static const Map<String, Object> scienceHeaders = <String, Object>{
    'X-App-Version': appVersion,
    'X-App-Id': appId,
    'X-Platform': platform,
    'X-Uuid': 'flutter-unit-integration-test',
  };

  /// Unit3Host 的本地化请求头。
  static const Map<String, Object> unit3Headers = <String, Object>{
    'locale': 'zh-CN',
  };
}

/// 对真实 HTTP 服务执行契约验证的测试客户端。
final class ApiTestClient {
  /// 底层 Dio 客户端。
  final Dio dio;

  ApiTestClient({
    required String baseUrl,
    Map<String, Object>? headers,
  }) : dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: headers,
            connectTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            validateStatus: (int? status) => status != null,
          ),
        );

  /// 发送请求并验证 HTTP 状态码属于成功范围。
  Future<dynamic> request(
    String path, {
    String method = 'GET',
    Map<String, dynamic>? query,
    Object? data,
  }) async {
    Response<dynamic> response = await dio.request<dynamic>(
      path,
      data: data,
      queryParameters: query,
      options: Options(method: method),
    );
    int statusCode = response.statusCode ?? 0;
    expect(
      statusCode,
      inInclusiveRange(200, 299),
      reason: '$method $path 返回 $statusCode：${response.data}',
    );
    return response.data;
  }
}

/// 解包并验证 ScienceHost 的标准响应。
dynamic unwrapScienceResponse(dynamic body) {
  Map<String, dynamic> envelope = expectJsonMap(body);
  expect(envelope, containsPair('status', true));
  expect(envelope['msg'], anyOf(isNull, isA<String>()));
  expect(envelope, contains('data'));
  return envelope['data'];
}

/// 验证并返回 JSON 对象。
Map<String, dynamic> expectJsonMap(dynamic value) {
  expect(value, isA<Map<String, dynamic>>());
  return value as Map<String, dynamic>;
}

/// 验证并返回 JSON 数组。
List<dynamic> expectJsonList(dynamic value) {
  expect(value, isA<List<dynamic>>());
  return value as List<dynamic>;
}

/// 构造带 Bearer Token 的遗留服务请求头。
Map<String, Object> legacyHeaders() {
  if (ApiTestConfig.token.isEmpty) return <String, Object>{};
  return <String, Object>{
    'Authorization': 'Bearer ${ApiTestConfig.token}',
  };
}

/// 缺少必需字符串配置时返回跳过原因。
String? skipWithoutString(String name, String value) {
  return value.isEmpty ? '缺少 --dart-define=$name=...' : null;
}

/// 缺少必需整数配置时返回跳过原因。
String? skipWithoutPositiveInt(String name, int value) {
  return value <= 0 ? '缺少 --dart-define=$name=...' : null;
}

/// 写入测试未开启时返回跳过原因。
String? skipWriteTest([String? prerequisite]) {
  if (!ApiTestConfig.runWriteTests) {
    return '设置 --dart-define=RUN_WRITE_API_TESTS=true 后执行';
  }
  return prerequisite;
}
