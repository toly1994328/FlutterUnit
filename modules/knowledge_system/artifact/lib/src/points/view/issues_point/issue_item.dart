import 'dart:ui';

import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:utils/utils.dart';

import '../../data/model/issue.dart';

/// create by 张风捷特烈 on 2020/9/3
/// contact me by email 1981462002@qq.com
/// 说明:

class IssueItem extends StatelessWidget {
  final Issue issue;

  const IssueItem({Key? key, required this.issue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Theme.of(context).dividerTheme.color??Colors.transparent,
                width: 1 / window.devicePixelRatio)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildTop(),
          Padding(
            padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 10),
            child: Text(
              '${issue.title}',
              style: TextStyle(fontSize: 15, color: Colors.grey, shadows: [
                Shadow(
                    color: isDark ? Colors.black : Colors.white,
                    offset: Offset(1, .5))
              ]),
            ),
          ),
          Row(
            children: <Widget>[
              const Spacer(),
              WrapColor(
                  color: Colors.greenAccent,
                  child: Text(
                    issue.commentNum.toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
              const SizedBox(
                width: 5,
              ),
              const Icon(
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
          image: NetworkImage(issue.user?.avatarUrl ?? ''),
          size: 40,
          borderSize: 2,
        ),
        const SizedBox(
          width: 10,
        ),
        WrapColor(
            child: Text(
          "#${issue.number}",
          style: const TextStyle(color: Colors.white),
        )),
        const SizedBox(
          width: 10,
        ),
        Text(
          '${issue.user?.login}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Text(ConvertMan.time2string(issue.createdAt!)),
      ],
    );
  }
}
