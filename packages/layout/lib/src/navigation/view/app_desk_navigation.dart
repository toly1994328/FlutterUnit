import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:toly_menu_manager/bloc/state.dart';
import 'package:toly_menu_manager/toly_menu_manager.dart';

import '../../views/playground/layout_playground.dart';
import 'app_menu_tree.dart';

class AppDeskNavigation extends StatelessWidget {
  final Widget content;

  const AppDeskNavigation({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          DeskNavigationRail(),
          Expanded(child: LayoutPlayGround(
            content : Column(
              children: [
                MenuHistoryChangeListener(onRouterChanged: _onActiveChanged,
                child: MenuRecordTab(onCloseHistory: _onCloseHistory, onTapHistory: _onTapHistory)),
                Expanded(child: content),
              ],
            ),
          )),
        ],
      ),
    );
  }

  void _onCloseHistory(BuildContext context,MenuHistory history) {
    context.removeHistory(history);
  }

  void _onTapHistory(BuildContext context,String path) {
    print("======_onTapHistory:$path=================");
    context.activeHistory(path);

  }

  void _onActiveChanged(BuildContext context,String? value) {
    if(value!=null){
      context.go(value);
    }
  }
}

class DeskNavigationRail extends StatefulWidget {
  final RangeValues rangeDx;
  final double width;

  const DeskNavigationRail({
    super.key,
    this.rangeDx = const RangeValues(160, 360),
    this.width = 200,
  });

  @override
  State<DeskNavigationRail> createState() => _DeskNavigationRailState();
}

class _DeskNavigationRailState extends State<DeskNavigationRail> {
  late double _width = widget.width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          MenuLoadTaskBuilder(
            builder: (_, task) =>
            switch (task) {
              MenuLoading() => const Center(child: CupertinoActivityIndicator()),
              MenuLoadSuccess() => AppMenuTree(state: task.state,),
              MenuLoadFailed() => Text('${task.error.toString()}'),
            },
          ),
          DragChangeWidth(
            onDragChanged: handleWidthChange,
          )
        ],
      ),
    );
  }

  void handleWidthChange(double dx) {
    double width =
        (_width + dx).clamp(widget.rangeDx.start, widget.rangeDx.end);
    if (width != _width) {
      _width = width;
      setState(() {});
    }
  }
}

class DragChangeWidth extends StatelessWidget {
  final ValueChanged<double> onDragChanged;

  const DragChangeWidth({super.key, required this.onDragChanged});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.resizeColumn,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onHorizontalDragUpdate: _onHorizontalDragUpdate,
        child: Container(
          width: 6,
          alignment: Alignment.centerRight,
          // color: Colors.grey,
          child: const VerticalDivider(),
        ),
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    onDragChanged(details.delta.dx);
  }
}

