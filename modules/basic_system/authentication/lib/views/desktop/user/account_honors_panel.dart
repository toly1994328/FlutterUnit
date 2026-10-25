import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';

import '../../../honors/bloc/avatar_frame_cubit.dart';
import '../../../honors/model/user_honor.dart';
import 'account_ui.dart';

/// 仅预览已获得的徽章，不用示例奖励填充空数据。
class AccountHonorsPanel extends StatelessWidget {
  const AccountHonorsPanel({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AvatarFrameCubit, AvatarFrameState>(builder: _buildPanel);

  Widget _buildPanel(BuildContext context, AvatarFrameState state) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<UserHonor> badges = state.honors
        .where((UserHonor honor) => honor.kind == 'badge')
        .take(4)
        .toList();
    return AccountSurface(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          AccountHeading(
              title: context.l10n.accountMyHonors,
              icon: Icons.workspace_premium_outlined,
              action: context.l10n.accountViewAll,
              onAction: () => context.push('${AppRoute.honors.url}?tab=badge')),
          const SizedBox(height: 6),
          Text(context.l10n.accountHonorSubtitle,
              style: TextStyle(
                  fontSize: 11, height: 1.5, color: colors.onSurfaceVariant)),
          const SizedBox(height: 20),
          if (state.loading) const LinearProgressIndicator(minHeight: 2),
          if (state.error != null)
            TextButton(
                onPressed: context.read<AvatarFrameCubit>().load,
                child: Text(context.l10n.loadFailedTapToRetry,
                    style: const TextStyle(fontSize: 12)))
          else if (badges.isEmpty && !state.loading)
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(context.l10n.noBadges,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 12, color: colors.onSurfaceVariant))),
          if (badges.isNotEmpty) _buildBadges(context, badges),
        ]));
  }

  Widget _buildBadges(BuildContext context, List<UserHonor> badges) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints bounds) =>
            _buildBadgeGrid(context, bounds, badges));
  }

  Widget _buildBadgeGrid(
      BuildContext context, BoxConstraints bounds, List<UserHonor> badges) {
    final int columns = bounds.maxWidth >= 240 ? 4 : 2;
    final double width = (bounds.maxWidth - (columns - 1) * 8) / columns;
    return Wrap(
        spacing: 8,
        runSpacing: 12,
        children: badges
            .map((UserHonor badge) =>
                SizedBox(width: width, child: _buildBadge(context, badge)))
            .toList());
  }

  Widget _buildBadge(BuildContext context, UserHonor badge) {
    return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => context.push('${AppRoute.honors.url}?tab=badge'),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(children: <Widget>[
                Image.network(
                    FlutterUnitHost.resolveImageResource(badge.assetUrl)
                        .toString(),
                    width: 56,
                    height: 56,
                    fit: BoxFit.contain,
                    errorBuilder: _buildImageError),
                const SizedBox(height: 10),
                Text(badge.name,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 10,
                        height: 1.5,
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Text(_formatDate(badge.grantedAt),
                    style: TextStyle(
                        fontSize: 9,
                        color: Theme.of(context).colorScheme.onSurfaceVariant)),
              ])),
        ));
  }

  Widget _buildImageError(
          BuildContext context, Object error, StackTrace? stack) =>
      Icon(Icons.workspace_premium_outlined,
          color: Theme.of(context).colorScheme.primary, size: 32);
  String _formatDate(DateTime date) {
    final DateTime local = date.toLocal();
    return '${local.year}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
  }
}
