

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com
/// 说明:
import 'package:flutter/material.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  bool opened = false;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        color: Colors.blue,
        onPressed: () {
          opened = !opened;
          opened
              ? Scaffold.of(context).showBottomSheet((_) => _buildBottomSheet())
              : Navigator.of(context).pop();
        },
        child: const Text(
          '点我显隐BottomSheet',
          style: TextStyle(color: Colors.white),
        ));
  }

  Widget _buildBottomSheet() => BottomSheet(
      enableDrag: true,
      elevation: 4,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topRight: Radius.circular(60),
        topLeft: Radius.circular(60),
      )),
      backgroundColor: Colors.transparent,
      onClosing: () => print('onClosing'),
      builder: (_) => (Container(
        height: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/sabar_bar.webp'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(60),
                  topLeft: Radius.circular(60),
                )),
          )));
}
