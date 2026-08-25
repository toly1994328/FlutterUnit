import 'package:flutter/material.dart';

import '../model/elevator_phase.dart';
import 'elevator_painter.dart';

/// 可交互的电梯绘制作品。
class ElevatorArtwork extends StatefulWidget {
  const ElevatorArtwork({super.key, this.floorCount = 8});

  /// 电梯楼层总数。
  final int floorCount;

  @override
  State<ElevatorArtwork> createState() => _ElevatorArtworkState();
}

class _ElevatorArtworkState extends State<ElevatorArtwork>
    with TickerProviderStateMixin {
  /// 轿厢楼层移动动画。
  late final AnimationController _travelController;

  /// 电梯门开合动画，0 为关闭，1 为打开。
  late final AnimationController _doorController;

  /// 当前轿厢在楼层轴上的连续位置。
  Animation<double> _floorAnimation = const AlwaysStoppedAnimation<double>(1);

  /// 当前停靠楼层。
  int _currentFloor = 1;

  /// 当前目标楼层。
  int _targetFloor = 1;

  /// 当前运行阶段。
  ElevatorPhase _phase = ElevatorPhase.idle;

  bool get _isBusy => _phase != ElevatorPhase.idle;

  @override
  void initState() {
    super.initState();
    _travelController = AnimationController(vsync: this);
    _doorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 420),
      value: 1,
    );
  }

  @override
  void dispose() {
    _travelController.dispose();
    _doorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xff10151d),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final bool compact = constraints.maxWidth < 460;
          return compact ? _buildCompactLayout() : _buildWideLayout();
        },
      ),
    );
  }

  Widget _buildWideLayout() {
    return Row(
      children: <Widget>[
        Expanded(child: _buildPainting()),
        SizedBox(width: 104, child: _buildControlPanel()),
      ],
    );
  }

  Widget _buildCompactLayout() {
    return Column(
      children: <Widget>[
        Expanded(child: _buildPainting()),
        SizedBox(height: 92, child: _buildControlPanel(horizontal: true)),
      ],
    );
  }

  Widget _buildPainting() {
    final Listenable repaint = Listenable.merge(
      <Listenable>[_travelController, _doorController],
    );
    return AnimatedBuilder(
      animation: repaint,
      builder: (BuildContext context, Widget? child) {
        return CustomPaint(
          painter: ElevatorPainter(
            floorCount: widget.floorCount,
            floorPosition: _floorAnimation.value,
            targetFloor: _targetFloor,
            doorProgress: _doorController.value,
            phase: _phase,
          ),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  Widget _buildControlPanel({bool horizontal = false}) {
    final Widget floorButtons = GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: horizontal ? 4 : 2,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        childAspectRatio: horizontal ? 2.5 : 1,
      ),
      itemCount: widget.floorCount,
      itemBuilder: _buildFloorButton,
    );
    if (horizontal) {
      return Row(
        children: <Widget>[
          SizedBox(width: 92, child: _buildStatus()),
          Expanded(child: floorButtons),
        ],
      );
    }
    return Column(
      children: <Widget>[
        _buildStatus(),
        Expanded(child: floorButtons),
      ],
    );
  }

  Widget _buildStatus() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 12, 8, 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            _targetFloor.toString().padLeft(2, '0'),
            style: const TextStyle(
              color: Color(0xff49f2c2),
              fontFamily: 'monospace',
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            _phaseLabel,
            style: const TextStyle(color: Color(0xff8d9bad), fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildFloorButton(BuildContext context, int index) {
    final int floor = widget.floorCount - index;
    final bool selected = floor == _targetFloor;
    return Material(
      color: selected ? const Color(0xff1677ff) : const Color(0xff202a36),
      borderRadius: BorderRadius.circular(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: _isBusy ? null : () => _requestFloor(floor),
        child: Center(
          child: Text(
            '$floor',
            style: TextStyle(
              color: selected ? Colors.white : const Color(0xffc6d0dd),
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  String get _phaseLabel => switch (_phase) {
        ElevatorPhase.idle => '待命',
        ElevatorPhase.closing => '关门',
        ElevatorPhase.moving => _targetFloor > _currentFloor ? '上行' : '下行',
        ElevatorPhase.opening => '开门',
      };

  /// 依次执行关门、楼层移动和开门动画。
  Future<void> _requestFloor(int floor) async {
    if (_isBusy || floor == _currentFloor) {
      return;
    }
    try {
      setState(() {
        _targetFloor = floor;
        _phase = ElevatorPhase.closing;
      });
      await _doorController.reverse().orCancel;
      if (!mounted) {
        return;
      }

      final int distance = (floor - _currentFloor).abs();
      _travelController.duration = Duration(milliseconds: 420 + distance * 260);
      _travelController.reset();
      _floorAnimation = Tween<double>(
        begin: _currentFloor.toDouble(),
        end: floor.toDouble(),
      ).animate(
        CurvedAnimation(
            parent: _travelController, curve: Curves.easeInOutCubic),
      );
      setState(() => _phase = ElevatorPhase.moving);
      await _travelController.forward(from: 0).orCancel;
      if (!mounted) {
        return;
      }

      _currentFloor = floor;
      _floorAnimation = AlwaysStoppedAnimation<double>(floor.toDouble());
      setState(() => _phase = ElevatorPhase.opening);
      await _doorController.forward(from: 0).orCancel;
      if (mounted) {
        setState(() => _phase = ElevatorPhase.idle);
      }
    } on TickerCanceled {
      // 页面销毁时动画取消，无需继续更新状态。
    }
  }
}
