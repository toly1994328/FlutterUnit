import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/utils/convert.dart';
import 'package:flutter_unit/painter_system/gallery_factory.dart';


/// create by 张风捷特烈 on 2020/11/28
/// contact me by email 1981462002@qq.com
/// 说明:

class GalleryCardItem extends StatelessWidget {
  final GalleryInfo galleryInfo;
  final int count;

  const GalleryCardItem({
    Key? key,
    required this.galleryInfo,
    this.count = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool isDark = themeData.brightness == Brightness.dark;

    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
          height: double.maxFinite,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Hero(
                tag: galleryInfo.name,
                child: Container(
                    height: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(galleryInfo.image)),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ))
                    // color: Colors.green,

                    ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 15, right: 15, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      galleryInfo.name,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                                color: Theme.of(context).primaryColor,
                                offset: const Offset(.2, .2),
                                blurRadius: .5)
                          ]),
                    ),
                    const Spacer(),
                    WrapColor(
                      radius: 6,
                      padding:
                          const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 3),
                      child: Text(
                        "$count 幅",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Text(
                  galleryInfo.info,
                  style: TextStyle(color: isDark?Colors.white:Colors.grey, shadows: [
                    Shadow(
                        color: Theme.of(context).primaryColor,
                        offset: const Offset(.2, .2),
                        blurRadius: .5)
                  ]),
                ),
              )
            ],
          ),
          decoration:  BoxDecoration(
              color: isDark?Colors.black87:Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ))),
    );
  }
}

class GalleryInfo {
  final int count;
  final String name;
  final String info;
  final String image;
  final String router;

  GalleryType get type {
    GalleryType galleryType = GalleryType.base;
    Convert.galleryTypeMap.forEach((key, value) {
      if (value == name) {
        galleryType = key;
      }
    });
    return galleryType;
  }

  const GalleryInfo(
      {this.count = 0,required this.name,required this.info,required this.image,required this.router});

  factory GalleryInfo.fromJson(Map<String, dynamic> map) {
    return GalleryInfo(
        count: map['count'] ?? 0,
        name: map["name"] ?? "",
        image: map["image"] ?? "assets/images/draw_bg4.webp",
        router: map["router"] ?? "",
        info: map["info"] ?? "");
  }
}
