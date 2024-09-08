import 'dart:io';

import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:toly_ui/toly_ui.dart';

import 'package:widget_module/blocs/blocs.dart';

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
      color: UnitColor.warning_color.withOpacity(0.3),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
            spacing: 5,
            children: [
              const Text(
                "  您还没有收藏集! ",
                style: TextStyle(fontSize: 18,color: UnitColor.head_text_color),
              ),
              const SizedBox(
                width: 10,
              ),
              FeedbackWidget(
                onPressed: ()=>_recallDatabase(context),
                child: const Icon(
                  Icons.refresh,
                  textDirection: TextDirection.rtl,
                  color: Colors.blue,
                  size: 36,
                ),
              ),
              const Text(
                "恢复默认",
                style: TextStyle(fontSize: 14,color: UnitColor.input_hit_text_color),
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
    BlocProvider.of<CategoryBloc>(context).add(const EventLoadCategory());
  }
}
