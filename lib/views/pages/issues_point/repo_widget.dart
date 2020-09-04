import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/utils/convert_man.dart';
import 'package:flutter_unit/components/permanent/color_wrapper.dart';
import 'package:flutter_unit/model/github/repository.dart';

/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明: 


class RepoWidget extends StatelessWidget {
  final Repository repository;

  RepoWidget({this.repository});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 56 + 24.0, bottom: 5),
      padding: EdgeInsets.all(10),
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
              SizedBox(width: 10,),
              WrapColor(
                child: Text(
                  repository.license.spdxId,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(TolyIcon.icon_show),
                    SizedBox(
                      width: 5,
                    ),
                    Text(repository.subscribersCount.toString()),
                  ]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Icon(TolyIcon.icon_issues),
                    SizedBox(
                      width: 5,
                    ),
                    Text(repository.openIssuesCount.toString()),
                  ]),
            ],
          )
        ],
      ),
    );
  }
}