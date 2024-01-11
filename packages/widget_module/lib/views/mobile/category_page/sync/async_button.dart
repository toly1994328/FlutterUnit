import 'dart:convert';

import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'category_api.dart';
import 'package:utils/utils.dart';
import 'package:widget_module/blocs/blocs.dart';

import 'package:storage/storage.dart';
import '../../../../data/exp.dart';


import 'package:toly_ui/toly_ui.dart';


/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明: 同步数据按钮，点击时请求服务器，获取备份数据。

class SyncCategoryButton extends StatefulWidget {
  const SyncCategoryButton({Key? key}) : super(key: key);

  @override
  _SyncCategoryButtonState createState() => _SyncCategoryButtonState();
}

enum AsyncType { loading, error, none, success }

class _SyncCategoryButtonState extends State<SyncCategoryButton> {
  AsyncType state = AsyncType.none;

  @override
  Widget build(BuildContext context) {
    Widget result;
    switch (state) {
      case AsyncType.loading:
        result = _buildLoading();
        break;
      case AsyncType.error:
        result = _buildError();
        break;
      case AsyncType.none:
        result = _buildDefault();
        break;
      case AsyncType.success:
        result = _buildSuccess();
        break;
    }
    return result;
  }

  Widget _buildLoading() {
    return const CupertinoActivityIndicator();
  }

  Widget _buildError() {
    return const Icon(
      TolyIcon.error,
      size: 25,
      color: Colors.red,
    );
  }

  Widget _buildDefault() {
    return FeedbackWidget(
        child: const Icon(
          TolyIcon.download,
          size: 24,
        ),
        onPressed: _doSync);
  }

  void _doSync() async {
    setState(() => state = AsyncType.loading);
    TaskResult<CategoryData> result = await CategoryApi.getCategoryData();

    if (result.success) {
      // 说明请求成功
      if (result.data != null) {
        //说明有后台备份数据，进行同步操作
        CategoryRepository repository = BlocProvider.of<CategoryBloc>(context).repository;
        await repository.syncCategoryByData(result.data!.data,result.data!.likeData);
        BlocProvider.of<CategoryBloc>(context).add(const EventLoadCategory());
        BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
      } else {
        // 说明还没有后台数据，
        // 这里防止有傻孩子没点备份，就点同步，哥哥好心，给备份一下。
        CategoryRepository rep = BlocProvider.of<CategoryBloc>(context).repository;
        List<CategoryTo> loadCategories = await rep.loadCategoryData();
        List<int> likeData = await FlutterDbStorage.instance.likeDao.likeWidgetIds();

        String json = jsonEncode(loadCategories);
        String likeJson = jsonEncode(likeData);
        await CategoryApi.uploadCategoryData(data: json,likeData: likeJson);
      }
      setState(() => state = AsyncType.success);
      _toDefault();
    } else {
      setState(() => state = AsyncType.error);
      _toDefault();
    }
  }

  Widget _buildSuccess() => const Icon(
        TolyIcon.upload_success,
        size: 22,
        color: Colors.green,
      );

  void _toDefault() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      state = AsyncType.none;
    });
  }
}
