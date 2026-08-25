# 升级与事件接口

基础地址：ScienceHost，`http://toly1994.com:3000/api/v1`。

## 1. 查询应用版本

`GET /app_version`

Query：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `app_id` | int | 是 | 当前实现固定发送 `1` |
| `os` | string | 是 | 当前应用环境的操作系统名称 |
| `locale` | string | 是 | 调用方传入的语言标识 |

解包后的响应：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `version` | string | 最新版本号 |
| `url` | string | 安装包下载地址 |
| `size` | int | 文件大小 |
| `description` | string? | 版本说明 |
| `sha256` | string? | 文件校验值 |

实现：`UnitUpgradeApi.fetch(int appId, String locale)`。注意传入的 `appId` 参数当前未使用，实际始终发送 `1`。

## 2. 上报事件

`POST /event`

Body：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `event` | int | 是 | 事件编号 |

解包后的响应类型为 `bool`。

该接口仅在非 Debug 模式发送。`sendEvent` 虽然接收可选参数 `extra`，当前请求 Body 并未发送它。

