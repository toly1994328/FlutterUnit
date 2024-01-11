import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

import '../../data/model/repository.dart';

/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明: 


class RepoWidget extends StatelessWidget {
  final Repository repository;

  const RepoWidget({Key? key, required this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 56 + 32.0, bottom: 5),
      padding: const EdgeInsets.only(top:20,right: 10,left: 10),
      // padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
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
                repository.fullName!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 10,),
              WrapColor(
                child: Text(
                  '${repository.license?.type}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 12),
                ),
              ),
              const Spacer(),
              Text(
                "创建:${ConvertMan.time2string(repository.createdAt!, just: true)}",
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              repository.description!,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(Icons.star_border),
                    Text(repository.stargazersCount.toString()),
                  ]),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(TolyIcon.icon_show),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(repository.subscribersCount.toString()),
                  ]),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(TolyIcon.icon_fork),
                    Text(repository.forksCount.toString()),
                  ]),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "|",
                  style: TextStyle(fontSize: 20, color: Colors.blue),
                ),
              ),
              Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    const Icon(TolyIcon.icon_issues),
                    const SizedBox(
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