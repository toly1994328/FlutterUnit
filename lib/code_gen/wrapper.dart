import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/9/18
/// contact me by email 1981462002@qq.com
/// 说明:

/// spineHeight : 针尖高度
/// angle : 针尖角度 (角度值)
/// radius : 圆角半径
/// offset : 偏移
/// spineType : 类型
/// color : 颜色
///
/// 宽高由父容器指定: 如
/// Container(
//     height: 50,
//     width: 100,
//     child: Wrapper()
//  )

typedef SpinePathBuilder = Path Function(
    Canvas canvas, SpineType spineType, Rect range);

class Wrapper extends StatelessWidget {
  final double spineHeight;
  final double angle;

  final double radius;
  final double offset;
  final SpineType spineType;
  final Color color;
  final Widget? child;
  final SpinePathBuilder? spinePathBuilder;

  final double? strokeWidth;

  final bool formEnd;
  final EdgeInsets padding;

  final double? elevation;
  final Color shadowColor;
  final List<BoxShadow>? shadows;

  Wrapper(
      { this.spineHeight = 8.0,
        this.angle = 75,
        this.radius = 5.0,
        this.offset = 15,
        this.shadows,
        this.strokeWidth,
        this.child,
        this.elevation,
        this.shadowColor = Colors.grey,
        this.formEnd = false,
        this.color = Colors.green,
        this.spinePathBuilder,
        this.padding = const EdgeInsets.all(8),
        this.spineType = SpineType.left});

  Wrapper.just({
    this.radius = 5.0,
    this.strokeWidth,
    this.child,
    this.elevation,
    this.shadows,
    this.shadowColor = Colors.grey,
    this.color = Colors.green,
    this.padding = const EdgeInsets.all(8),
  })  : spineHeight = 0,
        angle = 0,
        offset = 0,
        spineType = SpineType.bottom,
        spinePathBuilder = null,
        formEnd = false;

  @override
  Widget build(BuildContext context) {
    var _padding = padding;
    switch (spineType) {
      case SpineType.top:
        _padding = padding + EdgeInsets.only(top: spineHeight);
        break;
      case SpineType.left:
        _padding = padding + EdgeInsets.only(left: spineHeight);
        break;
      case SpineType.right:
        _padding = padding + EdgeInsets.only(right: spineHeight);
        break;
      case SpineType.bottom:
        _padding = padding + EdgeInsets.only(bottom: spineHeight);
        break;
    }

    return CustomPaint(
      child: Padding(
        padding: _padding,
        child: child,
      ),
      painter: WrapperPainter(
          spineHeight: spineHeight,
          angle: angle,
          radius: radius,
          offset: offset,
          shadows: shadows,
          strokeWidth: strokeWidth,
          color: color,
          shadowColor: shadowColor,
          elevation: elevation,
          spineType: spineType,
          formBottom: formEnd,
          spinePathBuilder: spinePathBuilder),
    );
  }
}

enum SpineType { top, left, right, bottom }

class WrapperPainter extends CustomPainter {
  final Paint mPaint;

  var path = Path();

  final double? strokeWidth;
  final SpinePathBuilder? spinePathBuilder;
  final List<BoxShadow>? shadows;

  final double? elevation;
  final Color shadowColor;
  final double spineHeight;
  final double angle;
  final bool formBottom;
  final double radius;
  final double offset;
  final SpineType spineType;
  final Color color;

  WrapperPainter(
      {this.spineHeight = 10.0,
        this.angle = 75,
        this.spinePathBuilder,
        this.radius = 5.0,
        this.offset = 15,
        this.elevation,
        this.shadows,
        this.strokeWidth,
        this.shadowColor = Colors.grey,
        this.color = Colors.green,
        this.formBottom = false,
        this.spineType = SpineType.left})
      : mPaint = Paint()
    ..color = color
    ..style =
    strokeWidth == null ? PaintingStyle.fill : PaintingStyle.stroke
    ..strokeWidth = strokeWidth == null ? 1 : strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    path = buildBoxBySpineType(
      canvas,
      spineType,
      size.width,
      size.height,
    );

    Path? spinePath;

    if (spinePathBuilder == null) {
      spinePath = buildDefaultSpinePath(canvas, spineHeight, spineType, size);
    } else {

      Rect range ;
      switch(spineType){
        case SpineType.top:
          range = Rect.fromLTRB(0, -spineHeight, size.width, 0);
          break;
        case SpineType.left:
          range = Rect.fromLTRB(-spineHeight, 0, 0, size.height);
          break;
        case SpineType.right:
          range = Rect.fromLTRB(-spineHeight, 0, 0, size.height).translate(size.width, 0);
          break;
        case SpineType.bottom:
          range = Rect.fromLTRB(0, 0, size.width, spineHeight).translate(0, size.height-spineHeight);
          break;
      }
      if(spinePathBuilder !=null){
        spinePath = spinePathBuilder!(canvas, spineType, range);
      }
    }

