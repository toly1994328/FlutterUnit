import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/utils/convert_man.dart';
import 'package:flutter_unit/blocs/point_comment/point_comment_bloc.dart';
import 'package:flutter_unit/blocs/point_comment/point_comment_state.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/color_wrapper.dart';
import 'package:flutter_unit/components/permanent/markdown/markdown_widget.dart';
import 'package:flutter_unit/components/permanent/panel.dart';
import 'package:flutter_unit/model/github/issue_comment.dart';
import 'package:flutter_unit/model/github/issue.dart';

/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明:

class IssuesDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Point'),),
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
                      (ctx, int index) =>  IssueCommentWidget(comment:state.comments[index]),
                  childCount: state.comments.length))
        ],
      );
    }

    return Container();
  }
}

class IssueTitle extends StatelessWidget {
  final Issue issue;

  IssueTitle({Key key, this.issue}) : super(key: key);

  String get issueDesHtml => issue.bodyHtml != null
      ? issue.bodyHtml
      : (issue.body != null) ? issue.body : "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Panel(child: Text('${issue.title}',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),)),
              ),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: WrapColor(
                    child: Text('#${issue.number}',style: TextStyle(color: Colors.white),),
                  )),
            ],
          ),
          Divider(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: WrapColor(
              color: Colors.blue.withAlpha(22),
              child: ListTile(
                dense: true,
                leading: CircleImage(size:40,borderSize:1,image: NetworkImage(issue.user.avatar_url),),
                title: Text(issue.user.login),
                subtitle:Row(
                  children: [
                    Text('创建于:${ConvertMan.time2string(issue.createdAt)}'),
                    Spacer(),
                    WrapColor(
                        color: Colors.green,
                        child: Text('更新于:${ConvertMan.time2string(issue.updatedAt)}',style: TextStyle(color: Colors.white),)),

                  ],
                ) ,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MarkdownWidget(
                markdownData: issueDesHtml, style: MarkdownWidget.kWhite),
          ),
          Divider(thickness: 2,)
        ],
      ),
    );
  }
}

class IssueCommentWidget extends StatelessWidget {
  final IssueComment comment;

  IssueCommentWidget({Key key, this.comment}) : super(key: key);

  String get issueDesHtml => comment.bodyHtml != null
      ? comment.bodyHtml
      : (comment.body != null) ? comment.body : "";

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
              leading: CircleImage(size:40,borderSize:1,image: NetworkImage(comment.user.avatar_url),),
              title: Text(comment.user.login),
              subtitle:Row(
                children: [
                  Text('创建于:${ConvertMan.time2string(comment.createdAt)}'),
                  Spacer(),
                  WrapColor(
                      color: Colors.green,
                      child: Text('更新于:${ConvertMan.time2string(comment.updatedAt)}',style: TextStyle(color: Colors.white),)),

                ],
              ) ,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MarkdownWidget(
              markdownData: issueDesHtml, style: MarkdownWidget.kWhite),
        ),
        Divider(thickness: 2,)
      ],
    );
  }
}
