/// 服务端专栏元数据，不承担本地持久化。
class Columnize {
  /// 服务端专栏主键。
  final String id;

  /// 作者名称。
  final String username;

  /// 专栏标题。
  final String title;

  /// 专栏简介。
  final String subtitle;

  /// 来源链接；未提供时为空。
  final String url;

  /// 封面地址。
  final String cover;

  /// 创建时间，毫秒时间戳。
  final int create;

  /// 更新时间，毫秒时间戳。
  final int update;

  /// 服务端统计的可见文章数量。
  final int count;

  const Columnize({
    required this.id,
    required this.title,
    this.username = '',
    this.subtitle = '',
    this.url = '',
    this.cover = '',
    this.create = 0,
    this.update = 0,
    this.count = 0,
  });

  factory Columnize.fromApi(dynamic data) => Columnize(
        id: data['id'] as String,
        title: data['title'] as String,
        username: data['author_name'] as String,
        subtitle: data['subtitle'] as String,
        url: data['source_url'] as String,
        cover: data['cover_url'] as String,
        count: data['article_count'] as int,
        create:
            DateTime.parse(data['created_at'] as String).millisecondsSinceEpoch,
        update:
            DateTime.parse(data['updated_at'] as String).millisecondsSinceEpoch,
      );
}
