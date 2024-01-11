
import 'package:artifact/artifact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:refresh/refresh.dart';

import '../../bloc/exp.dart';

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
    return RefreshConfigWrapper(
      child: SmartRefresher(
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
    await Future.delayed(Duration(milliseconds: 500));

    _refreshController.refreshCompleted();
  }

  void _loadMore() async {
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
