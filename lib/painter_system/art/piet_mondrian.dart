import 'dart:math';

import 'package:flutter/material.dart';

import '../utils/colors.dart';

class PietMondrian extends StatefulWidget {
  const PietMondrian({Key? key}) : super(key: key);

  @override
  _PietMondrianState createState() => _PietMondrianState();
}

class _PietMondrianState extends State<PietMondrian> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        setState(() {

        });
      },
      child: CustomPaint(
        painter: PietMondrianPainnter(),
      ),
    );
  }
}

class Square {
  final double x;
  final double y;
  final double width;
  final double height;
  final Color color;

  Square({
   required this.x,
   required this.y,
   required this.width,
   required this.height,
   required this.color,
  });

  Map toJson() {
    return {
      "x": x,
      "y": y,
      "width": width,
      "height": height,
      "color": color.toString(),
    };
  }
}

class PietMondrianPainnter extends CustomPainter {
  void _draw(Canvas canvas, List<Square> squares) {
    final Paint paint = Paint()
      ..strokeWidth = 2
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;

    final Paint paint2 = Paint()
      ..strokeWidth = 2
      ..isAntiAlias = true
      ..color = Colors.black54
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < squares.length; i++) {
      final Square square = squares[i];
      final Rect rect = Rect.fromLTWH(
        square.x,
        square.y,
        square.width,
        square.height,
      );

      paint.color = square.color;
      // paint.color = Color.lerp(a, b, t);
      // paint.color = Random().nextBool()
      //     ? Colors.white
      //     : colors[Random().nextInt(colors.length)].withOpacity(.8);

      canvas.drawRect(rect, paint);
      canvas.drawRect(rect, paint2);
    }
  }

  void _splitSquaresWith(Map coordinates, List<Square> squares) {
    final double x = coordinates["x"]??0;
    final double y = coordinates["y"]??0;

    for (int i = squares.length - 1; i >= 0; i--) {
      final Square square = squares[i];

      if (x > square.x && x < square.x + square.width) {
        if (Random().nextBool()) {
          squares.removeAt(i);
          _splitOnX(square, x, squares);
        }
      }

      if (y > square.y && y < square.y + square.height) {
        if (Random().nextBool()) {
          squares.removeAt(i);
          _splitOnY(square, y, squares);
        }
      }
    }
  }

  void _splitOnX(Square square, double splitAt, List<Square> squares) {
    final Square squareA = Square(
      x: square.x,
      y: square.y,
      width: square.width - (square.width - splitAt + square.x),
      height: square.height,
      color: colors[Random().nextInt(colors.length)].withOpacity(.8),
    );

    final Square squareB = Square(
      x: splitAt,
      y: square.y,
      width: square.width - splitAt + square.x,
      height: square.height,
      color: colors[Random().nextInt(colors.length)].withOpacity(.8),
    );

    squares.add(squareA);
    squares.add(squareB);
  }

  void _splitOnY(Square square, double splitAt, List<Square> squares) {
    final Square squareA = Square(
      x: square.x,
      y: square.y,
      width: square.width,
      height: square.height - (square.height - splitAt + square.y),
      color: colors[Random().nextInt(colors.length)].withOpacity(.8),
    );

    final Square squareB = Square(
      x: square.x,
      y: splitAt,
      width: square.width,
      height: square.height - splitAt + square.y,
      color: colors[Random().nextInt(colors.length)].withOpacity(.8),
    );

    squares.add(squareA);
    squares.add(squareB);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final List<Square> squares = [
      Square(
        x: 0,
        y: 0,
        width: size.width,
        height: size.height,
        color: Colors.white,
      ),
    ];

    double step = size.width / 7;

    for (double i = 0; i < size.width; i += step) {
      _splitSquaresWith({"y": i}, squares);
      _splitSquaresWith({"x": i}, squares);
    }
    _draw(canvas, squares);
  }

  @override
  bool shouldRepaint(PietMondrianPainnter oldDelegate) => true;

}
