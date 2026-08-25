# 分类与收藏同步接口

基础地址：Legacy API，`http://82.157.176.209:8080/api/v1`。

请求在登录后会附带 `Authorization: Bearer {token}`。

## 1. 上传分类与收藏数据

`POST /categoryData/sync`

Body：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `data` | string | 是 | 序列化后的分类数据 |
| `likeData` | string | 是 | 序列化后的收藏数据 |

客户端读取顶层 `status` 作为布尔结果。

## 2. 获取分类与收藏数据

`GET /categoryData`

客户端预期响应：

```json
{
  "status": true,
  "data": {
    "categoryDataId": 1,
    "userId": 1,
    "data": "...",
    "likeData": "..."
  }
}
```

当 `status == true` 且 `data == null` 时，客户端视为成功但无云端数据。

## 重复实现

以下两个文件包含几乎相同的 `CategoryApi` 与 `CategoryData`：

- `modules/widget_system/widget_module/lib/views/mobile/category_page/sync/category_api.dart`
- `modules/knowledge_system/artifact/lib/src/points/data/api/category_api.dart`

当前同步页面使用 `widget_module` 版本；`artifact` 版本仍保留在代码库中。

## 未计入总数的遗留接口

`AppInfoApi` 仍声明并实现：

`GET /appInfo/name/{appName}`

响应字段为 `appName`、`appVersion`、`appUrl`、`appSize`。当前未找到实际调用点，版本升级流程已经使用 ScienceHost 的 `/app_version`，因此该端点未计入“当前实际使用”的 29 个接口。

