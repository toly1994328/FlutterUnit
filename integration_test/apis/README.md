# API 集成测试

该目录依据 `docs/apis` 验证 FlutterUnit 当前依赖的 HTTP 契约，用于系统服务迁移期间比较新旧服务。

## 覆盖范围

| 文件 | 模块 | 端点数 |
| --- | --- | ---: |
| `authentication_test.dart` | 认证与账户 | 3 |
| `upgrade_events_test.dart` | 升级与事件 | 2 |
| `points_test.dart` | 仓库与知识点 | 3 |
| `category_sync_test.dart` | 分类与收藏同步 | 2 |
| `articles_test.dart` | 文章与笔记 | 8 |
| `packages_test.dart` | 插件包、分类、评论与反馈 | 11 |

共覆盖 29 个端点。

## 运行只读测试

建议使用项目 README 对应的 Flutter 版本。测试默认不会执行写入、删除、发送邮件、评论或事件上报。

```shell
flutter test -d macos integration_test/apis \
  --dart-define=SCIENCE_BASE_URL=https://new.example.com/api/v1 \
  --dart-define=UNIT3_BASE_URL=https://new.example.com/api/v1 \
  --dart-define=UNIT_BASE_URL=https://new.example.com/api/v1 \
  --dart-define=LEGACY_BASE_URL=https://new.example.com/api/v1 \
  --dart-define=API_TEST_APP_VERSION=3.4.1 \
  --dart-define=API_TEST_PLATFORM=ios \
  --dart-define=API_TEST_POINT_ID=1 \
  --dart-define=API_TEST_ARTICLE_ID=1 \
  --dart-define=API_TEST_ARTICLE_TAG_ID=1 \
  --dart-define=API_TEST_PACKAGE_ID=1 \
  --dart-define=API_TEST_COMMENT_ID=1 \
  --dart-define=API_TEST_CATEGORY_KEY=recommend
```

没有提供资源 ID 的用例会显示为跳过，不会导致整组失败。

## 运行认证测试

敏感信息只通过命令行或 CI Secret 注入，不要写入仓库：

```shell
flutter test -d macos integration_test/apis/authentication_test.dart \
  --dart-define=LEGACY_BASE_URL=https://new.example.com/api/v1 \
  --dart-define=API_TEST_USERNAME=reviewer \
  --dart-define=API_TEST_PASSWORD=secret
```

云同步查询还需要：

```shell
--dart-define=API_TEST_TOKEN=jwt-token
```

## 运行写入测试

仅对隔离的测试环境执行。部分接口会创建、修改或删除数据，也可能发送邮件、评论和反馈：

```shell
flutter test -d macos integration_test/apis \
  --dart-define=RUN_WRITE_API_TESTS=true \
  --dart-define=SCIENCE_BASE_URL=https://staging.example.com/api/v1 \
  --dart-define=UNIT3_BASE_URL=https://staging.example.com/api/v1 \
  --dart-define=LEGACY_BASE_URL=https://staging.example.com/api/v1 \
  --dart-define=API_TEST_USERNAME=integration_test \
  --dart-define=API_TEST_PASSWORD=secret \
  --dart-define=API_TEST_TOKEN=jwt-token \
  --dart-define=API_TEST_EMAIL=integration-test@example.com \
  --dart-define=API_TEST_ACTIVE_CODE=123456 \
  --dart-define=API_TEST_ARTICLE_ID=1 \
  --dart-define=API_TEST_PACKAGE_ID=1 \
  --dart-define=API_TEST_PACKAGE_NAME=flutter_unit_integration_test \
  --dart-define=API_TEST_CATEGORY_KEY=integration_test
```

## 迁移验收建议

1. 使用相同测试数据分别运行旧服务和新服务。
2. 保留两次机器可读测试输出，在 CI 中比较失败项。
3. 新服务应保持路径、方法、字段类型、分页字段和响应外壳一致。
4. 写入测试应使用独立数据库，并在运行后清理测试数据。
