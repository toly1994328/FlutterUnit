import 'package:flutter/material.dart';
import 'package:fx_dio/fx_dio.dart';
import 'package:note/note.dart';
import 'package:toly_ui/toly_ui.dart';

/// 将文章封面资源转换为当前宿主可访问地址。
typedef NewsCoverResolver = String Function(String source, int width);

class NewsPage extends StatefulWidget {
  /// 页面标题。
  final String title;

  /// 宿主提供的封面地址解析器。
  final NewsCoverResolver coverResolver;

  const NewsPage({
    super.key,
    required this.title,
    required this.coverResolver,
  });

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  /// 当前展示的文章列表。
  List<ArticlePo> data = [];

  /// 文章数据仓库。
  final ArticleRepository _repository = HttpArticleRepository();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 4),
          itemExtent: 76,
          itemCount: data.length,
          itemBuilder: _buildNewsItem,
        ));
  }

  /// 构建文章列表项，并按设备像素密度请求封面变体。
  Widget _buildNewsItem(BuildContext context, int index) {
    const double coverExtent = 68;
    final ArticlePo article = data[index];
    final int imageWidth =
        (coverExtent * MediaQuery.devicePixelRatioOf(context))
            .ceil()
            .clamp(1, 4096)
            .toInt();
    final String originalCover = article.cover?.trim() ?? '';
    final String resolvedCover = originalCover.isEmpty
        ? ''
        : widget.coverResolver(originalCover, imageWidth);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: ImageRender(
                source: resolvedCover,
                width: coverExtent,
                height: coverExtent,
                fit: BoxFit.cover,
                cacheWidth: imageWidth,
                cacheHeight: imageWidth,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0,
                    ),
                  ),
                  Text(
                    article.subtitle ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _loadData() async {
    ApiRet<List<ArticlePo>> ret = await _repository.getArticlesByTag(1,
        filter: const SizeFilter(
          page: 1,
          pageSize: 40,
        ));
    if (ret.success) {
      data = ret.data;
      setState(() {});
    }
  }
}
