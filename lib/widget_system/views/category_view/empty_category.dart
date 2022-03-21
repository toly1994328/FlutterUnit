import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/color_unit.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/permanent/panel.dart';
import 'package:flutter_unit/widget_system/blocs/widget_system_bloc.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

/// create by 张风捷特烈 on 2021/2/25
/// contact me by email 1981462002@qq.com
/// 说明:

class EmptyCategory extends StatelessWidget {

  const EmptyCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Panel(
      radius: 15,
      color: ColorUnit.warning_color.withOpacity(0.3),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
            spacing: 5,
            children: [
              const Text(
                "  您还没有收藏集! ",
                style: TextStyle(fontSize: 18,color: ColorUnit.head_text_color),
              ),
              SizedBox(
                width: 10,
              ),
              FeedbackWidget(
                onPressed: ()=>_recallDatabase(context),
                child: Icon(
                  Icons.refresh,
                  textDirection: TextDirection.rtl,
                  color: Colors.blue,
                  size: 36,
                ),
              ),
              const Text(
                "恢复默认",
                style: TextStyle(fontSize: 14,color: ColorUnit.input_hit_text_color),
              ),
            ],
          ),
        ));
  }

  _recallDatabase(BuildContext context) async{
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, "flutter.db");
    ByteData data = await rootBundle.load(path.join("assets", "flutter.db"));
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes, flush: true);
    BlocProvider.of<CategoryBloc>(context).add(EventLoadCategory());
  }
}
