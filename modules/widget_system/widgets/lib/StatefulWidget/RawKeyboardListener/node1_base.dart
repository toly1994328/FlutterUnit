import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// create by 张风捷特烈 on 2020/9/21
/// contact me by email 1981462002@qq.com


class RawKeyboardListenerDemo extends StatefulWidget {
  const RawKeyboardListenerDemo({Key? key}) : super(key: key);

  @override
  _RawKeyboardListenerDemoState createState() => _RawKeyboardListenerDemoState();
}

class _RawKeyboardListenerDemoState extends State<RawKeyboardListenerDemo> {
  String _info = "";

  final FocusNode node = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: node,
      onKey: _onKey,
      child: SizedBox(
        width: 300,
        child: Row(
          children: [
            const Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Text(_info)
          ],
        ),
      ),
    );
  }

  void _onKey(RawKeyEvent value) {
    print(value);
    if(value is RawKeyDownEvent){
      _info = "按下: ${value.logicalKey.debugName}\nid: 0x${value.logicalKey.keyId.toRadixString(16).padLeft(9,"0")}";
    }
    if(value is RawKeyUpEvent){
      _info = "抬起: ${value.logicalKey.debugName}\nid: 0x${value.logicalKey.keyId.toRadixString(16).padLeft(9,"0")}";
    }
    setState(() {

    });
  }
}
