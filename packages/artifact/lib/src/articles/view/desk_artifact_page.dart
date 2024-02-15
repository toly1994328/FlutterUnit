import 'package:algorithm/algorithm.dart';
import 'package:artifact/artifact.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/exp.dart';
import '../data/exp.dart';
import 'article/sliver_article.dart';
import 'article/sliver_columnize.dart';
import 'building/building_panel.dart';

class DeskKnowledgePage extends StatefulWidget {
  const DeskKnowledgePage({super.key});

  @override
  State<DeskKnowledgePage> createState() => _DeskKnowledgePageState();
}

class _DeskKnowledgePageState extends State<DeskKnowledgePage>  with SingleTickerProviderStateMixin{

  late TabController controller;
  List<String> data = [];
  int _curIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
    controller.addListener(_listen);
    data = List.generate(5, (index) => 'Init $index');
  }
  ArticleRepository aRepository = const ArticleRepository();
  ColumnizeRepository cRepository = const ColumnizeRepository();
  @override
  Widget build(BuildContext context) {
    String name = SortStateScope.of(context).config.name;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ColumnizeBloc>(create: (_) => ColumnizeBloc(cRepository)..init()),
        BlocProvider<ArticleBloc>(create: (_) => ArticleBloc(aRepository,pageSize: 1000)..init()),
      ],
      child: Column(
        children: [
          DeskKnowledgeTabTopBar(onTabPressed: (int value) {
            controller.index = value;
          }, tabs: [
            '捷特文库',
            '算法演绎',
            '布局宝库',
            '要点宝库',
          ],),
          Expanded(child: TabBarView(
            controller: controller,
            children: [
              TolyArticlesPage(),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              _launchURL('https://github.com/toly1994328/FlutterUnit/blob/master/packages/algorithm/lib/src/algorithm/sort/functions/${name}.dart');
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
              ),
              BuildingPanel(),
              DeskPointPage(),
            ],
          ))
        ],
      ),
    );
  }

  _launchURL(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(uri,mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
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

class TolyArticlesPage extends StatelessWidget {
  const TolyArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(

      slivers: [
        SliverPadding(
          padding: EdgeInsets.only(top: 10,bottom: 10,right: 36,left: 36),
          sliver: const SliverToBoxAdapter(
            child: ColumnizeViewPage(),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(right: 36,left:36),
          sliver:    SliverArticlePanel(),
        ),

      ],
    );
  }
}
