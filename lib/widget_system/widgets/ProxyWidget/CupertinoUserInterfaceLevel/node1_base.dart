import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明: 337 CupertinoUserInterfaceLevel 用户接口等级
/// ios 中的概念，内容可视级别 UIUserInterfaceLevel ，分为 base 和 elevated。作为一个 InheritedWidget ，主要就是共享该数据。

//    {
//      "widgetId": 337,
//      "name": 'CupertinoUserInterfaceLevel 介绍',
//      "priority": 1,
//      "subtitle": "CupertinoUserInterfaceLevel.of(context) 可以获取 CupertinoUserInterfaceLevelData 数据。也可以使用该组件设置该数据与子树共享。关于数据原图详见:  https://developer.apple.com/documentation/uikit/uiuserinterfacelevel",
//    }

class CupertinoUserInterfaceLevelDemo extends StatelessWidget {
  const CupertinoUserInterfaceLevelDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoUserInterfaceLevel(
      data: CupertinoUserInterfaceLevelData.elevated,
      child: LevelShower()
    );
  }

}

class LevelShower extends StatelessWidget {
  const LevelShower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CupertinoUserInterfaceLevelData data = CupertinoUserInterfaceLevel.of(context);
    return Container(
      height: 150,
      alignment: Alignment.center,
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Text(data.toString()),
    );
  }
}


