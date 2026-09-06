import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l10n/l10n.dart';

import '../../progression/bloc/progression_cubit.dart';
import '../../progression/model/progression_item.dart';

const double _actionSlotWidth = 60;
const double _actionSlotHeight = 26;

/// 每日任务或长期成就的列表区。
class ProgressionPanel extends StatelessWidget {
  const ProgressionPanel({super.key, required this.achievements});

  final bool achievements;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProgressionCubit, ProgressionState>(
        builder: _buildByState);
  }

  Widget _buildByState(BuildContext context, ProgressionState state) {
    final ProgressionOverview? overview = state.overview;
    if (state.loading && overview == null) {
      return const SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (overview == null) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: TextButton(
            onPressed: context.read<ProgressionCubit>().load,
            child: Text(context.l10n.loadFailedTapToRetry),
          ),
        ),
      );
    }
    final List<ProgressionItem> items =
        achievements ? overview.achievements : overview.dailyTasks;
    final Widget content = kAppEnv.isDesktopUI
        ? SliverGrid.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              mainAxisExtent: 126,
            ),
            itemBuilder: (BuildContext context, int index) =>
                _buildCard(items, overview.currency, index),
          )
        : SliverList.separated(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) =>
                _buildCard(items, overview.currency, index),
            separatorBuilder: (_, __) => const SizedBox(height: 8),
          );
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 32),
      sliver: content,
    );
  }

  Widget _buildCard(
    List<ProgressionItem> items,
    ProgressionCurrency currency,
    int index,
  ) {
    return _ProgressionCard(
      item: items[index],
      achievement: achievements,
      currency: currency,
    );
  }
}

class _ProgressionCard extends StatelessWidget {
  const _ProgressionCard({
    required this.item,
    required this.achievement,
    required this.currency,
  });

  final ProgressionItem item;
  final bool achievement;

  final ProgressionCurrency currency;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final double progress = (item.progress / item.target).clamp(0, 1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: colors.outlineVariant),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _TaskIcon(item: item, achievement: achievement),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(item.name,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(item.description,
                        style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 12.5,
                            height: 1.35)),
                  ],
                ),
              ),
              if (achievement &&
                  (item.rewards.isNotEmpty ||
                      item.rewardPoints > 0)) ...<Widget>[
                const SizedBox(width: 10),
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      if (item.rewards.isNotEmpty)
                        Expanded(
                          child: _HonorRewardLogos(
                            rewards: item.rewards,
                            maxCount: item.rewardPoints > 0 ? 2 : 3,
                          ),
                        ),
                      if (item.rewardPoints > 0)
                        _DustRewardMark(
                          points: item.rewardPoints,
                          currency: currency,
                          stacked: true,
                        ),
                    ],
                  ),
                ),
              ] else if (item.rewardPoints > 0) ...<Widget>[
                const SizedBox(width: 10),
                _DustRewardMark(points: item.rewardPoints, currency: currency),
              ],
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            borderRadius: BorderRadius.circular(3),
            backgroundColor: colors.surfaceContainerHighest,
            color: colors.primary,
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              Text('${item.progress.clamp(0, item.target)} / ${item.target}',
                  style:
                      TextStyle(color: colors.onSurfaceVariant, fontSize: 12)),
              if (achievement && item.rewards.isNotEmpty) ...<Widget>[
                const SizedBox(width: 8),
                Expanded(child: _HonorRewardNames(rewards: item.rewards)),
              ],
              if (item.rewards.isEmpty) const Spacer(),
              _TaskAction(item: item, achievement: achievement),
            ],
          ),
        ],
      ),
    );
  }
}

class _HonorRewardLogos extends StatelessWidget {
  const _HonorRewardLogos({required this.rewards, this.maxCount = 3});

  final List<ProgressionReward> rewards;

  final int maxCount;

  @override
  Widget build(BuildContext context) {
    final List<ProgressionReward> visibleRewards =
        rewards.take(maxCount).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: visibleRewards.map(_buildRewardLogo).toList(),
    );
  }

  Widget _buildRewardLogo(ProgressionReward reward) {
    return Padding(
      padding: const EdgeInsets.only(left: 3),
      child: Image.network(
        FlutterUnitHost.resolveImageResource(reward.assetUrl).toString(),
        width: 40,
        height: 40,
        errorBuilder: (_, __, ___) => const Icon(
          Icons.workspace_premium_outlined,
          size: 30,
        ),
      ),
    );
  }
}

class _HonorRewardNames extends StatelessWidget {
  const _HonorRewardNames({required this.rewards});

