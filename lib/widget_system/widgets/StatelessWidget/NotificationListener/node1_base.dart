import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/8/14
/// contact me by email 1981462002@qq.com
/// 说明: NotificationListener 220 0 通知监听器 可指定Notification子泛型T,监听该类型的变化。Flutter内置很多滑动的Notification,当然你也可以自定义Notification进行监听。
//    {
//      "widgetId": 220,
//      "name": "监听OverscrollIndicatorNotification",
//      "priority": 1,
//      "subtitle":  "该通知之后在滑动到最顶和最底是回调，通过leading属性判断是顶部还是底部。另外通过notification#disallowGlow(),可以去除顶底滑动蓝色阴影",
//    }

class NotificationListenerDemo extends StatefulWidget {
  const NotificationListenerDemo({Key? key}) : super(key: key);

  @override
  _NotificationListenerDemoState createState() => _NotificationListenerDemoState();
}

class _NotificationListenerDemoState extends State<NotificationListenerDemo> {
  final List<String> data = List.generate(30, (i) => '第${i + 1}条');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: _onNotification,
          child: CupertinoScrollbar(
            child: ListView.separated(
              itemBuilder: _buildItem,
              itemCount: data.length,
              separatorBuilder: (_,__)=>const Divider(height: 5,),
            ),
          )),
    );
  }

  bool _onNotification(OverscrollIndicatorNotification notification) {
    if (notification.leading) {
      notification.disallowIndicator();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('已滑到顶部'),
        backgroundColor: Colors.blue,
        duration: Duration(milliseconds: 200),
      ));
    } else {
      notification.disallowIndicator();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('已滑到底部'),
        duration: Duration(milliseconds: 200),
        backgroundColor: Colors.blue,
      ));
    }

    return true;
  }

  Widget _buildItem(BuildContext context, int index) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      child: Text(data[index],style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18),),
    );
  }
}
