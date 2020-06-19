import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';

/// create by 张风捷特烈 on 2020/6/17
/// contact me by email 1981462002@qq.com
/// 说明:

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_unit/app/api/github/issues_api.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/app/utils/convert_man.dart';
import 'package:flutter_unit/app/utils/http/rep_result.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/model/github/issue.dart';
import 'package:flutter_unit/model/github/repository.dart';


class IssuesPointPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          appBar: AppBar(
//            title: Text("Flutter Unit Point"),
//          ),
        body: IssuesPointContent()
//    ListView(
//              children: <Widget>[
//                RepoWidget(),
//                IssuesPointContent(),
//              ],
//            ),
        );
  }
}

class RepoWidget extends StatelessWidget {
  final Repository repository;

  RepoWidget({this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 56 + 24.0, bottom: 5),
      padding: EdgeInsets.all(10),
//      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, offset: Offset(0, .5), blurRadius: 3)
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                repository.fullName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              WrapColor(
                child:Text(
                  repository.license.spdxId,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 12),
                ),
              ),
              Spacer(),
              Text(
                "创建:" +
                    ConvertMan.time2string(repository.createdAt, just: true),
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              repository.description,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Divider(),
          Wrap(
            children: <Widget>[],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(Icons.star_border),
                    Text(repository.stargazersCount.toString()),
                  ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20,color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(TolyIcon.icon_show),
                    SizedBox(width: 5,),
                    Text(repository.subscribersCount.toString()),
                  ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20,color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(TolyIcon.icon_fork),
                    Text(repository.forksCount.toString()),
                  ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical:8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20,color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(TolyIcon.icon_issues),
                    SizedBox(width: 5,),
                    Text(repository.openIssuesCount.toString()),
                  ]),
            ],
          )
        ],
      ),
    );
  }
}

class IssuesPointContent extends StatefulWidget {
  @override
  _IssuesPointContentState createState() => _IssuesPointContentState();
}

class _IssuesPointContentState extends State<IssuesPointContent> {
  List<Issue> _issues;

