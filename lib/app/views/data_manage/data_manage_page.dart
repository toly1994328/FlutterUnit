import 'dart:convert';
import 'dart:io';
import 'package:app/app.dart';
import 'package:artifact/artifact.dart';
import 'package:l10n/l10n.dart';
import 'package:storage/storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import 'package:authentication/views/authentic_widget.dart';
import 'package:utils/utils.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:widget_module/widget_module.dart';


/// create by 张风捷特烈 on 2021/2/26
/// contact me by email 1981462002@qq.com
/// 说明:
///

class DataManagePage extends StatelessWidget {
  const DataManagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(context.l10n.dataManagement),
      ),
      body: Builder(
        builder: (ctx) => ListView(
          children: <Widget>[
            const SizedBox(height: 8,),
            AuthenticWidget.just(
              ListTile(
                trailing: Icon(
                  TolyIcon.upload,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text('备份收藏集数据'),
                onTap: () => _doUploadCategoryData(ctx),
              ),
            ),
            AuthenticWidget.just(const Divider()),
            AuthenticWidget.just(ListTile(
              trailing: Icon(
                TolyIcon.download,
                color: Theme.of(context).primaryColor,
              ),
              title: const Text('同步收藏集数据'),
              onTap: () => _doSync(ctx),
            )),
            AuthenticWidget.just(const Divider()),
            ListTile(
              trailing: Icon(
                Icons.refresh,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(context.l10n.favoritesCollectionDataReset),
              // trailing: _nextIcon(context),
              onTap: () => _recallDatabase(ctx),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  _recallDatabase(BuildContext context) async {
    String databasesPath = await getDatabasesPath();
    String dbPath = path.join(databasesPath, "flutter.db");
    ByteData data = await rootBundle.load(path.join("assets", "flutter.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes, flush: true);
    print("==== debug ===== assets ======拷贝完成====");
    BlocProvider.of<CategoryBloc>(context).add(const EventLoadCategory());
    BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    Toast.toast(context, '重置成功!');
  }

  void _doUploadCategoryData(BuildContext context) async {
    CategoryRepository rep = BlocProvider.of<CategoryBloc>(context).repository;
    List<CategoryTo> loadCategories = await rep.loadCategoryData();

    List<int> likeData = await FlutterDbStorage.instance.likeDao.likeWidgetIds();

    String json = jsonEncode(loadCategories);
    String likeJson = jsonEncode(likeData);

    TaskResult<bool> result =
        await CategoryApi.uploadCategoryData(data: json, likeData: likeJson);

    if (result.success) {
      Toast.toast(context, '数据集备份成功!');
    } else {
      Toast.toast(context, '数据集备份失败!');
    }
  }

  void _doSync(BuildContext context) async {
    TaskResult<CategoryData> result = await CategoryApi.getCategoryData();

    if (result.success) {
      // 说明请求成功
      if (result.data != null) {
        //说明有后台备份数据，进行同步操作
        CategoryRepository repository =
            BlocProvider.of<CategoryBloc>(context).repository;
        await repository.syncCategoryByData(
            result.data!.data, result.data!.likeData);
        BlocProvider.of<CategoryBloc>(context).add(const EventLoadCategory());
        BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
      } else {
        // 说明还没有后台数据，
        // 这里防止有傻孩子没点备份，就点同步，哥哥好心，给备份一下。
        CategoryRepository rep =
            BlocProvider.of<CategoryBloc>(context).repository;
        List<CategoryTo> loadCategories = await rep.loadCategoryData();
        List<int> likeData = await FlutterDbStorage.instance.likeDao.likeWidgetIds();

        String json = jsonEncode(loadCategories);
        String likeJson = jsonEncode(likeData);
        await CategoryApi.uploadCategoryData(data: json, likeData: likeJson);
      }
      Toast.toast(context, '数据同步份成功!');
    } else {
      Toast.toast(context, '数据同步份失败!');
    }
  }
}

// class LoadingIndicate extends StatefulWidget {
//   Future<void> Function task;
//   @override
//   _LoadingIndicateState createState() => _LoadingIndicateState();
// }
//
// class _LoadingIndicateState extends State<LoadingIndicate> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
