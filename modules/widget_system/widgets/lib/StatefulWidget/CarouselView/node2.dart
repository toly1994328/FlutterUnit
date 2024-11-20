// Copyright 2014 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class CarouselNode2 extends StatefulWidget {
  const CarouselNode2({super.key});

  @override
  State<CarouselNode2> createState() => _CarouselNode2State();
}

class _WidgetMeta {
  final String name;
  final String desc;

  _WidgetMeta(this.name, this.desc);
}

class _CarouselNode2State extends State<CarouselNode2> {
  final List<_WidgetMeta> widgets = [
    _WidgetMeta('Container 容器组件', '用于容纳单个子组件的容器组件。集成了若干个单子组件的功能，如内外边距、形变、装饰、约束等...'),
    _WidgetMeta('Text 文字组件', '用于显示文字的组件。拥有的属性非常多，足够满足你的使用需求,核心样式由style属性控制。'),
    _WidgetMeta('Card 卡片组件', '基于Material组件实现,用于将单个组件卡片化。并使其具有投影效果，可加外边距，也可以自定义卡片形状。'),
    _WidgetMeta('FlutterLogo Flutter图标', '用于展示Flutter图标组件。可定义颜色、尺寸、展示模式等信息，是一个非常简单的组件。'),
    _WidgetMeta('Banner 角标组件', '用于角标显示的组件。可容纳一个子组件,可选择方位添加角标及信息文字，可设置颜色。'),
    _WidgetMeta('Icon 图标组件', '用于图标显示的组件。可指定图标资源、大小、颜色。非常简单，但非常实用。'),
    _WidgetMeta('ImageIcon 图形图标', '用于将一个图片变为纯色的组件。可指定大小、颜色。'),
    _WidgetMeta('FadeInImage 淡入图片', '透明渐变地加载一张图片。可指定占位图片、进退的动画曲线、时间、宽高、fit类型、对齐方式、重复方式等。'),
    _WidgetMeta('CircleAvatar 圆形组件', '可将一张图片变成圆形，并且中间可以放置一个组件。可指定半径、前景色、背景色等。'),
    _WidgetMeta('Visibility 显隐组件', '控制一个组件显示或隐藏,可设置隐藏后的占位组件。与其功能相似的由OffStage组件。'),
  ];

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 64),
      child: CarouselView(
        backgroundColor: const Color(0xfff7f8fa),
        itemExtent: 240,
        // elevation: 1,
        shrinkExtent: 240,
        itemSnapping: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        children: widgets.map((e) => _WidgetDisplay(widget: e)).toList(),
      ),
    );
  }
}

class _WidgetDisplay extends StatelessWidget {
  const _WidgetDisplay({
    super.key,
    required this.widget,
  });

  final _WidgetMeta widget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 16,
                height: 16,
                margin: EdgeInsets.only(right: 6),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(4)),
                child: Text(
                  '热',
                  style: TextStyle(fontSize: 8, color: Colors.white, height: 1),
                ),
              ),
              Text(
                widget.name,
                style:
                    const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                overflow: TextOverflow.clip,
                softWrap: false,
              ),
            ],
          ),
          Text(
            widget.desc,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
            overflow: TextOverflow.clip,
            softWrap: false,
          ),
        ],
      ),
    );
  }
}
