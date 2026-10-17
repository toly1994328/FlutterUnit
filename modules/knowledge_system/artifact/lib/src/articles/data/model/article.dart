/// 服务端文章目录模型，仅保留运行时数据。
class Article {
  /// 服务端主键以字符串传输，避免 Web 端丢失 BIGINT 精度。
  final String id;

  /// 0 为外链，2 为本站 Markdown。
  final int type;

  /// 作者名称。
  final String username;

  /// 文章标题。
  final String title;

  /// 文章摘要。
  final String subtitle;

  /// 可直接打开的完整文章地址。
  final String url;

  /// 封面地址。
  final String cover;

  /// 创建时间，毫秒时间戳。
  final int create;

  /// 更新时间，毫秒时间戳。
  final int update;

  /// 原始创作时间，未知时为空，不能用入库日期替代。
  final DateTime? authoredAt;

  /// 文章主题，供列表、详情与筛选使用。
  final List<ArticleTopic> tags;

  const Article({
    required this.id,
    required this.title,
    required this.url,
    this.type = 0,
    this.username = '',
    this.subtitle = '',
    this.cover = '',
    this.create = 0,
    this.update = 0,
    this.authoredAt,
    this.tags = const <ArticleTopic>[],
  });

  factory Article.fromApi(dynamic data) => Article(
        id: data['id'] as String,
        type: (data['article_type'] as int?) ?? 0,
        title: data['title'] as String,
        url: data['source_url'] as String,
        username: data['author_name'] as String,
        subtitle: data['subtitle'] as String,
        cover: data['cover_url'] as String,
        create:
            DateTime.parse(data['created_at'] as String).millisecondsSinceEpoch,
        update:
            DateTime.parse(data['updated_at'] as String).millisecondsSinceEpoch,
        authoredAt: DateTime.tryParse(data['authored_at'] as String? ?? ''),
        tags: ((data['tags'] as List<dynamic>?) ?? <dynamic>[])
            .map(ArticleTopic.fromApi)
            .toList(),
      );
}

class ArticleFilter {
  /// 仅查询指定专栏；空值查询全部文章。
  final String? groupId;

  /// 每次请求的条数，服务端最多返回 100 条。
  final int pageSize;

  /// 标题或摘要的检索文本。
  final String query;

  /// 多个主题同时匹配，保留字符串主键精度。
  final List<String> tagIds;

  /// recent 为最新创作，oldest 为最早创作。
  final String sort;
  const ArticleFilter(
      {this.groupId,
      this.pageSize = 20,
      this.query = '',
      this.tagIds = const <String>[],
      this.sort = 'recent'});
}

class ArticleTopic {
  /// 主题主键。
  final String id;

  /// 可读的主题名称。
  final String name;

  /// 标签分类，文章详情的简写标签中为空。
  final String group;

  /// 当前文库或专栏中的可见文章数。
  final int count;
  const ArticleTopic(
      {required this.id, required this.name, this.group = '', this.count = 0});
  factory ArticleTopic.fromApi(dynamic data) => ArticleTopic(
      id: data['id'] as String,
      name: data['name'] as String,
      group: data['group_name'] as String? ?? '',
      count: data['article_count'] as int? ?? 0);
}

class ArticlePage {
  /// 本次请求返回的文章。
  final List<Article> items;

  /// 当前筛选条件下的可见文章总数。
  final int total;

  /// 下一页游标；空值表示没有更多文章。
  final String? nextCursor;
  const ArticlePage(
      {required this.items, required this.total, this.nextCursor});

  factory ArticlePage.fromApi(dynamic data) => ArticlePage(
        items: (data['items'] as List<dynamic>).map(Article.fromApi).toList(),
        total: data['total'] as int,
        nextCursor: data['next_cursor'] as String?,
      );
}
