/// 阅读展示层去除重复的导出抬头；原 Markdown 文件保持完整。
String readingBody(String body, String title) {
  final RegExp heading = RegExp(r'^(?:[ \t]*\r?\n)*# ([^\r\n]+)(?:\r?\n)+');
  final RegExpMatch? match = heading.firstMatch(body);
  if (match == null || match.group(1)!.trim() != title.trim()) return body;
  final String withoutTitle = body.substring(match.end);
  // 只识别导出器在同名首标题后添加的固定元信息，不移除普通引用内容。
  final RegExp metadata = RegExp(
      r'^> 作者：[^\r\n]*\r?\n> 创建时间：[^\r\n]*\r?\n> 原文：[^\r\n]*(?:\r?\n|$)');
  return withoutTitle
      .replaceFirst(metadata, '')
      .replaceFirst(RegExp(r'^(?:[ \t]*\r?\n)+'), '');
}
