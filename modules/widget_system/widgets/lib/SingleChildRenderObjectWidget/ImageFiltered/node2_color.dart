import 'dart:ui';

import 'package:flutter/material.dart';
/// create by 张风捷特烈 on 2022/04/23
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 357,
//      "name": 'ImageFilter 滤色效果',
//      "priority": 2,
//      "subtitle": "通过 ColorFilter 对象实现颜色滤镜。",
//    }
class ImageFilteredColor extends StatefulWidget {
  const ImageFilteredColor({Key? key}) : super(key: key);

  @override
  State<ImageFilteredColor> createState() => _ImageFilteredColorState();
}

class _ImageFilteredColorState extends State<ImageFilteredColor> {

  String _currentFilter = 'srgbToLinear';

   ColorFilter greyscale = const ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0,      0,      0,      1, 0,
   ]);
   ColorFilter sepia = const ColorFilter.matrix(<double>[
    0.393, 0.769, 0.189, 0, 0,
    0.349, 0.686, 0.168, 0, 0,
    0.272, 0.534, 0.131, 0, 0,
    0,     0,     0,     1, 0,
   ]);
  ColorFilter invert = const ColorFilter.matrix(<double>[
    -1,  0,  0, 0, 255,
    0, -1,  0, 0, 255,
    0,  0, -1, 0, 255,
    0,  0,  0, 1,   0,
  ]);
  ColorFilter identity = const ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);


  ColorFilter darken = const ColorFilter.matrix(<double>[
    1,0,0,0,-126.0,
    0,1,0,0,-126.0,
    0,0,1,0,-126.0,
    0,0,0,1,0
  ]);

   ColorFilter light = const ColorFilter.matrix(<double>[
    1,0,0,0,90,
    0,1,0,0,90,
    0,0,1,0,90,
    0,0,0,1,0
   ]);

  late Map<String,ColorFilter> filterMap={
    '原图': identity,
    'light': light,
    'darken': darken,
    'greyscale': greyscale,
    'sepia': sepia,
    'invert': invert,
    'srgbToLinear':const ColorFilter.srgbToLinearGamma(),
    'linearToSrgb':const ColorFilter.linearToSrgbGamma(),
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ImageFiltered(
          imageFilter: filterMap[_currentFilter]??identity,
          child: const _TargetContent(),
        ),
        buildTileModeCheck()
      ],
    );
  }


  Widget buildTileModeCheck() => Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Wrap(
          children: filterMap.keys.map((e) {
            TextStyle style;
            if (e == _currentFilter) {
              Color color = Theme.of(context).primaryColor;
              style = TextStyle(fontWeight: FontWeight.bold, color: color);
            } else {
              style = const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.grey);
            }
            return GestureDetector(
              onTap: () => setState(() => _currentFilter = e),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                child: Text(
                  e,
                  style: style,
                ),
              ),
            );
          }).toList(),
        ),
  );
}

class _TargetContent extends StatelessWidget {
  const _TargetContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/images/sabar.webp',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: 150,
          width: 150,
          child: Image.asset(
            'assets/images/wy_200x300.webp',
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
