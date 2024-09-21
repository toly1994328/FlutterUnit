import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com

class AnimatedThemeDemo extends StatefulWidget {
  const AnimatedThemeDemo({Key? key}) : super(key: key);

  @override
  _AnimatedThemeDemoState createState() => _AnimatedThemeDemoState();
}

class _AnimatedThemeDemoState extends State<AnimatedThemeDemo> {
  ThemeData startThem = ThemeData(
      primaryColor: Colors.blue,
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ));

  ThemeData endThem = ThemeData(
      primaryColor: Colors.red,
      textTheme: const TextTheme(
          headlineMedium: TextStyle(
        color: Colors.black,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      )));

  late ThemeData them;

  @override
  void initState() {
    super.initState();
    them = startThem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildSwitch(),
        AnimatedTheme(
          data: them,
          duration: const Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
          onEnd: () {
            print('----onEnd---');
          },
          child: const ChildContent(),
        ),
      ],
    );
  }

  Widget _buildSwitch() {
    print(them == endThem);
    return Switch(
        value: them == endThem,
        onChanged: (v) {
          setState(() {
            them = v ? endThem : startThem;
          });
        });
  }
}

class ChildContent extends StatelessWidget {
  const ChildContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        color: Theme.of(context).primaryColor,
      ),
      padding: const EdgeInsets.all(10),
      child: Text(
        'Flutter Unit',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}
