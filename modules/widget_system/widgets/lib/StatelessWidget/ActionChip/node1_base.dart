
/// create by 张风捷特烈 on 2020/4/25
/// contact me by email 1981462002@qq.com

///


import 'package:flutter/material.dart';
import 'package:widgets/utils/dialog_about.dart';


class CustomActionChip extends StatelessWidget {
  const CustomActionChip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      padding: const EdgeInsets.all(5),
      labelPadding: const EdgeInsets.all(3),
      label: const Text("This is a ActionChip."),
      backgroundColor: Colors.grey.withAlpha(66),
      avatar: Image.asset("assets/images/icon_head.webp"),
      shadowColor: Colors.orangeAccent,
      elevation: 3,
      pressElevation: 5,
      onPressed: ()=> DialogAbout.show(context),
    );
  }
}
