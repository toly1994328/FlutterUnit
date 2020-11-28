import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020/11/28
/// contact me by email 1981462002@qq.com
/// 说明:

class GalleryCardItem extends StatelessWidget {
  final GalleryInfo galleryInfo;

  GalleryCardItem({Key key, this.galleryInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          // side: BorderSide(width: 1.0, color: Colors.black),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
          height: double.maxFinite,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                  height: 160,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(galleryInfo.image)),
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ))
                  // color: Colors.green,

                  ),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15),
                  child: Wrap(
                    children: [
                      Text(
                        galleryInfo.name,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.white,
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

  const GalleryInfo(
      {this.count = 0, this.name, this.info, this.image, this.router});

  factory GalleryInfo.fromJson(Map<String, dynamic> map) {
    return GalleryInfo(
        count: map['count'] ?? 0,
        name: map["name"] ?? "",
        image: map["image"] ?? "assets/images/draw_bg4.webp",
        router: map["router"] ?? "",
        info: map["info"] ?? "");
  }
}
