import 'package:flutter/material.dart';
import '../../StatelessWidget/RadioListTile/node1_base.dart';
/// create by 张风捷特烈 on 2020/4/30
/// contact me by email 1981462002@qq.com

class CustomExpansionTile extends StatefulWidget {
  const CustomExpansionTile({Key? key}) : super(key: key);

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: const Icon(Icons.star),
      title: const Text("选择语言"),
      backgroundColor: Colors.grey.withAlpha(6),
      onExpansionChanged: (value) {
        print('$value');
      },
      initiallyExpanded: false,
      children: const[CustomRadioListTile()],
    );
  }
}
