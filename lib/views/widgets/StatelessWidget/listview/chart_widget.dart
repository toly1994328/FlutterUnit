import 'package:flutter/material.dart';

import 'circle_image.dart';



class NinePointBox extends StatelessWidget {
  final ImageProvider image;
  final Widget child;
  final Rect sliceRect;
  final double maxWith;
  final EdgeInsetsGeometry padding;

  NinePointBox(
      {Key key,
      @required this.image,
      this.child,
      @required this.sliceRect,
      this.maxWith = 280,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          centerSlice: this.sliceRect,
          image: image,
        ),
      ),
      constraints: BoxConstraints(maxWidth: this.maxWith),
      padding: padding,
      child: child,
    );
  }
}

enum ChartType { right, left }//组件的类型

class ChatItem {//组件信息描述类
  ImageProvider headIcon;//头像
  double maxWith;//最大宽
  ChartType type;//组件的类型
  String text;//文字信息

  ChatItem(
      {this.headIcon,
        this.text,
        this.maxWith = 280,
        this.type = ChartType.right});
}

class ChatWidget extends StatelessWidget {
  final ChatItem chartItem;

  ChatWidget({Key key, this.chartItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isRight=chartItem.type==ChartType.right;//是否是右侧
    var head = Padding(//头像
      padding: EdgeInsets.only(left: 10, right: 10,),
      child: CircleImage(image: chartItem.headIcon,),
    );

    var rightBox = NinePointBox(//绿色对话框
      sliceRect: Rect.fromLTRB(6, 28, 60, 29),
      padding: EdgeInsets.fromLTRB(15, 10, 20, 10.0),
      image: AssetImage('assets/images/right_chat.png',),
      child: Text(chartItem.text,
        style: TextStyle(fontSize: 15.0),
      ),
    );

    var leftBox = NinePointBox(//白色对话框
      sliceRect: Rect.fromLTRB(14, 27, 69, 28),
      padding: EdgeInsets.fromLTRB(20, 10, 10, 10),
      image: AssetImage('assets/images/left_chat.png',),
      child: Text(chartItem.text,
        style: TextStyle(fontSize: 15.0),
      ),
    );

    return Container(//根据左右来构建组件
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: isRight?MainAxisAlignment.end:MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[if(isRight)rightBox, head,if(!isRight)leftBox],
      ),
    );
  }
}

