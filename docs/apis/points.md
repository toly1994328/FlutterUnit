# FlutterUnit 仓库与知识点接口

Host：`UnitHost`。

当前运行地址为 `http://127.0.0.1:8080/api/v1`；配置中另有发布地址 `http://api.toly1994.com:8080/api/v1`，但当前环境选择不会使用它。

## 1. 获取 FlutterUnit 仓库信息

`GET /repository/name/FlutterUnit`

客户端从 `data.repositoryData` 读取 JSON 字符串，再解析为仓库模型。主要字段由 `Repository.fromJson` 决定。

## 2. 获取知识点 Issue 列表

`GET /point`

Query：

| 字段 | 类型 | 默认值 | 说明 |
| --- | --- | ---: | --- |
| `page` | int | 1 | 页码 |
| `pageSize` | int | 100 | 每页数量；注意为驼峰命名 |

客户端读取顶层 `data` 数组，并将每项的 `pointData` JSON 字符串解析为 `Issue`。

## 3. 获取知识点评论

`GET /pointComment/{pointId}`

| 参数 | 位置 | 类型 | 必填 |
| --- | --- | --- | --- |
| `pointId` | Path | int | 是 |

客户端读取顶层 `data` 数组，并将每项的 `pointCommentData` JSON 字符串解析为 `IssueComment`。

## 备注

`UnitApi` 还声明了 `GET /hello` 与 `GET /appInfo/name/{name}` 的路径常量，但当前未发现通过 `UnitHost` 调用它们，因此没有计入接口总数。旧版 `/appInfo/name/{name}` 调用见分类同步文档的遗留接口说明。

