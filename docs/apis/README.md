# FlutterUnit 接口总览

本文档基于当前客户端代码静态梳理，记录应用实际声明或调用的 HTTP 接口。接口按业务模块拆分；本地数据库、页面外链、静态图片以及下载地址本身不计入业务 API。

## 模块索引

| 模块 | 文档 | 接口数 | 主要 Host |
| --- | --- | ---: | --- |
| 网络基础设施 | [infrastructure.md](infrastructure.md) | - | 三套 Host 与鉴权/响应约定 |
| 认证与账户 | [authentication.md](authentication.md) | 3 | Legacy API |
| 升级与事件 | [upgrade-and-events.md](upgrade-and-events.md) | 2 | ScienceHost |
| FlutterUnit 仓库与知识点 | [points.md](points.md) | 3 | UnitHost |
| 分类与收藏同步 | [category-sync.md](category-sync.md) | 2 | Legacy API |
| 文章与笔记 | [articles.md](articles.md) | 8 | ScienceHost |
| 插件包、分类、评论与反馈 | [packages.md](packages.md) | 11 | Unit3Host |

当前共整理 **29 个 HTTP 端点**。

## 阅读约定

- `{name}` 表示路径参数。
- Query、Body 只列客户端实际发送的字段；是否必填依据调用签名和默认值判断。
- 响应结构优先依据客户端转换代码描述。代码只透传 `dynamic` 时，会明确写为“未建模”。
- `ScienceHost` 会把服务端标准响应 `{status, msg, data}` 解包为 `data`；相应文档中的“响应”通常指解包后的数据。
- 标记为“遗留”的接口仍存在调用代码，但使用旧 `HttpUtil` 网络栈。

## 需要关注的现状

1. `UnitHost` 当前固定选择 `dev` 环境，实际请求指向 `http://127.0.0.1:8080/api/v1`，而不是配置中的发布域名。
2. `ScienceHost` 和 `Unit3Host` 的发布地址相同，但鉴权头和响应处理不同，不应混用。
3. 旧 `HttpUtil` 只在启动时设置 `http://82.157.176.209:8080/api/v1`，用于认证和分类同步。
4. 分类同步接口在 `artifact` 与 `widget_module` 中存在一份同名重复实现；当前界面主要使用 `widget_module` 版本。
5. 文章更新 Payload 的 `url`、`subtitle`、`cover` 当前都错误地写入了 `title` 值，详见文章模块文档。

## 扫描范围

主要接口来源：

- `modules/basic_system/app/lib/http`
- `modules/basic_system/authentication/lib`
- `modules/basic_system/unit_env/lib`
- `modules/knowledge_system/artifact/lib/src/points`
- `modules/knowledge_system/note/lib/src/repository`
- `modules/widget_system/widget_module/lib/views/mobile/category_page/sync`
- `modules/tools_system/pkg_player/lib/src/repository/api`

