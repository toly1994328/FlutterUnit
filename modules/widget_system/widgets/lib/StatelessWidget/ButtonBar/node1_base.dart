/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com


import 'package:flutter/material.dart';
import 'package:widgets/utils/dialog_about.dart';


class CustomButtonBar extends StatelessWidget {
  const CustomButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        ElevatedButton(
            child: const Text("ElevatedButton"),
            onPressed: () => DialogAbout.show(context)),
        OutlinedButton(
            child: const Text("Outlined"),
            onPressed: () => DialogAbout.show(context)),
        TextButton(
          onPressed: () => DialogAbout.show(context),
          child: const Text("TextButton"),
        )
      ],
    );
  }
}

