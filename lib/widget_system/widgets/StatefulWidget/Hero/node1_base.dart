
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com
/// 说明:

//    {
//      "widgetId": 171,
//      "name": 'Hero基本使用',
//      "priority": 1,
//      "subtitle":
//          "【tag】 : 标签   【String】\n",
//    }
class CustomHero extends StatelessWidget {
  const CustomHero({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hero hero = Hero(
      //----定义一个Hero,并添加tag标签,此中组件共享
      tag: 'user-head',
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(30)),
        child: Image.asset(
          "assets/images/icon_head.webp",
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
      ),
    );

    Widget container = Container(
      alignment: const Alignment(-0.8, -0.8),
      child: hero,
      width: 250,
      height: 250 * 0.618,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.red.withAlpha(99),
        Colors.yellow.withAlpha(189),
        Colors.green.withAlpha(88),
        Colors.blue.withAlpha(230)
      ])),
    );

    return GestureDetector(
      child: Card(elevation: 5, child: container),
      onTap: () => Navigator.push(
        context,
        Bottom2TopRouter(child: const TargetPage(), duration: 1000),
      ),
    );
  }

}

class TargetPage extends StatelessWidget {
  const TargetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Hero hero = const Hero(
      //----定义一个Hero,为其添加标签，两个标签相同，则可以共享
      tag: 'user-head',
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage(
            "assets/images/icon_head.webp",
          ),
        ),
      ),
    );

    Widget touch = InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: hero,
    );

    return Scaffold(
      appBar: AppBar(
        actions: [touch],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          Colors.red.withAlpha(99),
          Colors.yellow.withAlpha(189),
          Colors.green.withAlpha(88),
          Colors.blue.withAlpha(230)
        ])),
      ),
    );
  }
}

//下--->上
class Bottom2TopRouter<T> extends PageRouteBuilder<T> {
  final Widget child;
  final int duration;
  final Curve curve;

  Bottom2TopRouter({
    required this.child,
    this.duration = 500,
    this.curve = Curves.fastOutSlowIn,
  }) : super(
            transitionDuration: Duration(milliseconds: duration),
            pageBuilder: (ctx, a1, a2) {
              return child;
            },
            transitionsBuilder: (
              ctx,
              a1,
              a2,
              Widget child,
            ) => SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: const Offset(0.0, 0.0),
                  ).animate(CurvedAnimation(parent: a1, curve: curve)),
                  child: child));
}
