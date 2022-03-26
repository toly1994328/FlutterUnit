import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-22
/// contact me by email 1981462002@qq.com
/// 说明: 

class UnitDrawerHeader extends StatelessWidget {
  final Color color;


  const UnitDrawerHeader({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: const EdgeInsets.only(top: 10, left: 15),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/login_bg.png'),
            fit: BoxFit.cover),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Wrap(
            spacing: 10,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: const <Widget>[
              FlutterLogo(
                // colors: Colors.orange,
                size: 35,
              ),
              Text(
                'Flutter Unit',
                style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
                  Shadow(
                      color: Colors.black,
                      offset: Offset(1, 1),
                      blurRadius: 3)
                ]),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'The Unity Of Flutter, The Unity Of Coder.',
            style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
              Shadow(color: color, offset: const Offset(.5, .5), blurRadius: 1)
            ]),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Flutter的联合，编程者的联合。',
            style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
              Shadow(color: color, offset: const Offset(.5, .5), blurRadius: 1)
            ]),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: const [
              Spacer(
                flex: 5,
              ),
              Text(
                '—— 张风捷特烈',
                style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
                  Shadow(
                      color: Colors.orangeAccent,
                      offset: Offset(.5, .5),
                      blurRadius: 1)
                ]),
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
