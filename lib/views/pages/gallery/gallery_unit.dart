import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';

/// create by 张风捷特烈 on 2020/11/28
/// contact me by email 1981462002@qq.com
/// 说明:

class GalleryUnit extends StatefulWidget {
  @override
  _GalleryUnitState createState() => _GalleryUnitState();
}

class _GalleryUnitState extends State<GalleryUnit> {
  final ValueNotifier<double> factor = ValueNotifier<double>(0);

  PageController _ctrl;

  final int _firstOffset = 1000; //初始偏移
  int _position = 0; //页面位置

  @override
  void initState() {
    super.initState();
    _position = _position + _firstOffset;
    factor.value = ((_position - _firstOffset + 1) % 5) / 5 == 0
        ? 1
        : ((_position - _firstOffset + 1) % 5) / 5;
    _ctrl = PageController(
      viewportFraction: 0.9,
      initialPage: _position,
    )..addListener(() {
        factor.value = ((_position - _firstOffset + 1) % 5) / 5 == 0
            ? 1
            : ((_position - _firstOffset + 1) % 5) / 5;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _ctrl.dispose();
  }

  Color get color => Colors.red;

  Color get nextColor => Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: factor,
        builder: (_, value, __) => Container(
          color: Color.lerp(
            color,
            nextColor,
            value,
          ),
          child: Column(
            children: [
              _buildTitle(context),
              Expanded(
                  child: Container(
                child: _buildContent(),
                margin: EdgeInsets.only(left: 8, right: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40))),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            TolyIcon.kujialeqiyezhan_tiaosepan,
            color: Colors.white,
            size: 45,
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            "绘制集录",
            style: TextStyle(fontSize: 30, color: Colors.white),
          ),
        ],
      ),
    );
  }

  
  final List<Widget> testWidgets = [
    Container(
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ))),
    Container(
        decoration: BoxDecoration(
            color: Colors.yellow,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ))),
    Container(
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ))),
    Container(
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ))),
    Container(
        decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ))),
  ];
  
  Widget _buildContent() {

    return Container(
        padding: EdgeInsets.only(bottom: 80, top: 40),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: _ctrl,
                    builder: (context, child) {
                      double value;
                      if (_ctrl.position.haveDimensions) {
                        value = _ctrl.page - index;
                      } else {
                        value = (_position - index).toDouble();
                      }
                      value = (1 - ((value.abs()) * .5)).clamp(0, 1).toDouble();
                      value = Curves.easeOut.transform(value);

                      return Center(
                        child: Transform(
                          transform: Matrix4.diagonal3Values(1.0, value, 1.0),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: testWidgets[fixPosition(
                                index, _firstOffset, testWidgets.length)],
                          ),
                        ),
                      );
                    },
                  );
                },
                onPageChanged: (index) {
                  setState(() => _position = index);
                },
                // children: children2[fixPosition(realPos, initPos, children2.length)],
              ),
            ),
            _buildDiver(),
          ],
        ));
  }

  Widget _buildDiver() => Container(
            margin: EdgeInsets.only(bottom: 12, left: 48, right: 48, top: 10),
            height: 2,
            child: ValueListenableBuilder(
              valueListenable: factor,
              builder: (context, value, widget) {
                return LinearProgressIndicator(
                  value: factor.value,
                  valueColor: AlwaysStoppedAnimation(
                    Color.lerp(
                      color,
                      nextColor,
                      factor.value,
                    ),
                  ),
                );
              },
            ),
          );

  int fixPosition(int realPos, int initPos, int length) {
    final int offset = realPos - initPos;
    int result = offset % length;
    return result < 0 ? length + result : result;
  }
}
