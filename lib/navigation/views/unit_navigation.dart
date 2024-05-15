import 'dart:io';

import 'package:app_update/app_update.dart';
import 'package:artifact/artifact.dart';
import 'package:authentication/authentication.dart';
import 'package:draw_system/draw_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/widget_module.dart';


import '../../navigation/views/pure_bottom_bar.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 主题结构 左右滑页 + 底部导航栏

class UnitPhoneNavigation extends StatefulWidget {
  const UnitPhoneNavigation({Key? key}) : super(key: key);

  @override
  _UnitPhoneNavigationState createState() => _UnitPhoneNavigationState();
}

class _UnitPhoneNavigationState extends State<UnitPhoneNavigation> {
  //页面控制器，初始 0
  final PageController _controller = PageController();
  int position = 0;

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid||Platform.isIOS) {
    }
    BlocProvider.of<UpdateBloc>(context).add(const CheckUpdate(appName: 'FlutterUnit'));

  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    super.dispose();
  }

  /// extendBody = true 凹嵌透明，需要处理底部 边距
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      endDrawer: const HomeRightDrawer(),
      body: PageView(
        physics: _neverScroll,
        controller: _controller,
        children: [
          StandardHomePage(),
          GalleryUnit(),
          ArtifactPage(),
          CollectPageAdapter(),
          UserPage(),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(context),
    );
  }

  bool get isDark => Theme.of(context).brightness == Brightness.dark;


  // 由于 bottomNavigationBar 颜色需要随 点击头部栏 状态而改变，
  // 使用 BlocBuilder 构建
  Widget _buildBottomNav(BuildContext context) {
    return Stack(
      children: [
        PureBottomBar(
          initPosition: position,
          onItemTap: _onTapBottomNav,
          onItemLongTap: _onItemLongTap,
        ),
        const Positioned(right: 22, top: 8, child: UpdateRedPoint())
      ],
    );
  }

  // 点击底部按钮事件，切换页面
  void _onTapBottomNav(int index) {
    _controller.jumpToPage(index);
    position = index;
    if (!isDark) {
      late Color color;
      if (index != 0) {
        color = Theme.of(context).primaryColor;
      } else {
      }
    }

    if (index == 3) {
      BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    }
  }

  // 两侧
  void _onItemLongTap(BuildContext context, int index) {
    if (index == 0) {
      Scaffold.of(context).openDrawer();
    }
    if (index == 4) {
      Scaffold.of(context).openEndDrawer();
    }
  }
}
