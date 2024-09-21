import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2020-03-23
/// contact me by email 1981462002@qq.com

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _position = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;
  final Map<String,IconData> iconsMap = { //底栏图标
    "图鉴": Icons.home, "动态": Icons.toys,
    "喜欢": Icons.favorite, "手册": Icons.class_,
    "我的": Icons.account_circle,
  };
  final List<Color> _colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        _buildOp(),
        _buildBottomNavigationBar(),
      ],
    );
  }

  bool get isShifting => _type == BottomNavigationBarType.shifting;

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      onTap: (position) => setState(() => _position = position),
      currentIndex: _position,
      elevation: 1,
      type: _type,
      fixedColor: isShifting ? Colors.white : _colors[_position],
      backgroundColor: Colors.white,
      iconSize: 25,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      showUnselectedLabels: false,
      showSelectedLabels: true,
      items: iconsMap.keys
          .map((key) => BottomNavigationBarItem(
              label:key,
              icon: Icon(iconsMap[key]),
              backgroundColor: _colors[_position]))
          .toList(),
    );
  }

  Widget _buildOp() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          _type.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
        ),
        Switch(
            value: _type == BottomNavigationBarType.shifting,
            onChanged: (b) {
              setState(() => _type = b
                  ? BottomNavigationBarType.shifting
                  : BottomNavigationBarType.fixed);
            }),
      ],
    );
  }
}
