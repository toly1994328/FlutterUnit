import 'dart:math';
import 'dart:async';

import 'package:algorithm/algorithm.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout/layout.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/exp.dart';
import '../data/exp.dart';
import 'library/article_browser.dart';
import 'library/library_controller.dart';
import 'library/library_controls.dart';

import 'dart:ui' as ui;

import 'mobile_knowledge_header.dart';

class ArtifactPage extends StatefulWidget {
  /// 绘制集录页面，由应用组装层注入。
  final Widget drawingPage;

  const ArtifactPage({super.key, required this.drawingPage});

  @override
  State<ArtifactPage> createState() => _ArtifactPageState();
}

class _ArtifactPageState extends State<ArtifactPage>
    with SingleTickerProviderStateMixin {
  /// 四个知识入口的切换控制器。
  late TabController controller;

  /// 页面保活期间共用的文章查询。
  late final ArticleBloc _articles;

  /// 文库与顶部书架共用的专栏目录。
  late final ColumnizeBloc _collections;

  /// 顶部栏与文库列表共用的筛选状态。
  late final LibraryController _library;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(_listen);
    _articles = ArticleBloc(aRepository)..init();
    _collections = ColumnizeBloc(cRepository)..init();
    _library = LibraryController(_articles);
  }

  /// 当前入口，绘制页和算法页有独立的滚动与操作。
  int _curIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    _library.dispose();
    unawaited(_articles.close());
    unawaited(_collections.close());
    super.dispose();
  }

  /// 在线文章仓储。
  final ArticleRepository aRepository = const ArticleRepository();

  /// 在线专栏仓储。
  final ColumnizeRepository cRepository = const ColumnizeRepository();

  @override
  Widget build(BuildContext context) => Theme(
      data: mobileKnowledgeTheme(Theme.of(context)),
      child: Builder(builder: _body));

  /// 保留各知识入口的真实页面，共用新的顶部导航。
  Widget _body(BuildContext context) {
    final String name = SortStateScope.of(context).config.name;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ColumnizeBloc>.value(value: _collections),
        BlocProvider<ArticleBloc>.value(value: _articles),
      ],
      child: Scaffold(
        endDrawer: SortSettings(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: NestedScrollView(
          physics: _curIndex == 2 ? const NeverScrollableScrollPhysics() : null,
          headerSliverBuilder: _buildAppBar,
          body: TabBarView(
            controller: controller,
            children: [
              RetainedPage(
                  active: _curIndex == 0,
                  child: ArticleBrowser(
                      controller: _library,
                      showToolbar: false,
                      showCollections: true)),
              RetainedPage(
                  active: _curIndex == 1,
                  child: const LayoutRouterPage(compact: true)),
              RetainedPage(
                  active: _curIndex == 2,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onVerticalDragUpdate: (DragUpdateDetails details) {},
                    child: widget.drawingPage,
                  )),
              RetainedPage(
                  active: _curIndex == 3,
                  child: Column(
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
                            SortSelector(),
                          ],
                        ),
                      ),
                      Expanded(child: SortPaper()),
                    ],
                  )),
              // BuildingPanel(),
              // BuildingPanel(),
            ],
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  List<Widget> _buildAppBar(BuildContext context, bool innerBoxIsScrolled) =>
      <Widget>[
        SliverAppBar(
          automaticallyImplyActions: false,
          automaticallyImplyLeading: false,
          // 搜索和知识入口始终可见，不随正文滚动折叠。
          floating: false,
          snap: false,
          pinned: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: _curIndex == 0 ? 60 : 0,
          titleSpacing: 16,
          centerTitle: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Colors.transparent,
          title: _curIndex == 0
              ? LibraryControls(controller: _library, compact: true)
              : null,
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: Row(children: <Widget>[
                Expanded(child: MobileKnowledgeTabs(controller: controller)),
                if (_curIndex == 3)
                  IconButton(
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      icon: const Icon(Icons.settings)),
              ])),
        ),
      ];

  void _listen() {
    if (_curIndex != controller.index) {
      setState(() {
        _curIndex = controller.index;
      });
    }
  }
}

class Doodle extends StatelessWidget {
  const Doodle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: DoodlePainter(),
        child: const Center(),
      ),
    );
  }
}

class DoodlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint pen = Paint();
    pen.shader = ui.Gradient.linear(
        Offset.zero,
        Offset(size.width, size.height),
        [const Color(0xffD3D5F5), const Color(0xffC8EBFA)],
        [0, 1],
        TileMode.mirror,
        Matrix4.rotationZ(pi / 4).storage);
    canvas.drawRect(Offset.zero & size, pen);
    // print(size);
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2),
        size.height / 6,
        Paint()
          ..color = Colors.grey
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
