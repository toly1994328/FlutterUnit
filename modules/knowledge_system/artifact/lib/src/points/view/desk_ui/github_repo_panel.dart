import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';

import '../../data/model/repository.dart';


class GithubRepoPanel extends StatefulWidget {
  final Repository repository;

  const GithubRepoPanel({Key? key, required this.repository}) : super(key: key);

  @override
  State<GithubRepoPanel> createState() => _GithubRepoPanelState();
}

class _GithubRepoPanelState extends State<GithubRepoPanel> {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
      data: IconThemeData(size: 18,color: Theme.of(context).primaryColor),
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          // alignment: Alignment.topCenter,
          width: 250,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          decoration:  BoxDecoration(
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.1), offset: Offset(0, .5), blurRadius: 3)
              ],
              color:Theme.of(context).listTileTheme.tileColor,
              borderRadius: BorderRadius.circular(8)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                widget.repository.fullName!,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4,),
              Row(
                children: [
                  Text(
                    '创建时间',
                    style: const TextStyle(),
                  ),
                  const SizedBox(width: 8,),
                  Text(
                    '2020年04月15日',
                    style: const TextStyle(),
                  ),
                ],
              ),
              const SizedBox(height: 4,),
              Row(
                children: [
                  Text('开源协议'),
                  const SizedBox(width: 8,),
                  WrapColor(
                    padding: EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                    child: Text(
                      '${widget.repository.license?.type}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.repository.description!,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              const Divider(),
              const SizedBox(height: 8,),
              DefaultTextStyle(
                style: TextStyle(fontSize: 12,color: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Icons.star_border),
                          Text(widget.repository.stargazersCount.toString(),style: TextStyle(fontSize: 12),),
                        ]),
                    SizedBox(
                      height: 15,
                      child: VerticalDivider(
                        width: 1,
                        color: Theme.of(context).primaryColor,
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
                          Text(widget.repository.subscribersCount.toString(),style: TextStyle(fontSize: 12),),
                        ]),
                    SizedBox(
                      height: 15,
                      child: VerticalDivider(
                        width: 1,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(TolyIcon.icon_fork),
                          Text(widget.repository.forksCount.toString(),style: TextStyle(fontSize: 12),),
                        ]),
                    SizedBox(
                      height: 15,
                      child: VerticalDivider(
                        width: 1,
                        color: Theme.of(context).primaryColor,
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
                          Text(widget.repository.openIssuesCount.toString(),style: TextStyle(fontSize: 12),),
                        ]),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}