  @override
  void initState() {
    super.initState();
    _loadIssues();
  }

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (_issues == null) {
      content = SliverPadding(
        padding: EdgeInsets.only(top: 40),
        sliver: SliverToBoxAdapter(
          child: SpinKitWave(
            color: Colors.blue,
          )
        ),
      );
    } else {
      content = SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => IssueItem(issue: _issues[index]),
            childCount: _issues.length),
      );
    }
    return Container(
      child: RefreshIndicator(
        onRefresh: _loadIssues,
        child: CustomScrollView(slivers: <Widget>[_buildSliverAppBar(), content]
//          ListView.separated(
//            shrinkWrap: true,
//            separatorBuilder: (ctx, index) => Divider(
//              height: 1,
//            ),
//            itemBuilder: (ctx, index) => IssueItem(
//              issue: _issues[index],
//            ),
//            itemCount: _issues.length,
//          ),
            ),
      ),
    );
  }

  Widget _buildSliverAppBar() {
    var repos = Repository.empty();

    var jsonStr = """
    {
    "id": 248628088,
    "node_id": "MDEwOlJlcG9zaXRvcnkyNDg2MjgwODg=",
    "name": "FlutterUnit",
    "full_name": "toly1994328/FlutterUnit",
    "private": false,
    "owner": {
        "login": "toly1994328",
        "id": 26687012,
        "node_id": "MDQ6VXNlcjI2Njg3MDEy",
        "avatar_url": "https://avatars3.githubusercontent.com/u/26687012?v=4",
        "gravatar_id": "",
        "url": "https://api.github.com/users/toly1994328",
        "html_url": "https://github.com/toly1994328",
        "followers_url": "https://api.github.com/users/toly1994328/followers",
        "following_url": "https://api.github.com/users/toly1994328/following{/other_user}",
        "gists_url": "https://api.github.com/users/toly1994328/gists{/gist_id}",
        "starred_url": "https://api.github.com/users/toly1994328/starred{/owner}{/repo}",
        "subscriptions_url": "https://api.github.com/users/toly1994328/subscriptions",
        "organizations_url": "https://api.github.com/users/toly1994328/orgs",
        "repos_url": "https://api.github.com/users/toly1994328/repos",
        "events_url": "https://api.github.com/users/toly1994328/events{/privacy}",
        "received_events_url": "https://api.github.com/users/toly1994328/received_events",
        "type": "User",
        "site_admin": false
    },
    "html_url": "https://github.com/toly1994328/FlutterUnit",
    "description": "【Flutter 集录指南 App】The unity of flutter, The unity of coder.",
    "fork": false,
    "url": "https://api.github.com/repos/toly1994328/FlutterUnit",
    "forks_url": "https://api.github.com/repos/toly1994328/FlutterUnit/forks",
    "keys_url": "https://api.github.com/repos/toly1994328/FlutterUnit/keys{/key_id}",
    "collaborators_url": "https://api.github.com/repos/toly1994328/FlutterUnit/collaborators{/collaborator}",
    "teams_url": "https://api.github.com/repos/toly1994328/FlutterUnit/teams",
    "hooks_url": "https://api.github.com/repos/toly1994328/FlutterUnit/hooks",
    "issue_events_url": "https://api.github.com/repos/toly1994328/FlutterUnit/issues/events{/number}",
    "events_url": "https://api.github.com/repos/toly1994328/FlutterUnit/events",
    "assignees_url": "https://api.github.com/repos/toly1994328/FlutterUnit/assignees{/user}",
    "branches_url": "https://api.github.com/repos/toly1994328/FlutterUnit/branches{/branch}",
    "tags_url": "https://api.github.com/repos/toly1994328/FlutterUnit/tags",
    "blobs_url": "https://api.github.com/repos/toly1994328/FlutterUnit/git/blobs{/sha}",
    "git_tags_url": "https://api.github.com/repos/toly1994328/FlutterUnit/git/tags{/sha}",
    "git_refs_url": "https://api.github.com/repos/toly1994328/FlutterUnit/git/refs{/sha}",
    "trees_url": "https://api.github.com/repos/toly1994328/FlutterUnit/git/trees{/sha}",
    "statuses_url": "https://api.github.com/repos/toly1994328/FlutterUnit/statuses/{sha}",
    "languages_url": "https://api.github.com/repos/toly1994328/FlutterUnit/languages",
    "stargazers_url": "https://api.github.com/repos/toly1994328/FlutterUnit/stargazers",
    "contributors_url": "https://api.github.com/repos/toly1994328/FlutterUnit/contributors",
    "subscribers_url": "https://api.github.com/repos/toly1994328/FlutterUnit/subscribers",
    "subscription_url": "https://api.github.com/repos/toly1994328/FlutterUnit/subscription",
    "commits_url": "https://api.github.com/repos/toly1994328/FlutterUnit/commits{/sha}",
    "git_commits_url": "https://api.github.com/repos/toly1994328/FlutterUnit/git/commits{/sha}",
    "comments_url": "https://api.github.com/repos/toly1994328/FlutterUnit/comments{/number}",
    "issue_comment_url": "https://api.github.com/repos/toly1994328/FlutterUnit/issues/comments{/number}",
    "contents_url": "https://api.github.com/repos/toly1994328/FlutterUnit/contents/{+path}",
    "compare_url": "https://api.github.com/repos/toly1994328/FlutterUnit/compare/{base}...{head}",
    "merges_url": "https://api.github.com/repos/toly1994328/FlutterUnit/merges",
    "archive_url": "https://api.github.com/repos/toly1994328/FlutterUnit/{archive_format}{/ref}",
    "downloads_url": "https://api.github.com/repos/toly1994328/FlutterUnit/downloads",
    "issues_url": "https://api.github.com/repos/toly1994328/FlutterUnit/issues{/number}",
    "pulls_url": "https://api.github.com/repos/toly1994328/FlutterUnit/pulls{/number}",
    "milestones_url": "https://api.github.com/repos/toly1994328/FlutterUnit/milestones{/number}",
    "notifications_url": "https://api.github.com/repos/toly1994328/FlutterUnit/notifications{?since,all,participating}",
    "labels_url": "https://api.github.com/repos/toly1994328/FlutterUnit/labels{/name}",
    "releases_url": "https://api.github.com/repos/toly1994328/FlutterUnit/releases{/id}",
    "deployments_url": "https://api.github.com/repos/toly1994328/FlutterUnit/deployments",
    "created_at": "2020-03-19T23:47:07Z",
    "updated_at": "2020-06-16T19:39:41Z",
    "pushed_at": "2020-06-16T05:15:27Z",
    "git_url": "git://github.com/toly1994328/FlutterUnit.git",
    "ssh_url": "git@github.com:toly1994328/FlutterUnit.git",
    "clone_url": "https://github.com/toly1994328/FlutterUnit.git",
    "svn_url": "https://github.com/toly1994328/FlutterUnit",
    "homepage": "",
    "size": 34927,
    "stargazers_count": 1690,
    "watchers_count": 1690,
    "language": "Dart",
    "has_issues": true,
    "has_projects": true,
    "has_downloads": true,
    "has_wiki": true,
    "has_pages": false,
    "forks_count": 225,
    "mirror_url": null,
    "archived": false,
    "disabled": false,
    "open_issues_count": 26,
    "license": {
        "key": "mit",
        "name": "MIT License",
        "spdx_id": "MIT",
        "url": "https://api.github.com/licenses/mit",
        "node_id": "MDc6TGljZW5zZTEz"
    },
    "forks": 225,
    "open_issues": 26,
    "watchers": 1690,
    "default_branch": "master",
    "temp_clone_token": null,
    "network_count": 225,
    "subscribers_count": 41
}
    """;

    repos.stargazersCount = 1000;
    return SliverAppBar(
      expandedHeight: 210.0,
//      leading: _buildLeading(),
      title: Text('Flutter要点集录'),
//      actions: _buildActions(),
      elevation: 5,
      pinned: true,
      backgroundColor: Colors.blue,
      flexibleSpace: FlexibleSpaceBar(
        //伸展处布局
        titlePadding: EdgeInsets.only(left: 55, bottom: 15), //标题边距
        collapseMode: CollapseMode.parallax, //视差效果
        background: RepoWidget(
          repository: Repository.fromJson(json.decode(jsonStr)),
        ),
      ),
    );
  }

  Future<void> _loadIssues() async {
    RepResult result = await IssuesApi.getIssues(
        username: "toly1994328",
        repository: "FlutterUnit",
        labels: "point",
        direction: "asc");
    print(result);
    setState(() {
      if (result != null) {
        _issues = result.data;
      }
    });
  }
}

