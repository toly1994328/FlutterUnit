import 'package:flutter/material.dart';



/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com


class TabPageSelectorIndicatorDemo extends StatelessWidget {
  const TabPageSelectorIndicatorDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:const [
        TabPageSelectorIndicator(
          backgroundColor: Colors.greenAccent,
          borderColor: Colors.deepPurpleAccent,
          size: 15,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.blue,
          borderColor: Colors.grey,
          size: 20,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.green,
          borderColor: Colors.red,
          size: 25,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.yellow,
          borderColor: Colors.brown,
          size: 30,
        ),
        TabPageSelectorIndicator(
          backgroundColor: Colors.amber,
          borderColor: Colors.purpleAccent,
          size: 35,
        ),
      ],
    );
  }

}

