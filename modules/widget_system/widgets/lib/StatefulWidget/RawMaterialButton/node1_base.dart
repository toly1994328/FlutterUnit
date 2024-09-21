import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020-03-29
/// contact me by email 1981462002@qq.com

class CustomRawMaterialButton extends StatelessWidget {
  const CustomRawMaterialButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: [
        RawMaterialButton(
          elevation: 2,
          fillColor: Colors.green,
          splashColor: Colors.orange,
          textStyle: const TextStyle(color: Colors.white),
          onLongPress: ()=>print('onLongPress'),
          child: const Icon(Icons.remove),
          onPressed: ()=>print('onPressed'),
        ),
        RawMaterialButton(
          elevation: 2,
          fillColor: Colors.blue,
          splashColor: Colors.orange,
          textStyle: const TextStyle(color: Colors.white),
          onLongPress: ()=>print('onLongPress'),
          child: const Text('Push'),
          onPressed: ()=>print('onPressed'),
        ),
        RawMaterialButton(
          elevation: 2,
          fillColor: Colors.red,
          splashColor: Colors.orange,
          textStyle: const TextStyle(color: Colors.white),
          onLongPress: ()=>print('onLongPress'),
          child: const Icon(Icons.add),
          onPressed: ()=>print('onPressed'),
        ),

      ],
    );
  }
}