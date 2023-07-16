import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refresh/refresh.dart';

import '../toly_refresh_indicator.dart';

class RefreshConfigWrapper extends StatelessWidget {
  final Widget child;
  const RefreshConfigWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    return RefreshConfiguration(
      headerTriggerDistance: 60,
      topHitBoundary: 20,
      child: child,
      headerBuilder: () => const TolyRefreshIndicator(),
      footerBuilder: () => CustomFooter(
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
    );
  }
}
