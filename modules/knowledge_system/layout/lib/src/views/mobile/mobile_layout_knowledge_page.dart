import 'package:flutter/material.dart';

import '../../bloc/display_logic.dart';
import '../../bloc/display_state.dart';
import '../../data/display_map/display_map.dart';
import '../base/size/size_display.dart';
import '../display/layout_playground.dart';
import '../overview/layout_overview.dart';

/// 移动端布局知识总览，主题详情通过独立页面打开。
class MobileLayoutKnowledgePage extends StatelessWidget {
  const MobileLayoutKnowledgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: LayoutOverview(
        mobile: true,
        onTopicSelected: (String path) => _openTopic(context, path),
      ),
    );
  }

  /// 将布局主题推入当前导航栈，脱离知识页 Tab 内容区域展示。
  Future<void> _openTopic(BuildContext context, String path) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => MobileLayoutTopicPage(path: path),
      ),
    );
  }
}

/// 移动端单个布局主题的独立案例页。
class MobileLayoutTopicPage extends StatefulWidget {
  /// 布局主题在展示数据中的路径。
  final String path;

  const MobileLayoutTopicPage({super.key, required this.path});

  @override
  State<MobileLayoutTopicPage> createState() => _MobileLayoutTopicPageState();
}

class _MobileLayoutTopicPageState extends State<MobileLayoutTopicPage> {
  late final DisplayLogic _logic;

  @override
  void initState() {
    super.initState();
    _logic = DisplayLogic(
      DisplayState(
        router: widget.path,
        activeIndex: 0,
        total: kDisplayMap[widget.path]!.length,
      ),
    );
  }

  @override
  void dispose() {
    _logic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DisplayScope(
      notifier: _logic,
      child: const _MobileLayoutTopicScaffold(),
    );
  }
}

class _MobileLayoutTopicScaffold extends StatelessWidget {
  const _MobileLayoutTopicScaffold();

  @override
  Widget build(BuildContext context) {
    final DisplayState state = DisplayScope.of(context).state;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        titleSpacing: 0,
        title: Text(
          state.frame.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
        ),
      ),
      body: const LayoutPlayGround(
        mobile: true,
        content: FrameDisplayPanel(),
      ),
    );
  }
}
