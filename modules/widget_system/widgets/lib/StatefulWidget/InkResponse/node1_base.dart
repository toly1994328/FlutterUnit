import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-25
/// contact me by email 1981462002@qq.com


class CustomInkResponse extends StatefulWidget {
  const CustomInkResponse({Key? key}) : super(key: key);

  @override
  _CustomInkResponseState createState() => _CustomInkResponseState();
}

class _CustomInkResponseState extends State<CustomInkResponse> {
  String _info = 'Push';

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () => setState(() => _info = 'onTap'),
      onDoubleTap: () => setState(() => _info = 'onDoubleTap'),
      onLongPress: () => setState(() => _info = 'onLongPress'),
      onTapCancel: () => setState(() => _info = 'onTapCancel'),
      child: Container(
        alignment: Alignment.center,
        width: 200,
        height: 100,
        child: Text(_info),
      ),
    );
  }
}