import 'package:algorithm/algorithm.dart';
import 'package:artifact/artifact.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout/layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/exp.dart';
import '../data/exp.dart';
import 'library/library_page.dart';
import 'package:l10n/l10n.dart';

class DeskKnowledgePage extends StatefulWidget {
  /// 绘制集录页面，由应用组装层注入。
  final Widget drawingPage;

  const DeskKnowledgePage({super.key, required this.drawingPage});

  @override
  State<DeskKnowledgePage> createState() => _DeskKnowledgePageState();
}

class _DeskKnowledgePageState extends State<DeskKnowledgePage>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  /// 知识库四个入口的页面切换控制器。
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  /// 在线文章仓储。
  final ArticleRepository aRepository = const ArticleRepository();

  /// 在线专栏仓储。
  final ColumnizeRepository cRepository = const ColumnizeRepository();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    AppLocalizations l10n = context.l10n;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ColumnizeBloc>(
            create: (_) => ColumnizeBloc(cRepository)..init()),
        BlocProvider<ArticleBloc>(
            create: (_) => ArticleBloc(aRepository, pageSize: 40)..init()),
      ],
      child: Scaffold(
        endDrawer: SortSettings(),
        body: Column(
          children: [
            DeskKnowledgeTabTopBar(
              onTabPressed: (int value) {
                controller.animateTo(value);
              },
              tabs: [
                l10n.knowledgeTabToly,
                l10n.knowledgeTabLayout,
                l10n.paintCollection,
                l10n.knowledgeTabAlgo,
              ],
            ),
            Expanded(
                child:
                    ListenableBuilder(listenable: controller, builder: _pages))
          ],
        ),
      ),
    );
  }

  /// 桌面二级标签同样保留页面，并让隐藏入口停止动画。
  Widget _pages(BuildContext context, Widget? child) {
    final List<Widget> pages = <Widget>[
      const TolyArticlesPage(),
      LayoutRouterPage(),
      widget.drawingPage,
      AlgoRouterPage(),
    ];
    return TabBarView(controller: controller, children: <Widget>[
      for (int index = 0; index < pages.length; index++)
        RetainedPage(
            key: ValueKey<int>(index),
            active: controller.index == index,
            child: pages[index]),
    ]);
  }

  @override
  bool get wantKeepAlive => true;
}

class TolyArticlesPage extends StatelessWidget {
  const TolyArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ArticleLibraryPage();
  }
}

class SoreAlgoPage extends StatelessWidget {
  const SoreAlgoPage({super.key});

  @override
  Widget build(BuildContext context) {
    String name = SortStateScope.of(context).config.name;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              GestureDetector(
                  onTap: () {
                    _launchURL(
                        'https://github.com/toly1994328/FlutterUnit/blob/master/packages/algorithm/lib/src/algorithm/sort/functions/${name}.dart');
                  },
                  child: Text(
                    '查看排序源码',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).primaryColor,
                    ),
                  )),
              Spacer(),
              SortButton(),
              const SizedBox(
                width: 12,
              ),
              SortSelector(),
              const SizedBox(
                width: 12,
              ),
              GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Icon(Icons.settings))
            ],
          ),
        ),
        Expanded(child: SortPaper()),
      ],
    );
  }

  void _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }
}
