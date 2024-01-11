import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


import '../../bloc/point_system_bloc.dart';
import '../../data/api/issues_api.dart';
import '../../data/model/issue.dart';
import '../../data/model/repository.dart';
import 'issue_item.dart';
import 'issues_detail.dart';
import 'repo_widget.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

class IssuesPointScope extends StatelessWidget {
  const IssuesPointScope({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<PointBloc>(create: (_) => PointBloc()..add(EventLoadPoint())),
    ], child: const IssuesPointPage(),
    );
  }
}

class IssuesPointPage extends StatelessWidget {
  const IssuesPointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: IssuesPointContent());
  }
}

class IssuesPointContent extends StatefulWidget {
  const IssuesPointContent({Key? key}) : super(key: key);

  @override
  _IssuesPointContentState createState() => _IssuesPointContentState();
}

class _IssuesPointContentState extends State<IssuesPointContent> {
  Repository? _repository;

  @override
  void initState() {
    super.initState();
    _loadRepo();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PointBloc, PointState>(
        builder: (_, state) => RefreshIndicator(
              onRefresh: _loadIssues,
              child: CustomScrollView(slivers: <Widget>[
                // _buildSliverAppBar(),
                buildContentByState(state)
              ]),
            ));
  }

  Widget buildContentByState(PointState state) {
    if (state is PointLoading) {
      return const SliverPadding(
        padding: EdgeInsets.only(top: 150),
        sliver: SliverToBoxAdapter(
            child: Center(
          child: SpinKitCircle(
            color: Colors.blue,
          ),
        )),
      );
    }

    if (state is PointLoaded) {
      List<Issue> issues = state.issues;
      return SliverList(
          delegate: SliverChildBuilderDelegate(
              (ctx, int index) => GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(SlidePageRoute(
                        child: BlocProvider<PointCommentBloc>(
                            create: (_) => PointCommentBloc()
                              ..add(EventLoadPointComment(issues[index])),
                            child: const IssuesDetailPage())));

                    // Navigator.pushNamed(ctx, UnitRouter.
                    // );
                  },
                  child: IssueItem(issue: issues[index])),
              childCount: issues.length),);
    }

    if (state is PointLoadFailure) {
      return SliverPadding(
        padding: const EdgeInsets.only(top: 40),
        sliver: SliverToBoxAdapter(
            child: Center(
          child: Text(state.error),
        )),
      );
    }

    return const SliverPadding(
      padding: EdgeInsets.zero,
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 210.0,
//      leading: _buildLeading(),
      title: const Text('Flutter要点集录'),
//      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      actions: [
        IconButton(
            icon: const Icon(
              Icons.help_outline,
              color: Colors.white,
            ),
            onPressed: () {
              // Navigator.of(context).pushNamed(UnitRouter.bug);
            })
      ],
      backgroundColor: Colors.blue,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: const EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: _repository == null
            ? const Center(
                child: SpinKitFadingCube(
                  color: Colors.white,
                ),
              )
            : RepoWidget(
                repository: _repository!,
              ),
      ),
    );
  }

  Future<void> _loadIssues() async {
    BlocProvider.of<PointBloc>(context).add(EventLoadPoint());
    await Future.delayed(const Duration(milliseconds: 200));
  }

  void _loadRepo() async {
    final Repository result = await IssuesApi.getRepoFlutterUnit();
    setState(() {
      _repository = result;
    });
  }
}
