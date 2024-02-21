import 'package:flutter/cupertino.dart';
import 'package:l10n/l10n.dart';

/// create by 张风捷特烈 on 2020/11/29
/// contact me by email 1981462002@qq.com
/// 说明:

class StrUnit {
  // 小文字大小
  static const String version = 'V3.0.0';
  static const String appName = 'Flutter Unit';

  static String galleryDesc(BuildContext context) => """
[
  {
    "image":"assets/images/anim_draw.webp",
    "name": "${context.l10n.basicDrawing}",
    "info": "${context.l10n.basicDrawingDesc}"
  },
    {
    "image":"assets/images/draw_bg3.webp",
    "name": "${context.l10n.animationGesture}",
    "info": "${context.l10n.animationGestureDesc}"
  },
    {
    "image":"assets/images/base_draw.webp",
     "name": "${context.l10n.particleDrawing}",
    "info": "${context.l10n.particleDrawingDesc}"
    },
    {
    "image":"assets/images/draw_bg4.webp",
        "name": "${context.l10n.interestingDrawing}",
    "info": "${context.l10n.interestingDrawingDesc}"},
    {
    "image":"assets/images/caver.webp",
        "name": "${context.l10n.artGallery}",
    "info": "${context.l10n.artGalleryDesc}"}
]
""";
}
