import 'dart:convert';

import 'package:app_config/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:components/toly_ui/toly_ui.dart';

import 'package:flutter_unit/painter_system/gallery_card_item.dart';
import 'package:flutter_unit/painter_system/gallery_factory.dart';
import 'package:old_fancy_mobile_ui/bloc/color_change_bloc.dart';

import '../../point_system/views/desk_ui/desk_point_page.dart';
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

  Color get nextColor =>
      BlocProvider.of<ColorChangeCubit>(context).state.nextTabColor;

  BoxDecoration get boxDecoration => const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SimpleDeskTopBar(
            leading: Text(
              'Flutter 绘制集录',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: _buildContent()),
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

    SliverGridDelegate gridDelegate =
    const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 460,
      mainAxisSpacing: 10,
      mainAxisExtent: 360,
      crossAxisSpacing: 10,
    );

    return GridView.builder(
        controller: controller,
        gridDelegate: gridDelegate,
        padding: const EdgeInsets.all(20),
        itemCount: widgets.length,
        itemBuilder: (ctx, index) => widgets[index]);
  }
}
