import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com

class CustomListTile extends StatelessWidget {
  const CustomListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      color: Colors.grey.withAlpha(22),
      child: ListTile(
        leading: Image.asset("assets/images/icon_head.webp"),
        title: const Text("以梦为马"),
        subtitle: const Text("海子"),
        contentPadding: const EdgeInsets.all(5),
        trailing: const Icon(Icons.more_vert),
        onLongPress: () => Navigator.of(context).pushNamed('AboutMePage'),
      ),
    );
  }
}