import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/str_unit.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/views/components/project/items/gallery/gallery_card_item.dart';
import 'package:flutter_unit/painter_system/gallery_factory.dart';

import 'gallery_detail_page.dart';

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

    double value = ((_position - _firstOffset + 1) % 5) / 5;
    factor.value = value == 0 ? 1 : value;
    _ctrl = PageController(
      viewportFraction: 0.9,
      initialPage: _position,
    )..addListener(() {
        double value = (_ctrl.page - _firstOffset + 1) % 5 / 5;
        factor.value = value == 0 ? 1 : value;
      });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    factor.dispose();
    super.dispose();
  }

  Color get color => BlocProvider.of<WidgetsBloc>(context).state.color;

  Color get nextColor => BlocProvider.of<WidgetsBloc>(context).state.nextColor;

  BoxDecoration get boxDecoration => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        child: Column(
          //使用 child 属性优化
          children: [
            _buildTitle(context),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8),
              child: _buildContent(),
              decoration: boxDecoration,
            ))
          ],
        ),
        valueListenable: factor,
        builder: (_, value, child) => Container(
          color: Color.lerp(
            color,
            nextColor,
            value,
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      alignment: Alignment(0, 0.3),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FlutterLogo(
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "绘制集录",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final List<Widget> widgets =
        (json.decode(StrUnit.galleryInfo) as List).map((e) {
      GalleryInfo info = GalleryInfo.fromJson(e);
      List<Widget> children = GalleryFactory.getGalleryByName(info.type);

      return FeedbackWidget(
        a: 0.95,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => GalleryDetailPage(
                    galleryInfo: info,
                    children: children,
                  )));
        },
        child: GalleryCardItem(
          galleryInfo: info,
          count: children.length,
        ),
      );
    }).toList();

    return Container(
        padding: const EdgeInsets.only(bottom: 80, top: 40),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: widgets[
                          _fixPosition(index, _firstOffset, widgets.length)],
                    ),
                    animation: _ctrl,
                    builder: (context, child) =>
                        _buildAnimItemByIndex(context, child, index),
                  );
                },
                onPageChanged: (index) {
                  _position = index;
                },
              ),
            ),
            _buildDiver(),
          ],
        ));
  }

  Widget _buildAnimItemByIndex(BuildContext context, Widget child, int index) {
    double value;
    if (_ctrl.position.haveDimensions) {
      value = _ctrl.page - index;
    } else {
      value = (_position - index).toDouble();
    }
    value = (1 - ((value.abs()) * .5)).clamp(0, 1).toDouble();
    value = Curves.easeOut.transform(value);

    return Transform(
      transform: Matrix4.diagonal3Values(1.0, value, 1.0),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: child,
      ),
    );
  }

  Widget _buildDiver() => Container(
        margin: EdgeInsets.only(bottom: 12, left: 48, right: 48, top: 10),
        height: 2,
        child: ValueListenableBuilder(
          valueListenable: factor,
          builder: (context, value, widget) {
            return LinearProgressIndicator(
              backgroundColor: Colors.black,
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

  int _fixPosition(int realPos, int initPos, int length) {
    final int offset = realPos - initPos;
    int result = offset % length;
    return result < 0 ? length + result : result;
  }
}
