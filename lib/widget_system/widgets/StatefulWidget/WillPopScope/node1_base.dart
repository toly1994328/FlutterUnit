import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:


//    {
//      "widgetId": 170,
//      "name": 'WillPopScope使用',
//      "priority": 1,
//      "subtitle": "【child】 : 子组件   【Widget】\n"
//          "【onWillPop】 : 返回回调  【WillPopCallback】",
//    }
class CustomWillPopScope extends StatelessWidget {
  const CustomWillPopScope({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: const BackButton(),
      onWillPop: () => _willPop(context),
    );
  }

  Future<bool> _willPop(context) async {
    bool? exit = await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: const Text('提示'),
            content: const Text('你确定要离开此页吗?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(true),
                child: const Text('确定'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(false),
                child: const Text('取消'),
              ),
            ],
          ),
        );
    print('====_willPop==:$exit========');

    return exit??false;
  }
}
