# 文章与笔记接口

基础地址：ScienceHost，`http://toly1994.com:3000/api/v1`。

文章模块通过 `NoteEnv -> UnitNoteBridge -> ScienceHost` 接入网络层。所有响应先经过 ScienceHost 的标准响应解包。

## 接口清单

### 1. 创建文章

`POST /article`

Body：

| 字段 | 类型 | 必填 |
| --- | --- | --- |
| `title` | string | 是 |
| `create_at` | string | 是 |
| `subtitle` | string | 是 |
| `url` | string | 是 |
| `type` | int | 是 |
| `cover` | string | 是 |

客户端根据解包后对象的 `status == true` 返回布尔结果。由于 ScienceHost 已经先解包 `data`，这里要求 `data` 内仍存在 `status` 字段；需与服务端实际结构核对。

### 2. 删除文章

`DELETE /article/{id}`

| 参数 | 位置 | 类型 | 必填 |
| --- | --- | --- | --- |
| `id` | Path | int | 是 |

客户端同样读取解包后对象的 `status == true`。

### 3. 分页查询文章

`GET /article`

| Query | 类型 | 默认值 |
| --- | --- | ---: |
| `page` | int | 1 |
| `page_size` | int | 20 |

解包后响应为文章数组。文章字段包括 `article_id`、`title`、`type`、`status`、`create_at`、`update_at`、`subtitle`、`url`、`cover`。

### 4. 打开文章内容

`GET /article/open/{id}`

解包后响应直接作为字符串返回。

### 5. 写入文章内容

`POST /article/write`

Body：

| 字段 | 类型 | 必填 |
| --- | --- | --- |
| `article_id` | int | 是 |
| `content` | string | 是 |

解包后响应直接作为 `bool` 返回。

### 6. 更新文章元数据

`PUT /article/{id}`

Body 支持 `title`、`url`、`subtitle`、`cover`，均为可选字段；响应解析为文章模型。

当前客户端存在 Payload 映射错误：除 `title` 外，`url`、`subtitle`、`cover` 被赋值为 `title`，若只更新非标题字段还可能发送 `null`。这是客户端实现问题，不是接口协议要求。

### 7. 获取文章分类树

`GET /category`

客户端从解包后对象的 `data` 字段构造分类树：

| 字段 | 类型 | 说明 |
| --- | --- | --- |
| `cate_id` | int | 分类 ID |
| `name` | string | 名称 |
| `cate_type` | int | 类型，默认 0 |
| `priority` | int | 优先级，默认 0 |
| `children` | array | 子分类，递归结构 |

这里同样存在二次读取 `data` 的现象，需要与 ScienceHost 解包后的实际响应核对。

### 8. 按标签查询文章

`GET /article/tag`

| Query | 类型 | 默认值 |
| --- | --- | ---: |
| `tag_id` | int | 必填 |
| `page` | int | 1 |
| `page_size` | int | 20 |

解包后响应为文章数组。