    if (spinePath != null) {
      path = Path.combine(PathOperation.union, spinePath, path);
      if(shadows!=null){
        drawShadows(canvas,path, shadows!);
      }
      // if (elevation != null) {
      //   canvas.drawShadow(path, shadowColor, elevation!, true);
      //   return;
      // }
      canvas.drawPath(path, mPaint..color=Color(0xffe4e7ed));
    }

  }

  void drawShadows(Canvas canvas, Path path, List<BoxShadow> shadows) {
    for (final BoxShadow shadow in shadows) {
      final Paint shadowPainter = shadow.toPaint();
      if (shadow.spreadRadius == 0) {
        canvas.drawPath(path.shift(shadow.offset), shadowPainter);
      } else {
        Rect zone = path.getBounds();
        double xScale = (zone.width + shadow.spreadRadius) / zone.width;
        double yScale = (zone.height + shadow.spreadRadius) / zone.height;
        Matrix4 m4 = Matrix4.identity();
        m4.translate(zone.width / 2, zone.height / 2);
        m4.scale(xScale, yScale);
        m4.translate(-zone.width / 2, -zone.height / 2);
        canvas.drawPath(path.shift(shadow.offset).transform(m4.storage), shadowPainter);
      }
    }
    Paint whitePaint = Paint()..color = Colors.white;
    canvas.drawPath(path, whitePaint);
  }

  buildDefaultSpinePath(
      Canvas canvas, double spineHeight, SpineType spineType, Size size) {
    switch (spineType) {
      case SpineType.top: return _drawTop(size.width, size.height, canvas);
      case SpineType.left:
        return  _drawLeft(size.width, size.height, canvas);
      case SpineType.right:
        return  _drawRight(size.width, size.height, canvas);
      case SpineType.bottom:
        return _drawBottom(size.width, size.height, canvas);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  Path _drawTop(double width, double height, Canvas canvas) {
    var angleRad = pi / 180 * angle;
    var spineMoveX = spineHeight * tan(angleRad / 2);
    var spineMoveY = spineHeight;
    if (spineHeight != 0) {
      return Path()
        ..moveTo(!formBottom ? offset : width - offset - spineHeight, 0)
        ..relativeLineTo(spineMoveX, -spineMoveY)
        ..relativeLineTo(spineMoveX, spineMoveY);
    }
    return Path();
  }

  Path _drawBottom(double width, double height, Canvas canvas) {
    var lineHeight = height - spineHeight;
    var angleRad = pi / 180 * angle;
    var spineMoveX = spineHeight * tan(angleRad / 2);
    var spineMoveY = spineHeight;
    if (spineHeight != 0) {
      return Path()
        ..moveTo(
            !formBottom ? offset : width - offset - spineHeight, lineHeight)
        ..relativeLineTo(spineMoveX, spineMoveY)
        ..relativeLineTo(spineMoveX, -spineMoveY);
    }
    return Path();
  }

  Path _drawLeft(double width, double height, Canvas canvas) {
    var angleRad = pi / 180 * angle;
    var spineMoveX = spineHeight;
    var spineMoveY = spineHeight * tan(angleRad / 2);
    if (spineHeight != 0) {
      return Path()
        ..moveTo(0, !formBottom ? offset : height - offset - spineHeight)
        ..relativeLineTo(-spineMoveX, spineMoveY)
        ..relativeLineTo(spineMoveX, spineMoveY);
    }
    return Path();
  }

  Path _drawRight(double width, double height, Canvas canvas) {
    var lineWidth = width - spineHeight;
    var angleRad = pi / 180 * angle;
    var spineMoveX = spineHeight;
    var spineMoveY = spineHeight * tan(angleRad / 2);
    if (spineHeight != 0) {
      return Path()
        ..moveTo(lineWidth, !formBottom ? offset : height - offset - spineHeight)
        ..relativeLineTo(spineMoveX, spineMoveY)
        ..relativeLineTo(-spineMoveX, spineMoveY);
    }
    return Path();
  }

  Path buildBoxBySpineType(
      Canvas canvas,
      SpineType spineType,
      double width,
      double height,
      ) {
    double lineHeight, lineWidth;

    switch (spineType) {
      case SpineType.top:
        lineHeight = height - spineHeight;
        canvas.translate(0, spineHeight);
        lineWidth = width;
        break;
      case SpineType.left:
        lineWidth = width - spineHeight;
        lineHeight = height;
        canvas.translate(spineHeight, 0);
        break;
      case SpineType.right:
        lineWidth = width - spineHeight;
        lineHeight = height;
        break;
      case SpineType.bottom:
        lineHeight = height - spineHeight;
        lineWidth = width;
        break;
    }

    Rect box = Rect.fromCenter(
        center: Offset(lineWidth / 2, lineHeight / 2),
        width: lineWidth,
        height: lineHeight);

    return Path()..addRRect(RRect.fromRectXY(box, radius, radius));
  }
}
