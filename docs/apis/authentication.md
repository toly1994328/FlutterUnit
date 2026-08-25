# 认证与账户接口

基础地址：Legacy API，`http://82.157.176.209:8080/api/v1`。

## 接口清单

### 1. 用户名密码登录

`POST /login`

Body：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `username` | string | 是 | 用户名 |
| `password` | string | 是 | 密码 |

客户端预期响应：

```json
{
  "status": true,
  "msg": "JWT token 或提示信息",
  "data": {
    "username": "...",
    "userAvatar": "...",
    "email": "...",
    "roles": "...",
    "userId": 1
  }
}
```

登录成功后，客户端把 `msg` 当作 JWT 保存，并为后续 Legacy 请求添加 Bearer Token。

### 2. 邮箱注册

`POST /register`

Body：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `email` | string | 是 | 邮箱地址 |
| `activeCode` | string | 是 | 邮箱验证码 |

响应未做结构化解析，客户端将整个响应体作为 `TaskResult<bool>.data` 返回；该声明与实际动态响应存在类型不一致风险。

### 3. 发送邮箱验证码

`POST /sendEmail/{email}`

| 参数 | 位置 | 类型 | 必填 |
| --- | --- | --- | --- |
| `email` | Path | string | 是 |

客户端检查顶层 `status`；成功时透传整个响应体，失败时读取 `msg`。

## 调用位置

- `HttpAuthRepository`
- `AuthBloc`

## 注意事项

- 登录接口依赖 `msg` 承载 Token，这不是常见的响应字段语义。
- 退出登录只删除持久化 Token，当前代码没有调用 `HttpUtil.deleteToken()` 移除已安装的请求拦截器。

