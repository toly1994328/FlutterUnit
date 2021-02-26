import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/api/category_api.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';
import 'package:flutter_unit/blocs/category/category_bloc.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/repositories/itf/category_repository.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';

/// create by 张风捷特烈 on 2021/2/24
/// contact me by email 1981462002@qq.com
/// 说明:

class UploadCategoryButton extends StatefulWidget {
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
      size: 28,
      color: Colors.green,
    );
  }

  Widget _buildDefault() {
    return FeedbackWidget(
        child: const Icon(
          TolyIcon.upload,
          size: 28,
        ),
        onPressed: _doUploadCategoryData);
  }

  void _doUploadCategoryData() async{
    setState(() => state = AsyncType.loading);

    CategoryRepository rep = BlocProvider.of<CategoryBloc>(context).repository;
    List<CategoryTo> loadCategories = await rep.loadCategoryData();
    List<dynamic> likeData = await rep.loadLikesData();

    String json = jsonEncode(loadCategories);
    String likeJson = jsonEncode(likeData);

    ResultBean<bool> result = await CategoryApi.uploadCategoryData(data: json,likeData: likeJson);

    if (result.status) {
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
      size: 25,
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
