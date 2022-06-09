import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/blocs/color_change_bloc.dart';
import 'package:flutter_unit/app/res/str_unit.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/project/items/gallery/gallery_card_item.dart';
import 'package:flutter_unit/painter_system/gallery_factory.dart';

import '../gallery_detail_page.dart';

/// create by 张风捷特烈 on 2020/11/28
/// contact me by email 1981462002@qq.com
/// 说明:

class DeskGalleryUnit extends StatefulWidget {
  const DeskGalleryUnit({Key? key}) : super(key: key);

  @override
  _DeskGalleryUnitState createState() => _DeskGalleryUnitState();
}

class _DeskGalleryUnitState extends State<DeskGalleryUnit> {
  final ValueNotifier<double> factor = ValueNotifier<double>(0);

  @override
  void dispose() {
    factor.dispose();
    super.dispose();
  }

  final ScrollController controller = ScrollController();

  Color get color => BlocProvider.of<ColorChangeCubit>(context).state.tabColor;

  Color get nextColor =>  BlocProvider.of<ColorChangeCubit>(context).state.nextTabColor;

  BoxDecoration get boxDecoration => BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
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

    final gridDelegate = const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
        childAspectRatio:0.85

    );

    return GridView.builder(
      controller: controller,
        gridDelegate: gridDelegate,
        padding: EdgeInsets.all(20),
        itemCount: widgets.length,
        itemBuilder: (ctx, index) => widgets[index]);
  }
}
