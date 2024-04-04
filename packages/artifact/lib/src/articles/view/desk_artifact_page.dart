import 'package:algorithm/algorithm.dart';
import 'package:artifact/artifact.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layout/layout.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/exp.dart';
import '../data/exp.dart';
import 'article/sliver_article.dart';
import 'article/sliver_columnize.dart';
import 'building/building_panel.dart';
import 'package:l10n/l10n.dart';
class DeskKnowledgePage extends StatefulWidget {
  const DeskKnowledgePage({super.key});

  @override
  State<DeskKnowledgePage> createState() => _DeskKnowledgePageState();
}

class _DeskKnowledgePageState extends State<DeskKnowledgePage>  with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin{

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
    super.build(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<ColumnizeBloc>(create: (_) => ColumnizeBloc(cRepository)..init()),
        BlocProvider<ArticleBloc>(create: (_) => ArticleBloc(aRepository,pageSize: 1000)..init()),
      ],
      child: Scaffold(
        endDrawer: SortSettings(),
        body: Column(
          children: [
            DeskKnowledgeTabTopBar(onTabPressed: (int value) {
              controller.index = value;
            }, tabs: [
              context.l10n.knowledgeTabLayout,
              context.l10n.knowledgeTabToly,
              context.l10n.knowledgeTabAlgo,
              context.l10n.knowledgeTabPoint,
            ],),
            Expanded(child: TabBarView(
              controller: controller,
              children: [
                LayoutRouterPage(),
                TolyArticlesPage(),
                SoreAlgoPage(),
                DeskPointPage(),
              ],
            ))
          ],
        ),
      ),
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

  @override
  bool get wantKeepAlive => true;
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
              SortButton(),
              const SizedBox(width: 12,),
              SortSelector(),
              const SizedBox(width: 12,),
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
      await launchUrl(uri,mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $url');
    }
  }

}
