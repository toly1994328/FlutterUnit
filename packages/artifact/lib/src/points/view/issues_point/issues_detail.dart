import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utils/utils.dart';

import '../../bloc/point_system_bloc.dart';
import '../../data/model/github_model.dart';
import '../../data/model/issue.dart';

/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明:

class IssuesDetailPage extends StatelessWidget {
  const IssuesDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0,kToolbarHeight),
        child: DragToMoveAreaNoDouble(
          child: AppBar(
            centerTitle: false,
            title: const Text('Flutter 要点集录'),
          ),
        ),
      ),
      body: BlocBuilder<PointCommentBloc, PointCommentState>(
          builder: _buildContent),
    );
  }

  Widget _buildContent(BuildContext context, PointCommentState state) {
    if (state is PointCommentLoading) {
      return IssueTitle(issue: state.issue);
    }

    if (state is PointCommentLoaded) {
      return CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: IssueTitle(issue: state.issue)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (ctx, int index) => IssueCommentWidget(
                      comment: state.comments[index],
                    ),
                childCount: state.comments.length),
          )
        ],
      );
    }

    return Container();
  }
}

class IssueTitle extends StatelessWidget {
  final Issue issue;

  const IssueTitle({Key? key, required this.issue}) : super(key: key);

  String get issueDesHtml => issue.bodyHtml != null
      ? issue.bodyHtml!
      : (issue.body != null)
          ? issue.body!
          : "";

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Panel(
                      color: isDark?Colors.transparent:null,
                      child: Text(

                    '${issue.title}',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              WrapColor(
                child: Text(
                  '#${issue.number}',
                  style: const TextStyle(color: Colors.white),
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
            child: WrapColor(
              color: Colors.blue.withAlpha(22),
              child: ListTile(
                dense: true,
                leading: CircleImage(
                  size: 40,
                  borderSize: 1,
                  image: NetworkImage(issue.user!.avatarUrl!),
                ),
                title: Text(issue.user!.login!),
                subtitle: Row(
                  children: [
                    Text('创建于:${ConvertMan.time2string(issue.createdAt!)}'),
                    const Spacer(),
                    WrapColor(
                        color: Colors.green,
                        child: Text(
                          '更新于:${ConvertMan.time2string(issue.updatedAt!)}',
                          style: const TextStyle(color: Colors.white),
                        )),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
            child: MarkdownWidget(
                markdownData: issueDesHtml,
                style: isDark?MarkdownWidget.kDarkLight:MarkdownWidget.kWhite),
          ),
          const Divider(
            thickness: 2,
          )
        ],
      ),
    );
  }
}

class IssueCommentWidget extends StatelessWidget {
  final IssueComment comment;

  const IssueCommentWidget({Key? key, required this.comment}) : super(key: key);

  String get issueDesHtml => comment.bodyHtml != null
      ? comment.bodyHtml!
      : (comment.body != null)
          ? comment.body!
          : "";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: WrapColor(
            color: Colors.blue.withAlpha(22),
            child: ListTile(
              dense: true,
              leading: CircleImage(
                size: 40,
                borderSize: 1,
                image: NetworkImage(comment.user!.avatarUrl!),
              ),
              title: Text(comment.user!.login!),
              subtitle: Row(
                children: [
                  Text('创建于:${ConvertMan.time2string(comment.createdAt!)}'),
                  const Spacer(),
                  WrapColor(
                      color: Colors.green,
                      child: Text(
                        '更新于:${ConvertMan.time2string(comment.updatedAt!)}',
                        style: const TextStyle(color: Colors.white),
                      )),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownWidget(
              markdownData: issueDesHtml, style: MarkdownWidget.kWhite),
        ),
        const Divider(thickness: 2)
      ],
    );
  }
}
