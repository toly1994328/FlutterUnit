import 'dart:convert';

import 'package:app/app.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:l10n/l10n.dart';

import 'package:toly_ui/toly_ui.dart';

import '../gallery_card_item.dart';
import '../gallery_detail_page.dart';
import '../gallery_factory.dart';

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

  Color get color => Colors.blue;

  Color get nextColor =>Colors.orangeAccent;

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
              'Flutter ${context.l10n.paintCollection}',
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
        (json.decode(StrUnit.galleryDesc(context)) as List).map((e) {
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

    SliverGridDelegate gridDelegate =
    const SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: 320,
      mainAxisSpacing: 8,
      mainAxisExtent: 340,
      crossAxisSpacing: 8,
    );

    return GridView.builder(
        controller: controller,
        gridDelegate: gridDelegate,
        padding: const EdgeInsets.all(12),
        itemCount: widgets.length,
        itemBuilder: (ctx, index) => widgets[index]);
  }
}
