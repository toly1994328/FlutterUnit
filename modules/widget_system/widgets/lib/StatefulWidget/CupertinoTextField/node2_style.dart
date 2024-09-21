import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/7/22
/// contact me by email 1981462002@qq.com

class CupertinoTextFieldStyle extends StatelessWidget {
  const CupertinoTextFieldStyle({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return const CupertinoTextField(
      style: TextStyle(color: Colors.blue),
      prefix: Icon(CupertinoIcons.add),
      prefixMode: OverlayVisibilityMode.notEditing,
      suffix: Icon(CupertinoIcons.clear),
      suffixMode: OverlayVisibilityMode.editing,
      cursorColor: Colors.purple,
      cursorWidth: 4,
      cursorRadius: Radius.circular(2),
      readOnly: false,
      placeholder: '输入用户名',
    );
  }
}
