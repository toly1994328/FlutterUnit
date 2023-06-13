import 'package:app/app.dart';
import 'package:flutter/material.dart';

class DialogAbout extends StatelessWidget {
  const DialogAbout({Key? key}) : super(key: key);

  static show(BuildContext context){
    showDialog(//内置方法，创建对话弹框
        context: context,
        builder: (_) => const DialogAbout());
  }
  @override
  Widget build(BuildContext context) {
    Widget title = Row(
      //标题
      children: <Widget>[
        Image.asset(
          "assets/images/icon_head.webp",
          width: 30,
          height: 30,
        ),
        const SizedBox(
          width: 10,
        ),
        const Expanded(child: Text("关于",style: TextStyle(fontSize: 18),)),
        InkWell(
          child: const Icon(Icons.close),
          onTap: ()=>Navigator.of(context).pop(),
        )
      ],
    );
    Widget content = Column(
        //内容
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
//          Image.asset(
//            "assets/images/icon_flutter.png",
//            width: 50,
//          ),
          FlutterLogo(size: 50,),
          SizedBox(
            height: 20,
          ),
          Text(
            "Flutter Unit ${StrUnit.version}",
          ),
        ]);
    return AlertDialog(title: title, content: content, actions: <Widget>[
      //左下角
      Padding(
          padding: const EdgeInsets.only(right:15.0,bottom: 10,top: 10),
          child: Column(
            children: const[
               Text(
                "Power By GF·J·Toly\n张风捷特烈",
                textAlign: TextAlign.center,
              ),
            ],
          ))
    ]);
  }
}
