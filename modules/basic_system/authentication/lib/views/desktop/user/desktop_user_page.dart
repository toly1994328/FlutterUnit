import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';

import 'account_collections_panel.dart';
import 'account_honors_panel.dart';
import 'account_profile_panel.dart';
import 'account_tasks_panel.dart';

/// 桌面账号总览。收藏内容由应用层组合，避免账号与组件模块相互依赖。
class DesktopUserPage extends StatelessWidget {
  const DesktopUserPage(
      {super.key, this.collectionCount = 0, this.collectionContent});

  /// 本地组件收藏数量。
  final int collectionCount;

  /// 由组件模块提供的真实收藏预览。
  final Widget? collectionContent;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FxUserSessionCubit, FxUserSession, bool>(
      selector: _isAuthenticated,
      builder: _buildOverview,
    );
  }

  bool _isAuthenticated(FxUserSession session) => session is FxAuthed;

  Widget _buildOverview(BuildContext context, bool authenticated) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints bounds) =>
              _buildCanvas(context, bounds, authenticated)),
    );
  }

  Widget _buildCanvas(
      BuildContext context, BoxConstraints bounds, bool authenticated) {
    final double padding = bounds.maxWidth < 700 ? 16 : 24;
    return SingleChildScrollView(
      key: const PageStorageKey<String>('desktop-account-overview'),
      padding: EdgeInsets.all(padding),
      child: Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(context.l10n.accountOverviewTitle,
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(context.l10n.accountOverviewSubtitle,
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).colorScheme.onSurfaceVariant)),
              const SizedBox(height: 24),
              _buildColumns(
                  context, bounds.maxWidth - padding * 2, authenticated),
            ]),
      )),
    );
  }

  /// 常用桌面尺寸展示三栏，窄窗口依次折叠为两栏和单栏。
  Widget _buildColumns(BuildContext context, double width, bool authenticated) {
    final Widget collections = AccountCollectionsPanel(
        count: collectionCount,
        authenticated: authenticated,
        preview: collectionContent);
    const Widget activity = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AccountTasksPanel(),
          SizedBox(height: 16),
          AccountHonorsPanel(),
        ]);
    if (width >= 860) {
      return Row(
          key: const ValueKey<String>('account-three-columns'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: 248,
                child: ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 640),
                    child: AccountProfilePanel(authenticated: authenticated))),
            const SizedBox(width: 16),
            Expanded(flex: 6, child: collections),
            if (authenticated) ...<Widget>[
              const SizedBox(width: 16),
              const Expanded(flex: 5, child: activity)
            ],
          ]);
    }
    if (width >= 600) {
      return Row(
          key: const ValueKey<String>('account-two-columns'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
                width: 248,
                child: AccountProfilePanel(authenticated: authenticated)),
            const SizedBox(width: 16),
            Expanded(
                child: Column(children: <Widget>[
              collections,
              if (authenticated) ...<Widget>[
                const SizedBox(height: 16),
                activity
              ]
            ])),
          ]);
    }
    return Column(
        key: const ValueKey<String>('account-single-column'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AccountProfilePanel(authenticated: authenticated),
          const SizedBox(height: 16),
          collections,
          if (authenticated) ...<Widget>[const SizedBox(height: 16), activity],
        ]);
  }
}
