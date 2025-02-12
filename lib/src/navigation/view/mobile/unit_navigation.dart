import 'dart:io';

import 'package:algorithm/algorithm.dart';
import 'package:app/app.dart';
import 'package:app_update/app_update.dart';
import 'package:artifact/artifact.dart';
import 'package:authentication/authentication.dart';
import 'package:draw_system/draw_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/src/navigation/model/app_tab.dart';
import 'package:treasure_tools/treasure_tools.dart';
import 'package:widget_module/blocs/blocs.dart';
import 'package:widget_module/widget_module.dart';
import 'package:note/note.dart';
import 'pure_bottom_bar.dart';

/// create by 张风捷特烈 on 2020-04-11
/// contact me by email 1981462002@qq.com
/// 说明: 主题结构 左右滑页 + 底部导航栏

class UnitPhoneNavigation extends StatefulWidget {
  const UnitPhoneNavigation({super.key});

  @override
  State createState() => _UnitPhoneNavigationState();
}

class _UnitPhoneNavigationState extends State<UnitPhoneNavigation> {
  //页面控制器，初始 0
  final PageController _controller = PageController();
  final ValueNotifier<AppTab> _activeTab = ValueNotifier(AppTab.widgets);

  // 禁止 PageView 滑动
  final ScrollPhysics _neverScroll = const NeverScrollableScrollPhysics();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid || Platform.isIOS) {}
    String locale =
        context.read<AppConfigBloc>().state.language.locale.toString();
    context.read<UpgradeBloc>().add(CheckUpdate(appId: 1, locale: locale));
  }

  @override
  void dispose() {
    _controller.dispose(); //释放控制器
    _activeTab.dispose();
    super.dispose();
  }


  /// extendBody = true 凹嵌透明，需要处理底部 边距
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        extendBody: true,
        endDrawer: const HomeRightDrawer(),
        body: PageView(
          physics: _neverScroll,
          controller: _controller,
          children: [
            StandardHomePage(),
            GalleryUnit(),
            AlgoScope(child: ArtifactPage()),
            ArtSysScope(child: MobileArticlePage()),
            // MobileToolPage(),
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
        ValueListenableBuilder(
            valueListenable: _activeTab,
            builder: (_, value, __) => PureBottomBar(
                  onTap: _onTapBottomNav,
                  activeTab: value,
                )),
        const Positioned(right: 22, top: 8, child: UpdateRedPoint())
      ],
    );
  }

  // 点击底部按钮事件，切换页面
  void _onTapBottomNav(int index) {
    _controller.jumpToPage(index);
    _activeTab.value = AppTab.values[index];
    if (index == 3) {
      BlocProvider.of<LikeWidgetBloc>(context).add(const EventLoadLikeData());
    }
  }
}
