import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app/res/cons.dart';

class IOSPage extends StatefulWidget {
  @override
  _IOSPageState createState() => _IOSPageState();
}

class _IOSPageState extends State<IOSPage> {
  var _position = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
          leading:Image.asset("assets/images/icon_head.png",width: 30,), //左
          middle: Text("Flutter Unit"), //中
          trailing: GestureDetector(
            onTap: (){
              _showDialogAbout(context);
            },
              child: Icon(CupertinoIcons.info,size: 25,
              )),
          backgroundColor: Color(0xfff1f1f1),
        ),
        body: CupertinoTabScaffold( tabBar: CupertinoTabBar(
          onTap: (index) {
            setState(() {
              _position = index;
            });
          },
          currentIndex: _position, //激活位置
          items: Cons.ICONS_MAP.keys
              .toList()
              .map((e) => //生成条目
          BottomNavigationBarItem(
            icon: Icon(
              Cons.ICONS_MAP[e],
            ),
            title: Text(e),
          ))
              .toList(),
          activeColor: Colors.blue, //激活颜色
          inactiveColor: Color(0xff333333), //非激活颜色
          backgroundColor: Color(0xfff1f1f1), //背景色
          iconSize: 25.0,
        ),
          tabBuilder: (context,index)=> CupertinoTabView(
            builder: (context) {
              switch (index) {
                case 0:
                  return Align(alignment: Alignment.topCenter,
                    child: CupertinoButton(  child: Text("Chose the language"),
                        onPressed: () {   _showSheetAction(context); }),);
                default:
                  return Align(alignment: Alignment(0, -0.8),
                      child: Text("${Cons.ICONS_MAP.keys.toList()[index]}")); }
            },
          ),
        ));
  }

  _showDialogAbout(BuildContext context){
    var title = Row(//标题
      children: <Widget>[Image.asset("assets/images/icon_head.png",
        width: 30, height: 30,),
        SizedBox(width: 10,),
        Text("关于")],);

    var content= Column(//内容
      mainAxisSize: MainAxisSize.min,
      children:<Widget>[
        Image.asset("assets/images/icon_flutter.png",width: 50,),
        SizedBox(height: 20,),
        Text("Flutter Unit V0.0.1",),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Power By GF·J·Toly",),
        )
      ],) ;

    showDialog(context: context, builder: (context)=>
        CupertinoAlertDialog(
      content: content,
      title: title,
      actions: <Widget>[
        CupertinoButton(
          child: Text("确定"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    ));
  }

  void _showSheetAction(BuildContext context) {
    showCupertinoModalPopup<int>(
        context: context,
        builder: (cxt) => CupertinoActionSheet(
            title: Text("Please chose a language"),
            message: Text('the language you use in this application.'),
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {Navigator.pop(cxt);},
                child: Text("Cancel")),
            actions: <Widget>[
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(cxt);
                  },
                  child: Text('Dart')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(cxt);
                  },
                  child: Text('Java')),
              CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(cxt);
                  },
                  child: Text('Kotlin')),     CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(cxt);
                  },
                  child: Text('Python')),     CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.pop(cxt);
                  },
                  child: Text('Swift')),
            ],
          ));
  }

}


