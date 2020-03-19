import 'package:flutter/material.dart';

class HomeFloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: ()=>_onPressed(context),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
  _onPressed(BuildContext context){
    showSnackBar(context);

  }

  showSnackBar(BuildContext context) {
    var snackBar = SnackBar(
        backgroundColor: Color(0xffFB6431),//颜色
        content: Text('Hello!'), //内容
        duration: Duration(seconds: 3), //持续时间
        action: SnackBarAction(
            label: '确定',
            onPressed: () {
              showModalBottom(context);
              print("Flutter Unit");
            }
        )
    );
    //弹出snackBar
    Scaffold.of(context).showSnackBar(snackBar);
  }
  showModalBottom(BuildContext context) {
    var content = Container(
      color: Color(0xdde3fbf6),
      height: 100,
      child: Center(
        child: Image.asset("assets/images/icon_flutter.png", width: 50,),),
    );
    showModalBottomSheet(
        context: context,
        builder: (context) => content)
        .then((val) {print("Closed");showBottomSheet(context);});
  }

  showBottomSheet(BuildContext context) {
    var content=Container(
      color: Color(0xdde3fbf6),
      height: 100,
      child: Center(
        child: Image.asset(
          "assets/images/icon_flutter.png",
          width: 50,),
      ),
    );
//弹出bottomSheet
    Scaffold.of(context).showBottomSheet(
            (context) => content);
  }
}
