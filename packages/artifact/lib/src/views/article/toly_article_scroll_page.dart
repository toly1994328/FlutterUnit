
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:refresh/refresh.dart';

import '../../blocs/exp.dart';
import '../toly_refresh_indicator.dart';
import 'sliver_article.dart';
import 'sliver_columnize.dart';

class TolyArticleScrollPage extends StatefulWidget {
  const TolyArticleScrollPage({Key? key}) : super(key: key);

  @override
  State<TolyArticleScrollPage> createState() => _TolyArticleScrollPageState();
}

class _TolyArticleScrollPageState extends State<TolyArticleScrollPage> {

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int maxCount = 60;

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color themeColor = Color(0xff007ACB);

    return RefreshConfiguration(
      headerTriggerDistance: 60,
      topHitBoundary: 20,
      child: SmartRefresher(
          header: TolyRefreshIndicator(),
          // header: BezierCircleHeader(),
          // header: WaterDropHeader(),
          // header: BezierHeader(),

          // header: const ClassicHeader(
          //   idleText: '',
          //   releaseText: '释放刷新',
          //   refreshingText: '加载数据',
          //   completeText: '刷新成功!',
          //   refreshingIcon: CupertinoActivityIndicator(color: themeColor,),
          //   completeIcon: Icon(Icons.done, color: themeColor),
          //   releaseIcon: Icon(Icons.refresh, color: themeColor),
          //   idleIcon: Icon(Icons.arrow_downward, color: Colors.grey),
          //   textStyle: TextStyle(color: themeColor),
          // ),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus? mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.arrow_upward, color: themeColor),
                    Text("上拉加载",
                        style: TextStyle(color: themeColor, height: 1)),
                  ],
                );
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败！点击重试！");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("松手,加载更多!",
                    style: TextStyle(color: themeColor, height: 1));
              } else {
                body = Text("没有更多数据了!",
                    style: TextStyle(
                      color: Colors.grey,
                    ));
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          enablePullUp: true,
          onRefresh: _onRefresh,
          onLoading: _loadMore,
          controller: _refreshController,
          child: CustomScrollView(
            slivers: [
              // SliverOverlapInjector(
              //   handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              // ),
              SliverPadding(
                padding: EdgeInsets.only(top: 10,bottom: 10),
                sliver: const SliverToBoxAdapter(
                  child: ColumnizeViewPage(),
                ),
              ),
              SliverArticlePanel(),
            ],
          )

          //   ListView.builder(
          //   padding: EdgeInsets.only(top: 10),
          //   itemCount: data.length,
          //   itemBuilder: _buildItem,
          // ),
          ),
    );
  }

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    List<String> newData = [];
    for (int i = 0; i < 2; i++) {
      newData.add('New: ${i}');
    }
    // data.insertAll(0, newData);
    setState(() {});

    _refreshController.refreshCompleted();
  }

  void _loadMore() async {
    print('===========_loadMore===============');
    // await Future.delayed(Duration(milliseconds: 1000));
    ArticleBloc bloc = context.read<ArticleBloc>();
    await context.read<ArticleBloc>().loadNextPageMore();
    // int length = data.length;
    ArticleState state = bloc.state;
    if(state is ArticleWithData){
      if (state.data.length >= state.total) {
        _refreshController.loadNoData();
        await Future.delayed(Duration(milliseconds: 2000));
        _refreshController.resetNoData();
        return;
      }

      _refreshController.loadComplete();
    }

  }


}
