import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';
import 'package:utils/utils.dart';

import '../../../honors/bloc/avatar_frame_cubit.dart';
import '../../../progression/bloc/progression_cubit.dart';
import '../../../progression/model/progression_item.dart';
import 'account_ui.dart';

/// 右栏直接订阅全局任务状态，不在布局重建时重复请求。
class AccountTasksPanel extends StatelessWidget {
  const AccountTasksPanel({super.key});

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<ProgressionCubit, ProgressionState>(builder: _buildPanel);

  Widget _buildPanel(BuildContext context, ProgressionState state) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final ProgressionOverview? overview = state.overview;
    return AccountSurface(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
          AccountHeading(
              title: context.l10n.accountTodayTasks,
              icon: Icons.assignment_turned_in_outlined,
              action: context.l10n.accountViewAll,
              onAction: () => context.push(AppRoute.progression.url)),
          const SizedBox(height: 6),
          Text(overview?.taskDate ?? context.l10n.earnCraftDustHint,
              style: TextStyle(
                  fontSize: 11, height: 1.5, color: colors.onSurfaceVariant)),
          if (state.loading) ...<Widget>[
            const SizedBox(height: 14),
            const LinearProgressIndicator(minHeight: 2)
          ],
          if (state.error != null)
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextButton(
                    onPressed: context.read<ProgressionCubit>().load,
                    child: Text(context.l10n.loadFailedTapToRetry,
                        style: const TextStyle(fontSize: 12)))),
          if (overview != null) ...<Widget>[
            const SizedBox(height: 16),
            for (final ProgressionItem item in overview.dailyTasks)
              _AccountTaskRow(item: item, state: state),
            const SizedBox(height: 8),
            Divider(
                height: 1, color: colors.outlineVariant.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Row(children: <Widget>[
              Container(
                  width: 32,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(Icons.account_balance_wallet_outlined,
                      size: 21, color: colors.primary)),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text(overview.currency.name,
                        style: TextStyle(
                            fontSize: 11, color: colors.onSurfaceVariant)),
                    Text('${overview.pointsBalance}',
                        style: TextStyle(
                            fontSize: 21,
                            color: colors.primary,
                            fontWeight: FontWeight.w700)),
                  ])),
              TextButton(
                  onPressed: () => context.push(AppRoute.workshop.url),
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 8),
                      minimumSize: const Size(0, 32)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    Text(context.l10n.workshop,
                        style: const TextStyle(fontSize: 12)),
                    const Icon(Icons.chevron_right_rounded, size: 15),
                  ])),
            ]),
          ],
        ]));
  }
}

/// 单个任务展示真实进度；签到和领取复用现有业务操作。
class _AccountTaskRow extends StatelessWidget {
  const _AccountTaskRow({required this.item, required this.state});

  /// 服务端任务定义与进度。
  final ProgressionItem item;

  /// 当前签到和奖励领取状态。
  final ProgressionState state;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final IconData icon = switch (item.code) {
      'daily_check_in' => Icons.event_available_outlined,
      'daily_view_widgets' => Icons.widgets_outlined,
      'daily_collect_widget' => Icons.bookmark_border_rounded,
      _ => Icons.task_alt_rounded,
    };
    final double progress =
        item.target > 0 ? (item.progress / item.target).clamp(0.0, 1.0) : 0;
    return Padding(
        padding: const EdgeInsets.only(bottom: 18),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.07),
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: colors.primary, size: 17)),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                          child: Text(item.name,
                              style: const TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.w600))),
                      const SizedBox(width: 6),
                      Text('+${item.rewardPoints}',
                          style:
                              TextStyle(fontSize: 11, color: colors.primary)),
                    ]),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                        value: progress,
                        minHeight: 3,
                        borderRadius: BorderRadius.circular(3),
                        backgroundColor:
                            colors.primary.withValues(alpha: 0.08)),
                    const SizedBox(height: 3),
                    Row(children: <Widget>[
                      Expanded(
                          child: Text(
                              '${item.progress.clamp(0, item.target)} / ${item.target}',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colors.onSurfaceVariant))),
                      _buildAction(context),
                    ]),
                  ])),
            ]));
  }

  Widget _buildAction(BuildContext context) {
    if (item.status == 'claimed' || item.status == 'unlocked') {
      return Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Text(context.l10n.claimed,
              style: TextStyle(
                  fontSize: 11,
                  color: Theme.of(context).colorScheme.onSurfaceVariant)));
    }
    final bool checkIn = item.code == 'daily_check_in' && !item.completed;
    final bool busy =
        state.checkingIn || state.claimingCode != null || state.loading;
    if (!checkIn && !item.claimable) {
      return Text(context.l10n.pending,
          style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant));
    }
    return TextButton(
      onPressed: busy ? null : () => _submit(context, checkIn),
      style: TextButton.styleFrom(
          minimumSize: const Size(0, 28),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          textStyle: const TextStyle(fontSize: 11)),
      child: Text(checkIn ? context.l10n.checkIn : context.l10n.claim),
    );
  }

  /// 完成操作后同步新获得的荣誉，失败时保留当前总览。
  Future<void> _submit(BuildContext context, bool checkIn) async {
    final ProgressionCubit cubit = context.read<ProgressionCubit>();
    if (checkIn) {
      await cubit.checkIn();
    } else {
      await cubit.claimDailyTask(item.code);
    }
    if (!context.mounted) return;
    if (cubit.state.error != null) {
      Toast.error(context, context.l10n.operationFailed);
      return;
    }
    context.read<AvatarFrameCubit>().load();
  }
}