  final List<ProgressionReward> rewards;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Text(
      context.l10n.honorRewardNames(
        rewards
            .map((ProgressionReward reward) => reward.name)
            .join(context.l10n.listSeparator),
      ),
      textAlign: TextAlign.right,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: colors.primary,
        fontSize: 11.5,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _TaskIcon extends StatelessWidget {
  const _TaskIcon({required this.item, required this.achievement});

  final ProgressionItem item;
  final bool achievement;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final IconData icon = achievement
        ? Icons.emoji_events_outlined
        : switch (item.code) {
            'daily_check_in' => Icons.today_outlined,
            'daily_view_widgets' => Icons.explore_outlined,
            'daily_collect_widget' => Icons.bookmark_border_rounded,
            'daily_review_package' => Icons.rate_review_outlined,
            _ => Icons.task_alt_rounded,
          };
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: colors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: colors.primary, size: 21),
    );
  }
}

class _DustRewardMark extends StatelessWidget {
  const _DustRewardMark({
    required this.points,
    required this.currency,
    this.stacked = false,
  });

  /// 奖励的匠尘数量。
  final int points;

  /// 匠尘的名称和图片资源。
  final ProgressionCurrency currency;

  /// 是否将匠尘图标与数量上下排列。
  final bool stacked;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 40,
      child: stacked
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(colors, size: 26),
                _buildAmount(colors, fontSize: 10),
              ],
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(colors, size: 30),
                const SizedBox(width: 3),
                _buildAmount(colors, fontSize: 12),
              ],
            ),
    );
  }

  Widget _buildLogo(ColorScheme colors, {required double size}) {
    return Image.network(
      FlutterUnitHost.resolveImageResource(currency.assetUrl).toString(),
      width: size,
      height: size,
      errorBuilder: (_, __, ___) => Icon(
        Icons.auto_awesome_rounded,
        color: colors.primary,
        size: size,
      ),
    );
  }

  Widget _buildAmount(ColorScheme colors, {required double fontSize}) {
    return Text(
      '+$points',
      style: TextStyle(
        color: colors.primary,
        fontSize: fontSize,
        height: 1,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}

class _TaskAction extends StatelessWidget {
  const _TaskAction({required this.item, required this.achievement});

  final ProgressionItem item;
  final bool achievement;

  @override
  Widget build(BuildContext context) {
    final ProgressionState state = context.watch<ProgressionCubit>().state;
    final ProgressionCubit cubit = context.read<ProgressionCubit>();
    if (achievement) {
      return item.completed
          ? _CompletedLabel(text: context.l10n.unlocked)
          : const SizedBox.shrink();
    }
    if (item.status == 'claimed') {
      return _CompletedLabel(text: context.l10n.claimed);
    }
    if (item.claimable) {
      return _CompactAction(
        label: context.l10n.claim,
        loading: state.claimingCode == item.code,
        onTap: state.claimingCode == null
            ? () => cubit.claimDailyTask(item.code)
            : null,
      );
    }
    if (item.code == 'daily_check_in') {
      return _CompactAction(
        label: context.l10n.checkIn,
        loading: state.checkingIn,
        onTap: state.checkingIn ? null : cubit.checkIn,
      );
    }
    return _PendingLabel(text: context.l10n.pending);
  }
}

class _CompactAction extends StatelessWidget {
  const _CompactAction({
    required this.label,
    required this.loading,
    required this.onTap,
  });

  final String label;
  final bool loading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final bool enabled = onTap != null;
    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: _actionSlotWidth,
          height: _actionSlotHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.primary.withValues(alpha: enabled ? 0.1 : 0.05),
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: loading
                  ? SizedBox.square(
                      dimension: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: colors.primary,
                      ),
                    )
                  : Text(
                      label,
                      style: TextStyle(
                        color:
                            enabled ? colors.primary : colors.onSurfaceVariant,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CompletedLabel extends StatelessWidget {
  const _CompletedLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;
    return SizedBox(
      width: _actionSlotWidth,
      height: _actionSlotHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check_circle, color: color, size: 16),
          const SizedBox(width: 3),
          Text(text, style: TextStyle(color: color, fontSize: 11.5)),
        ],
      ),
    );
  }
}

class _PendingLabel extends StatelessWidget {
  const _PendingLabel({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.onSurfaceVariant;
    return SizedBox(
      width: _actionSlotWidth,
      height: _actionSlotHeight,
      child: Center(
        child: Text(text, style: TextStyle(color: color, fontSize: 11.5)),
      ),
    );
  }
}
