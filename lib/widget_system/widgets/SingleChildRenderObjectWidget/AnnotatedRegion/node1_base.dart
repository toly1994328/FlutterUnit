
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com
/// 说明: 288 AnnotatedRegion 有一个泛型，源码中仅适用该组件改变状态量、导航栏样式，泛型通常为SystemUiOverlayStyle。
//    {
//      "widgetId": 288,
//      "name": 'AnnotatedRegion改变状态量样式',
//      "priority": 1,
//      "subtitle":
//          "【value】 : 值   【T】\n"
//          "【sized】 : 是否提供大小   【bool】\n"
//          "【child】 : 子组件   【Widget】",
//    }


class AnnotatedRegionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => AnnotatedRegionTestPage()),
          );
        },
        child: Text("进入 AnnotatedRegion 测试页"),
      ),
    );
  }
}


class AnnotatedRegionTestPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final SystemUiOverlayStyle overlayStyle = SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.green,
      // 导航栏颜色
      systemNavigationBarDividerColor: Colors.red,
      statusBarColor: Colors.blue,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: overlayStyle,
        child: Scaffold(
          body: Container(
            child: Column(
              children: [
                Container(height: 56+30.0,color: Colors.blue,
                alignment: Alignment(0,0.55),
                child: Row(
                  children: [
                    BackButton(color: Colors.white,),
                    Text("AnnotatedRegion测试",style: TextStyle(color: Colors.white,fontSize: 18),)
                  ],
                ),
                ),
                SizedBox(height: 30,),
                Text(
                  "上面标题栏背景颜色为蓝色\n"
                      "上面标题栏图标为亮调",

                  style: TextStyle(color: Colors.black,fontSize: 18),),
                Spacer(),
                Text(
                      "下面导航栏背景颜色为绿色\n"
                      "下面导航栏图标为亮调",

                  style: TextStyle(color: Colors.black,fontSize: 18),),
                SizedBox(height: 30,),
              ],
            ),
          ),
      ),
    );
  }
}
