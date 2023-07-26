import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/columnize/bloc.dart';
import '../blocs/exp.dart';
import '../repositories/exp.dart';
import '../repositories/repository/article_repository.dart';
import 'article/toly_article_scroll_page.dart';

import 'dart:ui' as ui;

import 'building/building_panel.dart';

class ArtifactPage extends StatefulWidget {
  const ArtifactPage({Key? key}) : super(key: key);

  @override
  State<ArtifactPage> createState() => _ArtifactPageState();
}

// 任意处下滑可出现 AppBar
//  |--- NestedScrollView#floatHeaderSlivers: true
//  |--- SliverAppBar#floating: true

// 任意处下滑可出现 AppBar + 轻滑出现
//  |--- NestedScrollView#floatHeaderSlivers: true
//  |--- SliverAppBar#floating: true
//  |--- SliverAppBar#snap: true

const List<String> kArtifactInfo = [
  '分类收录张风捷特烈的博客文章',
  'Flutter 框架探索，七剑合璧',
  '收录布局方案，提供界面样板',
  'Flutter 知识小要点，一网打尽',
];

class _ArtifactPageState extends State<ArtifactPage>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  List<String> data = [];
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(_listen);
    data = List.generate(5, (index) => 'Init $index');
  }

  int _curIndex = 0;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  ArticleRepository aRepository = const ArticleRepository();
  ColumnizeRepository cRepository = const ColumnizeRepository();

  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).padding.bottom;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ColumnizeBloc>(create: (_) => ColumnizeBloc(cRepository)..init()),
        BlocProvider<ArticleBloc>(create: (_) => ArticleBloc(aRepository)..init()),
      ],
      child: Scaffold(
        backgroundColor: const Color(0xffF2F3F5),
        bottomNavigationBar: Container(height: bottom),
        body: NestedScrollView(
          headerSliverBuilder: _buildAppBar,
          floatHeaderSlivers: true,
          body: TabBarView(
            controller: controller,
            children: [
              TolyArticleScrollPage(),
              BuildingPanel(),
              BuildingPanel(),
              BuildingPanel(),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildAppBar(BuildContext context, bool innerBoxIsScrolled) {
    // print('innerBoxIsScrolled:$innerBoxIsScrolled');
    return [
      // SliverOverlapAbsorber(
      // handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      //
      // sliver:
      SliverAppBar(
        floating: true,
        snap: true,
        pinned: true,
        backgroundColor: Colors.white,

        // flexibleSpace: Image.network(
        //   'https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/448d4eb270f44edab0192a1281141954~tplv-k3u1fbpfcp-watermark.image?',
        //   fit: BoxFit.cover,
        // ),

        // expandedHeight: 120,

        flexibleSpace: Container(
          // height: 240,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffD3D5F5),
            Color(0xffC8EBFA),
          ], transform: GradientRotation(pi / 4))),
        ),
        // flexibleSpace: Doodle(),
        // leading: Center(
        //     child: Text(
        //   '宝具库',
        //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        // )),
        // actions: [Icon(Icons.cached_outlined)],
        titleSpacing: 0,
        // leadingWidth: 40,

        title: Column(
          children: [
            Text(
              'Flutter 知识宝库',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              kArtifactInfo[_curIndex],
              maxLines: 2,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: Colors.purple),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
        ],
        // title: Padding(
        //   padding: const EdgeInsets.only(right: 8.0),
        //   child: CupertinoTextField(),
        // ),
        bottom: TabBar(
          controller: controller,
          tabs: [
            Tab(
              // icon: Icon(Icons.account_balance_wallet_outlined),
              text: '捷特文库',
            ),
            Tab(
              // icon: Icon(Icons.account_balance_wallet_outlined),
              text: '七剑合璧',
            ),
            Tab(
              // icon: Icon(Icons.account_balance_wallet_outlined),
              text: '布局宝库',
            ),
            Tab(
              // icon: Icon(Icons.account_balance_wallet_outlined),
              text: '要点宝库',
            ),
          ],
        ),
      ), // )
    ];
  }

  Widget? _buildItem(BuildContext context, int index) {
    return ListTile(
      tileColor: Colors.white,
      title: Text(data[index]),
    );
  }

  void _listen() {
    print('${controller.index}');
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
