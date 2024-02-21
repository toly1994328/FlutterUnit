import 'dart:convert';

import 'package:app/app.dart';
import 'package:components/project_ui/project_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:l10n/l10n.dart';

import 'bloc/gallery_unit/bloc.dart';
import 'desk_ui/desk_gallery_unit.dart';
import 'gallery_card_item.dart';
import 'gallery_detail_page.dart';
import 'gallery_factory.dart';

/// create by 张风捷特烈 on 2020/11/28
/// contact me by email 1981462002@qq.com
/// 说明:

class GalleryUnit extends StatelessWidget {
  const GalleryUnit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_,c){
      if(c.maxWidth>500){
        return const DeskGalleryUnit();
      }
      return const PhoneGalleryUnit();
    });
  }
}

class PhoneGalleryUnit extends StatefulWidget {
  const PhoneGalleryUnit({Key? key}) : super(key: key);

  @override
  _PhoneGalleryUnitState createState() => _PhoneGalleryUnitState();
}

class _PhoneGalleryUnitState extends State<PhoneGalleryUnit> {
  final ValueNotifier<double> factor = ValueNotifier<double>(0);

 late PageController _ctrl;

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
      if(_ctrl.page!=null){
        double value = (_ctrl.page! - _firstOffset + 1) % 5 / 5;
        factor.value = value == 0 ? 1 : value;
      }
      });
  }

  @override
  void dispose() {
    _ctrl.dispose();
    factor.dispose();
    super.dispose();
  }


  Color get color => Colors.blue;

  Color get nextColor =>Colors.orangeAccent;
  bool get isDark => Theme.of(context).brightness == Brightness.dark;

  BoxDecoration get boxDecoration =>  BoxDecoration(
        color: isDark?Colors.white.withAlpha(33):Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value:const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.light
        ),
        child:ValueListenableBuilder(
          child: Column(
            children: [
              _buildTitle(context),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 8, right: 8),
                child: _buildContent(StrUnit.galleryDesc(context)),
                decoration: boxDecoration,
              ))
            ],
          ),
          valueListenable: factor,
          builder: (_,double value, child) => Container(
            color: isDark?null:Color.lerp(
              color,
              nextColor,
              value,
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Container(
      alignment: const Alignment(0, 0.3),
      height: MediaQuery.of(context).size.height * 0.2,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:  [
           FlutterLogo(
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            context.l10n.paintCollection,
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildContentByState(BuildContext context, String state) {
    if(state.isEmpty){
      return const LoadingShower();
    }
    return _buildContent(StrUnit.galleryDesc(context));
  }

  Widget _buildContent(String galleryInfo) {

    final List<Widget> widgets = (json.decode(galleryInfo) as List).map((e) {
      GalleryInfo info = GalleryInfo.fromJson(e);
      List<Widget> children = GalleryFactory.getGalleryByName(info.type,context);

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

  Widget _buildAnimItemByIndex(BuildContext context, Widget? child, int index) {
    double value;
    if (_ctrl.position.haveDimensions&&_ctrl.page!=null) {
      value = _ctrl.page! - index;
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
    margin: const EdgeInsets.only(bottom: 12, left: 48, right: 48, top: 10),
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
