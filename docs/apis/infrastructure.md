# 网络基础设施

## Host 配置

| 标识 | 当前环境 | 基础地址 | 使用模块 |
| --- | --- | --- | --- |
| `ScienceHost` | `release` | `http://toly1994.com:3000/api/v1` | 升级、事件、文章 |
| `Unit3Host` | `release` | `http://toly1994.com:3000/api/v1` | 插件包、分类、评论、反馈 |
| `UnitHost` | `dev` | `http://127.0.0.1:8080/api/v1` | FlutterUnit 仓库与知识点 |
| Legacy `HttpUtil` | 启动时 `rebase` | `http://82.157.176.209:8080/api/v1` | 认证、分类同步、旧版应用信息 |

`UnitHost` 也声明了发布域名 `api.toly1994.com`，但当前 `env` 返回 `HostEnv.dev`，所以运行时不会使用发布域名。

## 请求头

### ScienceHost

所有请求通过 `ScienceAuth` 添加：

| Header | 来源 |
| --- | --- |
| `X-App-Version` | 当前应用版本 |
| `X-App-Id` | 固定为 `1` |
| `X-Platform` | `Platform.operatingSystem` |
| `X-Uuid` | 首次启动生成并持久化的 UUID |

### Unit3Host

所有请求通过 `UnitApiAuth` 添加：

| Header | 值 |
| --- | --- |
| `locale` | 中文为 `zh-CN`，其他语言为 `en` |

语言切换后会重新注册该鉴权配置。

### Legacy HttpUtil

登录成功或恢复登录态后，通过拦截器添加：

```http
Authorization: Bearer {token}
```

Token 会先检查 JWT 是否过期，但即使过期，请求拦截器本身仍会继续附加该 Token。

## 响应约定

### ScienceHost

`ScienceRepInterceptor` 预期 HTTP 200 响应为：

```json
{
  "status": true,
  "msg": "success",
  "data": {}
}
```

- `status == true`：将响应体替换为 `data`，并把 `msg` 写入状态消息。
- `status != true`：抛出 `ApiTrace`。
- 非 HTTP 200：同样抛出 `ApiTrace`。

### Unit3Host、UnitHost

未注册 `ScienceRepInterceptor`。各调用点根据自身转换函数读取响应，有些接口读取顶层 `data`，有些直接透传。

### Legacy HttpUtil

认证与分类同步通常自行检查：

```json
{
  "status": true,
  "msg": "...",
  "data": {}
}
```

## 超时

Legacy `HttpUtil` 的连接、发送、接收超时均为 5 秒。`fx_dio` Host 的超时值未在本项目代码中显式配置。

