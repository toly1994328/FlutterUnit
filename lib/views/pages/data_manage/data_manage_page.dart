import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/api/category_api.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/repositories/itf/category_repository.dart';
import 'package:flutter_unit/user_system/component/authentic_widget.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

/// create by 张风捷特烈 on 2021/2/26
/// contact me by email 1981462002@qq.com
/// 说明:
///

class DataManagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据管理'),
      ),
      body: Builder(
        builder: (ctx) => ListView(
          children: <Widget>[
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
            AuthenticWidget.just(Divider()),
            AuthenticWidget.just(ListTile(
              trailing: Icon(
                TolyIcon.download,
                color: Theme.of(context).primaryColor,
              ),
              title: const Text('同步收藏集数据'),
              onTap: () => _doSync(ctx),
            )),
            AuthenticWidget.just(Divider()),
            ListTile(
              trailing: Icon(
                Icons.refresh,
                color: Theme.of(context).primaryColor,
              ),
              title: const Text('收藏集数据重置'),
              // trailing: _nextIcon(context),
              onTap: () => _recallDatabase(ctx),
            ),
            Divider(),
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
    BlocProvider.of<CategoryBloc>(context).add(EventLoadCategory());
    BlocProvider.of<LikeWidgetBloc>(context).add(EventLoadLikeData());
    Toast.toast(context, '重置成功!');
  }

  void _doUploadCategoryData(BuildContext context) async {
    CategoryRepository rep = BlocProvider.of<CategoryBloc>(context).repository;
    List<CategoryTo> loadCategories = await rep.loadCategoryData();
    List<dynamic> likeData = await rep.loadLikesData();

    String json = jsonEncode(loadCategories);
    String likeJson = jsonEncode(likeData);

    ResultBean<bool> result =
        await CategoryApi.uploadCategoryData(data: json, likeData: likeJson);

    if (result.status) {
      Toast.toast(context, '数据集备份成功!');
    } else {
      Toast.toast(context, '数据集备份失败!');
    }
  }

  void _doSync(BuildContext context) async {
    ResultBean<CategoryData> result = await CategoryApi.getCategoryData();

    if (result.status) {
      // 说明请求成功
      if (result.data != null) {
        //说明有后台备份数据，进行同步操作
        CategoryRepository repository =
            BlocProvider.of<CategoryBloc>(context).repository;
        await repository.syncCategoryByData(
            result.data.data, result.data.likeData);
        BlocProvider.of<CategoryBloc>(context).add(EventLoadCategory());
        BlocProvider.of<LikeWidgetBloc>(context).add(EventLoadLikeData());
      } else {
        // 说明还没有后台数据，
        // 这里防止有傻孩子没点备份，就点同步，哥哥好心，给备份一下。
        CategoryRepository rep =
            BlocProvider.of<CategoryBloc>(context).repository;
        List<CategoryTo> loadCategories = await rep.loadCategoryData();
        List<dynamic> likeData = await rep.loadLikesData();

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
