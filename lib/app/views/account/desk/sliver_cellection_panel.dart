import 'package:flutter/material.dart';

import '../../about/about_app_page.dart';

class SliverCollectionPanel extends StatelessWidget {
  const SliverCollectionPanel({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      InfoPanel(
        title: '项目简介',
        info: 'Flutter Unit 是一个非盈利性的开源项目，'
            '旨在提供全面的 Flutter 学习指南及编程者的交流技术的接口。'
            '由【张风捷特烈】提供技术支持和全权维护。唯一开源网站网址:\n '
            'https://github.com/toly1994328/FlutterUnit',
      ),
      const SizedBox(height: 10,),
      InfoPanel(
        title: 'Flutter Unit 1.0',
        info: 'Flutter Unit 1.0 核心计划是收录widget，即widget集录。'
            '目前收录组件 283 个，均可在 app 中进行查看。'
            '项目中提供widget图鉴文件可供下载参考。功能主要如下:\n'
            '○  280+的 Flutter 组件收录和详情介绍。\n'
            '○  对一些重要的组件提供操作体验。\n'
            '○  link to功能，查看组件时可以切换到相关组件。\n'
            '○  组件收藏和取消收藏功能。\n'
            '○  主题、字体设置，代码风格等全局状态管理。\n'
            '○  搜索功能和组件星级分类。',
      ),
      const SizedBox(height: 10,),
      InfoPanel(
          title: 'Flutter Unit 2.0 ',
          info:
          '○  317 个 Flutter 组件收录和详情介绍。\n'
              '○  绘制集录用于收录绘制相关的优秀示例。\n'
              '○  要点集录用于收录 Flutter 相关的小知识。\n'
              '○  时光轴，查看 FlutterUnit 重要事件。\n'
              '○  实现应用内更新功能，方便使用者及时更新到最新版体验。'
      ),
      const SizedBox(height: 10,),
      InfoPanel(
          title: 'Flutter Unit 3.0 ',
          info:
          '○  335 个 Flutter 组件收录和详情介绍。\n'
              '○  知识宝库收录 Flutter 精品文章。\n'
              '○  算法演绎尝试基于 Flutter 可视化展示算法流程。\n'
              '○  工具宝箱，通过 Flutter 界面交互实现一些全平台辅助工具。\n'
              '○  功能全面升级，多语言、暗色模式、Navigator2.0 支持。'
      ),
      const SizedBox(height: 20,)
    ];


    return SliverList(
      delegate: SliverChildBuilderDelegate(
              (_, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 48.0),
                child: items[index],
              ),
          childCount: items.length),
    );
  }
}
