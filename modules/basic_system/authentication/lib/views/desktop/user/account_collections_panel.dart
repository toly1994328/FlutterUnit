import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import '../../../honors/bloc/avatar_frame_cubit.dart';
import '../../../honors/model/user_honor.dart';
import 'account_ui.dart';

/// 中栏展示本地收藏与登录后的常用入口。
class AccountCollectionsPanel extends StatelessWidget {
  const AccountCollectionsPanel(
      {super.key,
      required this.count,
      required this.authenticated,
      this.preview});

  /// 本地收藏总数量。
  final int count;

  /// 是否展示用户私有的常用入口。
  final bool authenticated;

  /// 组件模块注入的真实收藏网格。
  final Widget? preview;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return AccountSurface(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          AccountHeading(
              title: context.l10n.userCollection,
              icon: Icons.bookmark_rounded,
              action: context.l10n.accountViewAll,
              onAction: () => context.push(AppRoute.collection.url)),
          const SizedBox(height: 6),
          Text(context.l10n.accountFavoritesHint,
              style: TextStyle(
                  fontSize: 12, height: 1.5, color: colors.onSurfaceVariant)),
          const SizedBox(height: 16),
          Row(children: <Widget>[
            Expanded(
                child: _buildStat(context, '$count',
                    context.l10n.accountSavedWidgets, Icons.bookmark_rounded)),
            if (authenticated)
              Expanded(
                  child: BlocBuilder<AvatarFrameCubit, AvatarFrameState>(
                      builder: _buildHonorCount)),
          ]),
          const SizedBox(height: 16),
          if (count > 0 && preview != null) preview! else _buildEmpty(context),
          if (authenticated) ...<Widget>[
            const SizedBox(height: 16),
            Divider(
                height: 1, color: colors.outlineVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            AccountHeading(
                title: context.l10n.accountCommonActions,
                icon: Icons.rocket_launch_outlined),
            const SizedBox(height: 10),
            _buildShortcuts(context),
          ],
        ]));
  }

  Widget _buildHonorCount(BuildContext context, AvatarFrameState state) {
    final int count =
        state.honors.where((UserHonor honor) => honor.kind == 'badge').length;
    return _buildStat(
        context,
        state.loading || state.error != null ? '—' : '$count',
        context.l10n.accountEarnedBadges,
        Icons.workspace_premium_outlined);
  }

  Widget _buildStat(
      BuildContext context, String value, String label, IconData icon) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Row(children: <Widget>[
      Container(
          width: 34,
          height: 38,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, size: 22, color: colors.primary)),
      const SizedBox(width: 10),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Text(label,
                style: TextStyle(fontSize: 11, color: colors.onSurfaceVariant)),
            const SizedBox(height: 3),
            Text(value,
                style:
                    const TextStyle(fontSize: 23, fontWeight: FontWeight.w700)),
          ])),
    ]);
  }

  Widget _buildEmpty(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 36),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(10)),
        child: Column(children: <Widget>[
          Icon(Icons.bookmark_border_rounded,
              size: 34, color: Theme.of(context).colorScheme.primary),
          const SizedBox(height: 12),
          Text(context.l10n.accountNoFavorites,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, height: 1.6)),
          const SizedBox(height: 12),
          TextButton(
              onPressed: () => context.push(AppRoute.collection.url),
              child: Text(context.l10n.userCollection)),
        ]));
  }

  Widget _buildShortcuts(BuildContext context) =>
      LayoutBuilder(builder: _buildShortcutLayout);

  Widget _buildShortcutLayout(
      BuildContext context, BoxConstraints constraints) {
    final Widget honors = _shortcut(
        context,
        Icons.workspace_premium_outlined,
        context.l10n.avatarAchievements,
        context.l10n.accountHonorsHint,
        AppRoute.honors.url);
    final Widget workshop = _shortcut(
        context,
        Icons.storefront_outlined,
        context.l10n.workshop,
        context.l10n.accountWorkshopHint,
        AppRoute.workshop.url);
    if (constraints.maxWidth < 300) {
      return Column(
          children: <Widget>[honors, const SizedBox(height: 10), workshop]);
    }
    return Row(children: <Widget>[
      Expanded(child: honors),
      const SizedBox(width: 12),
      Expanded(child: workshop)
    ]);
  }

  Widget _shortcut(BuildContext context, IconData icon, String title,
      String subtitle, String path) {
    return DecoratedBox(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            border: Border.all(
                color: Theme.of(context)
                    .colorScheme
                    .outlineVariant
                    .withValues(alpha: 0.6))),
        child: AccountEntry(
            icon: icon,
            label: title,
            description: subtitle,
            onTap: () => context.push(path)));
  }
}
