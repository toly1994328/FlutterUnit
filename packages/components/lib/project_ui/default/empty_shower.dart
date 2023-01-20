import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/17
/// contact me by email 1981462002@qq.com
/// 说明: 默认 数据为空视图

class EmptyShower extends StatelessWidget {
  final String message;

  const EmptyShower({Key? key, this.message = "数据为空"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;

    return Center(
      child: Container(
        alignment: FractionalOffset.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.style, color: color, size: 120.0),
            Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: color, fontSize: 18,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
