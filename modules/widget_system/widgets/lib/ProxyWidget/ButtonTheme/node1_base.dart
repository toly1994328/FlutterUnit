import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-12
/// contact me by email 1981462002@qq.com



class ButtonThemeDemo extends StatelessWidget {
  const ButtonThemeDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: Colors.orange,
      splashColor: Colors.blue,
      minWidth: 40,
      shape: const CircleBorder(
        side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
      ),
      child: Wrap(
        spacing: 10,
        children: <Widget>[
          ElevatedButton(onPressed: (){},child: const Icon(Icons.add)),
          TextButton(onPressed: (){},child: const Icon(Icons.add)),
          OutlinedButton(onPressed: (){},child: const Icon(Icons.add)),
          MaterialButton(onPressed: (){},child: const Icon(Icons.add)),
        ],
      ),
    );
  }
}