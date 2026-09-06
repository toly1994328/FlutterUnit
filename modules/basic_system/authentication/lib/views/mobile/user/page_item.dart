import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';

import '../../../progression/bloc/progression_cubit.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

class MePageItem extends StatelessWidget {
  final Color color;

  const MePageItem({super.key, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return _buildChild(context);
  }

  Widget get divider {
    return const Divider();
  }

  Widget _buildChild(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 10),
          Gap.sfl10,
          _buildItem(context, TolyIcon.icon_them, context.l10n.appSettings,
              AppRoute.settings.url),
          divider,
          _buildItem(context, TolyIcon.icon_layout, context.l10n.dataManagement,
              AppRoute.dataManage.url),
          divider,
          _buildItem(
            context,
            TolyIcon.icon_collect,
            context.l10n.userCollection,
            AppRoute.collection.url,
          ),
          Gap.sfl10,
          _buildProgressionItem(context),
          divider,
          _buildItem(
            context,
            Icons.workspace_premium_outlined,
            context.l10n.avatarAchievements,
            AppRoute.honors.url,
          ),
          divider,
          _buildItem(
            context,
            Icons.storefront_outlined,
            context.l10n.workshop,
            AppRoute.workshop.url,
          ),
          Gap.sfl10,
          _buildItem(
            context,
            Icons.note_alt,
            context.l10n.messageBoard,
            AppRoute.note.url,
          ),
          divider,
          _buildItem(
            context,
            Icons.person_off_outlined,
            context.l10n.blacklist,
            AppRoute.blacklist.url,
          ),
          if (!kAppEnv.isIos) ...[
            Gap.sfl10,
            _buildItem(
              context,
              Icons.sanitizer,
              context.l10n.homeAccountSupport,
              AppRoute.supportMe.url,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildItem(
          BuildContext context, IconData icon, String title, String linkTo,
          {VoidCallback? onTap, int badgeCount = 0}) =>
      ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (badgeCount > 0) _buildBadge(badgeCount),
            if (badgeCount > 0) const SizedBox(width: 8),
            Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
          ],
        ),
        onTap: () {
          if (linkTo.isNotEmpty) {
            context.push(linkTo);
            if (onTap != null) onTap();
          }
        },
      );

  Widget _buildProgressionItem(BuildContext context) {
    return BlocSelector<ProgressionCubit, ProgressionState, int>(
      selector: (ProgressionState state) => state.claimableTaskCount,
      builder: (BuildContext context, int count) => _buildItem(
        context,
        Icons.task_alt_outlined,
        context.l10n.taskAchievements,
        AppRoute.progression.url,
        badgeCount: count,
      ),
    );
  }

  Widget _buildBadge(int count) {
    return Align(
      widthFactor: 1,
      heightFactor: 1,
      child: Container(
        height: 16,
        constraints: const BoxConstraints(minWidth: 16),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          count > 99 ? '99+' : '$count',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w600,
            height: 1,
          ),
        ),
      ),
    );
  }
}
