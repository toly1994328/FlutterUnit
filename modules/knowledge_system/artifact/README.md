# FlutterUnit 文库模块

文库仅从应用注入的在线服务读取目录、专栏、主题和 Markdown，不使用 `article.db`。

- 首页顶部搜索与筛选，下方横向滑动专栏及文章列表；提供全部专栏入口，窄屏单列文章，宽屏双列文章及专栏箭头切换。
- 标题与摘要搜索支持输入防抖，多主题筛选采用并集，接口显式传递 `tag_match=any`，匹配任一所选主题即展示。卡片标题置顶，封面与简介并排，主题标签最多两行，作者与创作时间位于右下角；阅读页展示完整主题。
- 按原始创作时间正序或倒序分页；未知日期置后，不以入库时间替代。
- 文章卡片封面根据显示尺寸和屏幕倍率添加 `w/h`，按 64 物理像素分档；文档服务按原格式生成并缓存方形缩略图，CraftOSS 封面保留原编码。动图和其他外站图片沿用原链接。
- 专栏详情复用检索、筛选和分页，每个页面独立管理状态，旧响应不会覆盖新条件。
- 阅读页支持字号、文本选择、阅读进度、回到顶部和图片缩放。图片按完整文档目录解析。

在 FlutterUnit 根目录验证：

```powershell
flutter test modules/knowledge_system/artifact/test
flutter run -d web-server --web-port=9604 -t tool/article_library_preview.dart --dart-define-from-file=../.fx/.env/.client.dev --dart-define=SERVER_HOST=127.0.0.1
```

预览入口使用相同的文库组件、应用主题和真实测试接口，省略完整应用的启动数据库与导航。
