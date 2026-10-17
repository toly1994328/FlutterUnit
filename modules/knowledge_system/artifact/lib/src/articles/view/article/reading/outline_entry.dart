/// 正文目录项；块索引对应实际渲染列表，不依赖估算像素高度。
class OutlineEntry {
  /// 本次文档解析中的唯一序号，重复标题也各自独立。
  final int id;

  /// Markdown 标题层级。
  final int level;

  /// 去除行内标记后的可读标题。
  final String title;

  /// 文内链接使用的片段标识。
  final String fragment;

  /// 标题在正文惰性列表中的位置。
  int blockIndex = 0;

  OutlineEntry(
      {required this.id,
      required this.level,
      required this.title,
      required this.fragment});
}

/// 中英文标题保留字母、数字和连字符，去除展示标点。
String outlineFragment(String title) => title
    .trim()
    .toLowerCase()
    .replaceAll(RegExp(r'[^\p{L}\p{N}\s_-]', unicode: true), '')
    .replaceAll(RegExp(r'\s+'), '-');
