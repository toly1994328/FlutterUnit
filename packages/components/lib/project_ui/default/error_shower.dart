import 'package:flutter/material.dart';


/// create by 张风捷特烈 on 2020/11/17
/// contact me by email 1981462002@qq.com
/// 说明: 默认 错误视图

class ErrorShower extends StatelessWidget {
  final String error;

  const ErrorShower({Key? key, this.error = "出现异常"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10,
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const SizedBox(
              width: 80,
              height: 80,
              child: Icon(
                Icons.error,
                size: 80,
                color: Colors.red,
              )),
          Text(
            error,
            style:TextStyle(
              color: Colors.red, fontSize: 18,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
