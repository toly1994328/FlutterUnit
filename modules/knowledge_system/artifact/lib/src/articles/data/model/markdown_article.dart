/// 本站正文独立于目录数据，打开文章时从服务端读取。
class MarkdownArticle {
  /// 文章标题。
  final String title;

  /// Markdown 正文。
  final String content;

  /// 保留的原文地址。
  final String sourceUrl;

  /// 本站文档目录的图片基准地址；旧文章继续使用原文地址。
  final String? resourceBaseUrl;

  /// 保留原始文件内容，阅读时隐藏 YAML 元数据头部。
  String get markdownBody => content.replaceFirst(
        RegExp(
            r'^\uFEFF?---\r?\n(?:[ \t]*(?:#[^\r\n]*)?\r?\n)*[ \t]*[A-Za-z_][\w-]*[ \t]*:[\s\S]*?\r?\n(?:---|\.\.\.)(?:\r?\n|$)'),
        '',
      );

  const MarkdownArticle(
      {required this.title,
      required this.content,
      required this.sourceUrl,
      this.resourceBaseUrl});

  factory MarkdownArticle.fromApi(dynamic data) => MarkdownArticle(
        title: data['title'] as String,
        content: data['content'] as String,
        sourceUrl: data['source_url'] as String,
        resourceBaseUrl: data['resource_base_url'] as String?,
      );
}
