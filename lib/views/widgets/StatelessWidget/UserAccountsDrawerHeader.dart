import 'package:flutter/material.dart';

class CustomUAGHP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 * 2,
      child: UserAccountsDrawerHeader(
        accountName: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "张风捷特烈",
            style:
                TextStyle(color: Colors.orangeAccent, fontSize: 22, shadows: [
              Shadow(
                  color: Colors.black, offset: Offset(.5, .5), blurRadius: 2),
            ]),
          ),
        ),
        accountEmail: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("1981462002@qq.com",
              style: TextStyle(color: Colors.white, fontSize: 14, shadows: [
                Shadow(
                    color: Colors.orangeAccent,
                    offset: Offset(.5, .5),
                    blurRadius: 2),
              ])),
        ),
        currentAccountPicture: Container(
          padding: const EdgeInsets.all(15.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon_head.png"),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/caver.jpeg")),
        ),
      ),
    );
  }
}

class ProUAGHP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3 * 2,
      child: UserAccountsDrawerHeader(
        margin: EdgeInsets.all(10),
        accountName: Container(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "张风捷特烈",
            style:
                TextStyle(color: Colors.orangeAccent, fontSize: 22,
                    shadows: [
              Shadow(
                  color: Colors.black,
                  offset: Offset(.5, .5),
                  blurRadius: 2),
            ]),
          ),
        ),
        accountEmail: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("1981462002@qq.com",
              style: TextStyle(
                  color: Colors.white, fontSize: 14,
                  shadows: [
                Shadow(
                    color: Colors.orangeAccent,
                    offset: Offset(.5, .5),
                    blurRadius: 2),
              ])),
        ),
        currentAccountPicture: Container(
          padding: const EdgeInsets.all(15.0),
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/images/icon_head.png"),
          ),
        ),
        otherAccountsPictures: <Widget>[
          FlutterLogo(colors: Colors.green),
        ],
        onDetailsPressed: () {

        },
        arrowColor: Colors.white,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/caver.jpeg")),
        ),
      ),
    );
  }
}
