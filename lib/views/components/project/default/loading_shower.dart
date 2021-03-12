import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_unit/app/res/style_unit.dart';

/// create by 张风捷特烈 on 2020/10/24
/// contact me by email 1981462002@qq.com
/// 说明:  默认 加载视图

class LoadingShower extends StatelessWidget {
 const LoadingShower({Key key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        spacing: 10,
        direction: Axis.vertical,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
              width: 80,
              height: 80,
              child: SpinKitFadingCube(color: Theme.of(context).primaryColor)),
          Text("loading ...",style: TextStyleUnit.hintStyle,)
        ],
      ),
    );
  }


}