class IssueItem extends StatelessWidget {
  final Issue issue;

  IssueItem({this.issue});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1 / window.devicePixelRatio))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTop(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10),
            child: Text(
              issue.title,
              style: TextStyle(fontSize: 15, color: Colors.grey, shadows: [
                Shadow(color: Colors.white, offset: Offset(1, .5))
              ]),
            ),
          ),
          Row(
            children: <Widget>[
              Spacer(),
              WrapColor(
                  color: Colors.greenAccent,
                  child: Text(issue.commentNum.toString(),style: TextStyle(color: Colors.white),)),
              SizedBox(
                width: 5,
              ),
              Icon(
                TolyIcon.icon_common,
                size: 20,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Row(
      children: <Widget>[
        CircleImage(
          image: NetworkImage(issue.user.avatar_url),
          size: 40,
          borderSize: 2,
        ),
        SizedBox(
          width: 10,
        ),
        WrapColor(child: Text("#${issue.number}",style: TextStyle(color: Colors.white),)),
        SizedBox(
          width: 10,
        ),
        Text(
          issue.user.login,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Text(ConvertMan.time2string(issue.createdAt)),
      ],
    );
  }
}

class WrapColor extends StatelessWidget {
  final Widget child;
  final Color color;
  final double radius;
  final EdgeInsetsGeometry padding;

  WrapColor(
      {this.child,
      this.color = Colors.blue,
      this.radius = 5,
      this.padding =
          const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: padding,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}
