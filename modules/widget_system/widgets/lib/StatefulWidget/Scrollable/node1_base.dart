import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// create by 张风捷特烈 on 2020/8/2
/// contact me by email 1981462002@qq.com


class ScrollableDemo extends StatelessWidget {
  const ScrollableDemo({super.key});

  List<Color> get data => List.generate(32, (i) => Color(0xFF6600FF - 2 * i));

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: Scrollable(
        axisDirection: AxisDirection.down,
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.start,
        viewportBuilder: (ctx, position) => Viewport(
          cacheExtent: 200,
          cacheExtentStyle: CacheExtentStyle.pixel,
          offset: position,
          slivers: <Widget>[_buildSliverList()],
        ),
      ),
    );
  }

  Widget _buildSliverList() => SliverList(
        delegate: SliverChildBuilderDelegate(
            (_, int index) => Container(
              margin: const EdgeInsets.only(top: 1),
                  alignment: Alignment.center,
                  width: 100,
                  height: 60,
                  color: data[index],
                  child: Text(
                    colorString(data[index]),
                    style: const TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(.5, .5),
                            blurRadius: 2)
                      ],
                    ),
                  ),
                ),
            childCount: data.length),
      );

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
