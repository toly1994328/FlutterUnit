import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/api/category_api.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/model/category_model.dart';
import 'package:flutter_unit/repositories/itf/category_repository.dart';
import 'package:flutter_unit/user_system/component/authentic_widget.dart';
import 'package:flutter_unit/views/components/permanent/circle_image.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'category_page.dart';
import 'like_widget_page.dart';

class CollectPage extends StatefulWidget {
  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage>
    with AutomaticKeepAliveClientMixin {
  final _tabs = [
    '收藏集录',
    '珍藏组件',
  ];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    BuildContext _topContext = context;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color:
              BlocProvider.of<WidgetsBloc>(context).state.color.withAlpha(11),
          child: DefaultTabController(
            length: _tabs.length, // This is the number of tabs.
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
                SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: _buildAppBar(_topContext, innerBoxIsScrolled)),
              ],
              body: TabBarView(
                children: <Widget>[
                  CategoryPage(),
                  LikeWidgetPage(),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildAppBar(BuildContext context, bool index) {
    return SliverAppBar(
      leading: Container(
          margin: EdgeInsets.all(10),
          child: FeedbackWidget(
            onPressed: () {
              Navigator.of(context).pushNamed(UnitRouter.login);
            },
            child: CircleImage(
              image: AssetImage('assets/images/icon_head.webp'),
              borderSize: 1.5,
            ),
          )),
      backgroundColor: BlocProvider.of<WidgetsBloc>(context).state.color,
      actions: <Widget>[
        AuthenticWidget.just(SyncCategoryButton()),
        AuthenticWidget.just(_buildLoadAction(context)),
        _buildAddAction(context)
      ],
      title: Text(
        '收藏集 CollectUnit',
        style: TextStyle(
            color: Colors.white, //标题
            fontSize: 18,
            shadows: [
              Shadow(color: Colors.blue, offset: Offset(1, 1), blurRadius: 2)
            ]),
      ),
      pinned: true,
      expandedHeight: 150.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, //视差效果
        background: Image.asset(
          "assets/images/caver.webp",
          fit: BoxFit.cover,
        ),
      ),
      forceElevated: index,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: TabBar(
          indicatorColor: Colors.transparent,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.black,
          labelStyle: TextStyle(fontSize: 16, shadows: [
            Shadow(
                color: Theme.of(context).primaryColor,
                offset: Offset(1, 1),
                blurRadius: 10)
          ]),
          tabs: _tabs
              .map((String name) => Container(
                  margin: EdgeInsets.only(bottom: 5),
                  alignment: Alignment.center,
                  child: Text(name)))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildAddAction(BuildContext context) => IconButton(
      icon: const Icon(
        Icons.add,
        size: 30,
      ),
      onPressed: () => Scaffold.of(context).openEndDrawer());

  Widget _buildLoadAction(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: FeedbackWidget(
          child: Icon(
            TolyIcon.download,
            size: 28,
          ),
          onPressed: () async {
            final dir = await getExternalStorageDirectory();
            CategoryRepository rep =
                BlocProvider.of<CategoryBloc>(context).repository;
            List<CategoryTo> loadCategories = await rep.loadCategoryData();
            String json1 = jsonEncode(loadCategories);
            loadCategories.forEach((element) {
              print("${element.model.name} - ${element.widgetIds} ");
            });
            print(json1);
            File backFile = File(dir.path + "/back.txt");
            backFile.writeAsString(json1);
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class SyncCategoryButton extends StatefulWidget {
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
        onPressed: () async {
          CategoryRepository rep =
              BlocProvider.of<CategoryBloc>(context).repository;
          List<CategoryTo> loadCategories = await rep.loadCategoryData();
          String json = jsonEncode(loadCategories);
          setState(() {
            state = AsyncType.loading;
          });
          ResultBean<bool> result = await CategoryApi.uploadCategoryData(json);

          if (result.status) {
            setState(() {
              state = AsyncType.success;
            });
            _toDefault();
          } else {
            setState(() {
              state = AsyncType.error;
            });
          }
        });
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
