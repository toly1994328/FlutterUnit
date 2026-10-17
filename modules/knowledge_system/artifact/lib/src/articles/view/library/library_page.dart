import 'package:flutter/material.dart';
import 'article_browser.dart';

/// 文库保留顶部横向专栏和下方文章的原有结构。
class ArticleLibraryPage extends StatelessWidget {
  const ArticleLibraryPage({super.key});
  @override
  Widget build(BuildContext context) =>
      const ArticleBrowser(showCollections: true);
}
