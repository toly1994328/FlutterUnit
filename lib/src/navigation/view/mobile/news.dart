import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note/note.dart';
import 'package:tolyui/basic/basic.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../l10n/gen/app_l10n.dart';
import 'carousel.dart';
import 'package:app/app.dart';

class NewsHeader extends StatefulWidget {
  const NewsHeader({super.key});

  @override
  State<NewsHeader> createState() => _NewsHeaderState();
}

class _NewsHeaderState extends State<NewsHeader> {
  @override
  Widget build(BuildContext context) {
    AppL10n l10n = AppL10n.of(context);

    List<ArticlePo> data =
        context.select((NewsBloc bloc) => bloc.state.headerNews);
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 64),
      child: Column(
        spacing: 2,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: Row(
              children: [
                Text(
                  l10n.news,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                if (kAppEnv.isDesktopUI)
                  TolyAction(
                      style: ActionStyle(padding: EdgeInsets.all(2)),
                      child: Icon(
                        Icons.refresh,
                        size: 16,
                      ),
                      onTap: () {
                        context.read<NewsBloc>().refreshFromNet();
                      }),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () {
                      context.push('/more_news');
                    },
                    child: Text(
                      l10n.moreNews,
                      style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Carousel<ArticlePo>(
              data: data,
              itemBuilder: (BuildContext context, ArticlePo data) {
                return NewsArticleDisplay(article: data);
              },
            ),
          ),
        ],
      ),
    );
  }
}

void launch(String url) => _launchUrl(url);

void _launchUrl(String url) async {
  if (!await launchUrl(Uri.parse(url))) {}
}

class NewsArticleDisplay extends StatelessWidget {
  const NewsArticleDisplay({
    super.key,
    required this.article,
  });

  /// 当前轮播展示的文章。
  final ArticlePo article;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: _buildArticle);
  }

  /// 根据封面的实际布局宽度请求适配当前设备像素密度的图片变体。
  Widget _buildArticle(BuildContext context, BoxConstraints constraints) {
    final double logicalWidth = constraints.maxWidth.isFinite
        ? constraints.maxWidth
        : MediaQuery.sizeOf(context).width;
    final double pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final int imageWidth =
        (logicalWidth * pixelRatio).ceil().clamp(1, 4096).toInt();
    final String cover = article.cover?.trim() ?? '';
    final String? coverUrl = cover.isEmpty
        ? null
        : FlutterUnitHost.resolveImageResource(
            cover,
            width: imageWidth,
          ).toString();
    return GestureDetector(
      onTap: () {
        _launchUrl(article.url);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (coverUrl != null)
              ImageRender(
                source: coverUrl,
                fit: BoxFit.cover,
                cacheWidth: imageWidth,
              ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        margin: EdgeInsets.only(right: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4)),
                        child: Text(
                          '新',
                          style: TextStyle(
                              fontSize: 8, color: Colors.white, height: 1),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          article.title,
                          style: TextStyle(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    offset: Offset(.5, .5),
                                    blurRadius: 4)
                              ],
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
