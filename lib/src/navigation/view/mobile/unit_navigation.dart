import 'dart:io';

import 'package:algorithm/algorithm.dart';
import 'package:app/app.dart';
import 'package:artifact/artifact.dart';
import 'package:authentication/authentication.dart';
import 'package:draw_system/draw_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/src/navigation/model/app_tab.dart';
import 'package:fx_updater/fx_updater.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:pkg_player/pkg_player.dart';
import 'package:treasure_tools/treasure_tools.dart';
import 'package:unit_env/unit_env.dart';
import 'package:widget_module/widget_module.dart';
import 'news.dart';
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
    if (UnitEnv.supportsInAppUpdate) {
      final String locale =
          context.read<AppConfigBloc>().state.language.locale.toString();
      context.read<UpgradeBloc>().add(CheckUpdate(appId: 1, locale: locale));
    }
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
    return Scaffold(
      extendBody: true,
      endDrawer: const HomeRightDrawer(),
      body: PageView(
        physics: _neverScroll,
        controller: _controller,
        children: [
          StandardHomePage(
            heard: const NewsHeader(),
            avatar: const SessionUserAvatar(size: 32),
            onAvatarPointerDown: () => debugPrint(
              '[FlutterUnit.AuthEntry] home.avatar.pointerDown',
            ),
            onAvatarTap: () => _openAccountEntry(context),
          ),
          BlocBuilder<FxUserSessionCubit, FxUserSession>(
            builder: (BuildContext context, FxUserSession session) =>
                PkgPlayerPage(
              config: PkgPlayerConfig(
                isAuthenticated: session is FxAuthed,
                onLoginRequired: _openPackageLogin,
              ),
            ),
          ),
          AlgoScope(
            child: ArtifactPage(
              drawingPage: const GalleryUnit(embedded: true),
            ),
          ),
          const MobileToolPage(),
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
        if (UnitEnv.supportsInAppUpdate)
          const Positioned(right: 22, top: 8, child: UpdateRedPoint()),
      ],
    );
  }

  // 点击底部按钮事件，切换页面
  void _onTapBottomNav(int index) {
    _controller.jumpToPage(index);
    final AppTab selectedTab = AppTab.mobileTabs[index];
    _activeTab.value = selectedTab;
    if (selectedTab == AppTab.packages) {
      context.read<LikeWidgetBloc>().loadLikeData();
    }
  }

  void _openAccountEntry(BuildContext context) {
    final FxUserSession state = context.read<FxUserSessionCubit>().state;
    final String target =
        state is FxAuthed ? AppRoute.honors.url : AppRoute.login.url;
    debugPrint(
      '[FlutterUnit.AuthEntry] home.avatar.tap '
      'state=${state.runtimeType} target=$target',
    );
    context.push(target);
  }

  Future<void> _openPackageLogin(BuildContext context) {
    return context.push<void>(AppRoute.login.url);
  }
}
