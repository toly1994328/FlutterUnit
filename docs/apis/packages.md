# 插件包、分类、评论与反馈接口

基础地址：Unit3Host，`http://toly1994.com:3000/api/v1`。

所有请求携带 `locale: zh-CN|en`。该 Host 不使用 ScienceHost 的统一响应解包器，部分接口直接透传动态响应。

## 插件包

### 1. 获取全部插件包

`GET /packages`

无参数；响应未建模，客户端直接透传。

### 2. 导入插件包

`POST /packages/import`

Body 为调用方传入的完整插件 JSON，当前 API 层未限制字段；响应未建模。

### 3. 删除插件包

`DELETE /packages/{name}`

| 参数 | 位置 | 类型 | 必填 |
| --- | --- | --- | --- |
| `name` | Path | string | 是 |

响应未建模。

### 4. 将插件加入分类

`POST /packages/add_to_category`

Body：

| 字段 | 类型 | 必填 |
| --- | --- | --- |
| `category_key` | string | 是 |
| `package_names` | string[] | 是 |

响应未建模。

## 分类

### 5. 获取分类列表

`GET /categories`

| Query | 类型 | 当前值 |
| --- | --- | ---: |
| `page` | int | 1 |
| `page_size` | int | 100 |

客户端读取顶层 `data` 数组。分类字段为 `id`、`key`、`name`、`description`。

### 6. 新增分类

`POST /categories`

标准调用 Body：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `key` | string | 是 | 分类键 |
| `name` | string | 是 | 分类名称 |
| `description` | string | 是 | 未提供时发送空字符串 |

底层 `addCategoriesRaw` 也允许透传任意 Map；响应未建模。

### 7. 导出分类下的插件

`GET /categories/{key}/export`

| 参数 | 位置 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `key` | Path | string | 必填 |
| `sort_by` | Query | string | `downloads` |
| `page` | Query | int | 1 |
| `page_size` | Query | int | 10 |

客户端读取顶层 `data` 数组并解析为插件模型。主要字段：`id`、`name`、`last_version`、`last_publish`、`statistics`、`tags`、`desc`、`publisher`、`repository`、`homepage`、`topics`、`dependencies`。

## 评论

### 8. 获取插件评论

`GET /packages/{packageId}/comments`

| 参数 | 位置 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `packageId` | Path | int | 必填 |
| `page` | Query | int | 1 |
| `page_size` | Query | int | 10 |

响应：

```json
{
  "data": [
    {
      "id": 1,
      "package_id": 1,
      "parent_id": null,
      "user_id": null,
      "guest_name": "游客",
      "content": "...",
      "content_type": "...",
      "rating": null,
      "create_at": "...",
      "replies": [],
      "replies_total": 0
    }
  ],
  "total": 1
}
```

### 9. 发表评论或回复

`POST /packages/{packageId}/comments`

Body：

| 字段 | 类型 | 必填 | 说明 |
| --- | --- | --- | --- |
| `content` | string | 是 | 评论内容 |
| `guest_name` | string | 是 | 游客名称 |
| `parent_id` | int | 否 | 回复目标；`null` 或 `-1` 时不发送 |

响应未建模。

### 10. 获取评论回复

`GET /comments/{commentId}/replies`

| 参数 | 位置 | 类型 | 默认值 |
| --- | --- | --- | --- |
| `commentId` | Path | int | 必填 |
| `page` | Query | int | 1 |
| `page_size` | Query | int | 15 |

客户端读取顶层 `data` 数组并解析为评论模型。

## 反馈

### 11. 提交反馈

`POST /feedback`

Body：

| 字段 | 类型 | 必填 |
| --- | --- | --- |
| `feedback_type` | string | 是 |
| `title` | string | 是 |
| `content` | string | 是 |

响应未建模。

