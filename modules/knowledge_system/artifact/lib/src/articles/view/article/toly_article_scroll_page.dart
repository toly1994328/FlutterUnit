import 'package:flutter/material.dart';
import '../library/library_page.dart';

/// 移动端与桌面端共用文库检索和专栏浏览，布局按可用宽度调整。
class TolyArticleScrollPage extends StatelessWidget {
  const TolyArticleScrollPage({super.key});
  @override
  Widget build(BuildContext context) => const ArticleLibraryPage();
}
