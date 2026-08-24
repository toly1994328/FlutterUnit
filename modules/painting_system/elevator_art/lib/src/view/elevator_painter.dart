import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../model/elevator_phase.dart';

/// 绘制电梯井道、楼层、轿厢、门和运行指示。
class ElevatorPainter extends CustomPainter {
  const ElevatorPainter({
    required this.floorCount,
    required this.floorPosition,
    required this.targetFloor,
    required this.doorProgress,
    required this.phase,
  });

  /// 楼层总数。
  final int floorCount;

  /// 轿厢连续楼层位置。
  final double floorPosition;

  /// 当前目标楼层。
  final int targetFloor;

  /// 门打开进度。
  final double doorProgress;

  /// 当前运行阶段。
  final ElevatorPhase phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect background = Offset.zero & size;
    canvas.drawRect(background, Paint()..color = const Color(0xff10151d));

    final double panelWidth = math.min(size.width * 0.78, 430);
    final double shaftWidth = math.min(panelWidth * 0.48, 190);
    final double left = (size.width - panelWidth) / 2;
    const double top = 36;
    final double bottom = size.height - 24;
    final Rect building = Rect.fromLTRB(left, top, left + panelWidth, bottom);
    final Rect shaft = Rect.fromLTRB(
      building.center.dx - shaftWidth / 2,
      top + 34,
      building.center.dx + shaftWidth / 2,
      bottom - 12,
    );

    _drawBuilding(canvas, building, shaft);
    _drawFloors(canvas, building, shaft);
    _drawTarget(canvas, building, shaft);
    _drawCabin(canvas, shaft);
    _drawHeader(canvas, building);
  }

  void _drawBuilding(Canvas canvas, Rect building, Rect shaft) {
    final Paint bodyPaint = Paint()..color = const Color(0xff18212c);
    final Paint borderPaint = Paint()
      ..color = const Color(0xff344253)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawRRect(
      RRect.fromRectAndRadius(building, const Radius.circular(8)),
      bodyPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(building, const Radius.circular(8)),
      borderPaint,
    );
    canvas.drawRect(shaft, Paint()..color = const Color(0xff0b1017));
    canvas.drawRect(shaft, borderPaint);

    final Paint cablePaint = Paint()
      ..color = const Color(0xff45576b)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(shaft.center.dx - shaft.width * 0.2, shaft.top),
      Offset(shaft.center.dx - shaft.width * 0.2, shaft.bottom),
      cablePaint,
    );
    canvas.drawLine(
      Offset(shaft.center.dx + shaft.width * 0.2, shaft.top),
      Offset(shaft.center.dx + shaft.width * 0.2, shaft.bottom),
      cablePaint,
    );
  }

  void _drawFloors(Canvas canvas, Rect building, Rect shaft) {
    final double floorHeight = shaft.height / floorCount;
    final Paint linePaint = Paint()
      ..color = const Color(0xff2b3949)
      ..strokeWidth = 1;
    for (int index = 0; index <= floorCount; index++) {
      final double y = shaft.bottom - floorHeight * index;
      canvas.drawLine(
        Offset(building.left + 12, y),
        Offset(building.right - 12, y),
        linePaint,
      );
      if (index < floorCount) {
        final int floor = index + 1;
        _drawText(
          canvas,
          '$floor',
          Offset(building.left + 18, y - floorHeight / 2 - 7),
          const TextStyle(color: Color(0xff6f8094), fontSize: 11),
        );
      }
    }
  }

  void _drawTarget(Canvas canvas, Rect building, Rect shaft) {
    final double floorHeight = shaft.height / floorCount;
    final double centerY = shaft.bottom - (targetFloor - 0.5) * floorHeight;
    final Paint markerPaint = Paint()..color = const Color(0xff49f2c2);
    final Path marker = Path()
      ..moveTo(building.right - 18, centerY)
      ..lineTo(building.right - 8, centerY - 6)
      ..lineTo(building.right - 8, centerY + 6)
      ..close();
    canvas.drawPath(marker, markerPaint);
  }

  void _drawCabin(Canvas canvas, Rect shaft) {
    final double floorHeight = shaft.height / floorCount;
    final double cabinHeight = floorHeight * 0.76;
    final double centerY = shaft.bottom - (floorPosition - 0.5) * floorHeight;
    final Rect cabin = Rect.fromCenter(
      center: Offset(shaft.center.dx, centerY),
      width: shaft.width * 0.78,
      height: cabinHeight,
    );

    final Paint glowPaint = Paint()
      ..color = const Color(0x3349f2c2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawRRect(
      RRect.fromRectAndRadius(cabin.inflate(3), const Radius.circular(5)),
      glowPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(cabin, const Radius.circular(4)),
      Paint()..color = const Color(0xff34495e),
    );

    final double halfWidth = cabin.width / 2;
    final double openOffset = halfWidth * 0.84 * doorProgress;
    final Rect leftDoor = Rect.fromLTRB(
      cabin.left + 3,
      cabin.top + 3,
      cabin.center.dx - openOffset,
      cabin.bottom - 3,
    );
    final Rect rightDoor = Rect.fromLTRB(
      cabin.center.dx + openOffset,
      cabin.top + 3,
      cabin.right - 3,
      cabin.bottom - 3,
    );
    final Paint doorPaint = Paint()..color = const Color(0xff9aabba);
    if (leftDoor.width > 0) {
      canvas.drawRect(leftDoor, doorPaint);
    }
    if (rightDoor.width > 0) {
      canvas.drawRect(rightDoor, doorPaint);
    }
    canvas.drawLine(
      Offset(cabin.center.dx, cabin.top + 3),
      Offset(cabin.center.dx, cabin.bottom - 3),
      Paint()
        ..color = const Color(0xff263545)
        ..strokeWidth = 1,
    );
  }

  void _drawHeader(Canvas canvas, Rect building) {
    final String direction = switch (phase) {
      ElevatorPhase.moving => 'MOVING',
      ElevatorPhase.closing => 'CLOSING',
      ElevatorPhase.opening => 'OPENING',
      ElevatorPhase.idle => 'READY',
    };
    _drawText(
      canvas,
      'ELEVATOR // $direction',
      Offset(building.left + 14, building.top + 10),
      const TextStyle(
        color: Color(0xffc6d0dd),
        fontFamily: 'monospace',
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset offset,
    TextStyle style,
  ) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant ElevatorPainter oldDelegate) {
    return oldDelegate.floorPosition != floorPosition ||
        oldDelegate.targetFloor != targetFloor ||
        oldDelegate.doorProgress != doorProgress ||
        oldDelegate.phase != phase ||
        oldDelegate.floorCount != floorCount;
  }
}
