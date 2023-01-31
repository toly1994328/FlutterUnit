
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// create by 张风捷特烈 on 2020/10/24
/// contact me by email 1981462002@qq.com
/// 说明:  默认 加载视图

class LoadingShower extends StatelessWidget {

  const LoadingShower({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10,
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
              width: 80,
              height: 80,
              child: SpinKitFadingCube(color: Theme.of(context).primaryColor)),
          const Text("loading ...",style: TextStyle(
              color: Color(0xff939EA7),
              fontSize: 13),)
        ],
      ),
    );
  }


}
