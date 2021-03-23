import 'package:flutter_unit/model/enums.dart';
import 'package:flutter_unit/painter_system/gallery_factory.dart';

/// create by 张风捷特烈 on 2020-03-07
/// contact me by email 1981462002@qq.com
/// 说明:

class Convert {
  static WidgetFamily toFamily(int id) {
    switch (id) {
      case 0:
        return WidgetFamily.statelessWidget;
      case 1:
        return WidgetFamily.statefulWidget;
      case 2:
        return WidgetFamily.singleChildRenderObjectWidget;
      case 3:
        return WidgetFamily.multiChildRenderObjectWidget;
      case 4:
        return WidgetFamily.sliver;
      case 5:
        return WidgetFamily.proxyWidget;
      case 6:
        return WidgetFamily.other;
      default:
        return WidgetFamily.statelessWidget;
    }
  }

  static Map<GalleryType, String> galleryTypeMap = {
    GalleryType.base: "基础绘制",
    GalleryType.fun: "趣味绘制",
    GalleryType.particle: "粒子绘制",
    GalleryType.anim: "动画手势",
    GalleryType.art: "艺术画廊",
  };
}
