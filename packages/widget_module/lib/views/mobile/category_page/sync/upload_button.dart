import 'dart:convert';

import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage/storage.dart';

import 'category_api.dart';
import 'package:utils/utils.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:toly_ui/toly_ui.dart';
import '../../../../data/exp.dart';



/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明:

class UploadCategoryButton extends StatefulWidget {
  const UploadCategoryButton({Key? key}) : super(key: key);

  @override
  _UploadCategoryButtonState createState() => _UploadCategoryButtonState();
}

enum AsyncType { loading, error, none, success }

class _UploadCategoryButtonState extends State<UploadCategoryButton> {
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
      size: 22,
      color: Colors.redAccent,
    );
  }

  Widget _buildDefault() {
    return FeedbackWidget(
        child: const Icon(
          TolyIcon.upload,
          size: 24,
        ),
        onPressed: _doUploadCategoryData);
  }

  void _doUploadCategoryData() async{
    setState(() => state = AsyncType.loading);

    CategoryRepository rep = BlocProvider.of<CategoryBloc>(context).repository;
    List<CategoryTo> loadCategories = await rep.loadCategoryData();
    List<int> likeData = await FlutterDbStorage.instance.likeDao.likeWidgetIds();


    String json = jsonEncode(loadCategories);
    String likeJson = jsonEncode(likeData);

    TaskResult<bool> result = await CategoryApi.uploadCategoryData(data: json,likeData: likeJson);

    if (result.success) {
      setState(() => state = AsyncType.success);
      _toDefault();
    } else {
      setState(() => state = AsyncType.error);
      _toDefault();
    }
  }

  Widget _buildSuccess() {
    return const Icon(
      TolyIcon.upload_success,
      size: 22,
      color: Colors.green,
    );
  }

  void _toDefault() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      state = AsyncType.none;
    });
  }
}
