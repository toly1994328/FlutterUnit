import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/14
/// contact me by email 1981462002@qq.com


class NotificationListenerUpdate extends StatefulWidget {
  const NotificationListenerUpdate({Key? key}) : super(key: key);

  @override
  _NotificationListenerUpdateState createState() =>
      _NotificationListenerUpdateState();
}

class _NotificationListenerUpdateState
    extends State<NotificationListenerUpdate> {
  final List<String> data = List.generate(30, (i) => '第${i + 1}条');

  String _info = '';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Positioned(
              child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(_info),
          )),
          NotificationListener<ScrollUpdateNotification>(
              onNotification: _onNotification,
              child: CupertinoScrollbar(
                child: ListView.separated(
                  itemBuilder: _buildItem,
                  itemCount: data.length,
                  separatorBuilder: (_, __) => const Divider(height: 5),
                ),
              )),

        ],
      ),
    );
  }

  bool _onNotification(ScrollUpdateNotification notification) {
    setState(() {
      _info = 'axis------【${notification.metrics.axis}】------\n'
          'pixels------【${notification.metrics.pixels}】------\n'
          'atEdge------【${notification.metrics.atEdge}】------\n'
          'axisDirection------【${notification.metrics.axisDirection}】------\n'
          'extentInside------【${notification.metrics.extentInside}】------\n'
          'outOfRange------【${notification.metrics.outOfRange}】------\n'
          'minScrollExtent------【${notification.metrics.minScrollExtent}】------\n'
          'maxScrollExtent------【${notification.metrics.maxScrollExtent}】------\n'
          'viewportDimension------【${notification.metrics.viewportDimension}】------\n'
          'delta------【${notification.dragDetails?.delta}】------\n'
          'globalPosition------【${notification.dragDetails?.globalPosition}】------\n'
          'localPosition------【${notification.dragDetails?.localPosition}】------\n'
          'scrollDelta------【${notification.scrollDelta}】------\n'
          'depth------【${notification.depth}】------';
    });
    return true;
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      height: 50,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 8),
      child: Text(
        data[index],
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 18),
      ),
    );
  }
}
