import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fx_user_session/fx_user_session.dart';
import 'package:l10n/l10n.dart';
import 'package:unit_env/unit_env.dart';

import '../../progression/bloc/progression_cubit.dart';
import '../../progression/model/progression_item.dart';
import 'progression_panel.dart';

/// 独立展示每日任务、匠尘和长期成就。
class TaskAchievementPage extends StatefulWidget {
  const TaskAchievementPage({super.key});

  @override
  State<TaskAchievementPage> createState() => _TaskAchievementPageState();
}

class _TaskAchievementPageState extends State<TaskAchievementPage> {
  @override
  void initState() {
    super.initState();
    context.read<ProgressionCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colors.surfaceContainer,
        appBar: AppBar(
          title: Text(context.l10n.taskAchievements),
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: colors.surfaceContainer,
        ),
        body: BlocBuilder<FxUserSessionCubit, FxUserSession>(
          builder: (BuildContext context, FxUserSession session) {
            if (session is! FxAuthed) {
              return Center(child: Text(context.l10n.signInToViewTasks));
            }
            return const _ProgressionContent();
          },
        ),
      ),
    );
  }
}

class _ProgressionContent extends StatelessWidget {
  const _ProgressionContent();

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return Column(
      children: <Widget>[
        BlocBuilder<ProgressionCubit, ProgressionState>(
          builder: (_, ProgressionState state) =>
              _ProgressionSummary(overview: state.overview),
        ),
        ColoredBox(
          color: colors.surface,
          child: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: colors.primary, width: 2),
              insets: const EdgeInsets.symmetric(horizontal: 42),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: colors.primary,
            labelStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            unselectedLabelColor: colors.onSurfaceVariant,
            unselectedLabelStyle: const TextStyle(fontSize: 15),
            dividerColor: colors.outlineVariant,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            tabs: <Tab>[
              Tab(text: context.l10n.dailyTasks),
              Tab(text: context.l10n.careerAchievements),
            ],
          ),
        ),
        const Expanded(
          child: TabBarView(
            children: <Widget>[
              CustomScrollView(
                  slivers: <Widget>[ProgressionPanel(achievements: false)]),
              CustomScrollView(
                  slivers: <Widget>[ProgressionPanel(achievements: true)]),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProgressionSummary extends StatelessWidget {
  const _ProgressionSummary({required this.overview});

  final ProgressionOverview? overview;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final List<ProgressionItem> tasks =
        overview?.dailyTasks ?? <ProgressionItem>[];
    final int completed =
        tasks.where((ProgressionItem item) => item.completed).length;
    final double ratio = tasks.isEmpty ? 0 : completed / tasks.length;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: <Widget>[
          _DustMark(currency: overview?.currency),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(context.l10n.myCraftDust,
                    style: TextStyle(
                        color: colors.onSurfaceVariant, fontSize: 13)),
                const SizedBox(height: 2),
                Text(
                  '${overview?.pointsBalance ?? 0}',
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 28,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 58,
            height: 58,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  value: ratio,
                  strokeWidth: 5,
                  backgroundColor: colors.surfaceContainerHighest,
                  color: colors.primary,
                ),
                Text('$completed/${tasks.length}',
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          const SizedBox(width: 9),
          Text(context.l10n.completedToday,
              style: TextStyle(
                  color: colors.onSurfaceVariant, fontSize: 12, height: 1.45)),
        ],
      ),
    );
  }
}

class _DustMark extends StatelessWidget {
  const _DustMark({required this.currency});

  final ProgressionCurrency? currency;

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.primary;
    final String assetUrl = currency?.assetUrl ?? '';
    return SizedBox(
      width: 48,
      height: 48,
      child: Image.network(
        FlutterUnitHost.resolveImageResource(assetUrl).toString(),
        errorBuilder: (_, __, ___) =>
            Icon(Icons.auto_awesome_rounded, color: color, size: 23),
      ),
    );
  }
}
