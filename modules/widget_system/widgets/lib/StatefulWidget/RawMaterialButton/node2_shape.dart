import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class ShapeRawMaterialButton extends StatelessWidget {
  const ShapeRawMaterialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: [
        RawMaterialButton(
          elevation: 2,
          shape: const CircleBorder(
            side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
          ),
          fillColor: Colors.green,
          splashColor: Colors.orange,
          textStyle: const TextStyle(color: Colors.white),
          onLongPress: () => print('onLongPress'),
          child: const Icon(Icons.remove),
          onPressed: () => print('onPressed'),
        ),
        RawMaterialButton(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          elevation: 0,
          highlightElevation: 0,
          fillColor: Colors.blue,
          splashColor: Colors.orange,
          textStyle: const TextStyle(color: Colors.white),
          onLongPress: () => print('onLongPress'),
          child: const Text('Push'),
          onPressed: () => print('onPressed'),
        ),
        RawMaterialButton(
          elevation: 2,
          shape: const CircleBorder(
            side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
          ),
          fillColor: Colors.red,
          splashColor: Colors.orange,
          textStyle: const TextStyle(color: Colors.white),
          onLongPress: () => print('onLongPress'),
          child: const Icon(Icons.add),
          onPressed: () => print('onPressed'),
        ),
      ],
    );
  }
}