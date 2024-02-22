import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toly_ui/toly_ui.dart';

import '../../about/about_app_page.dart';

class SliverListPanel extends StatelessWidget {
  const SliverListPanel({super.key});

  //coffee1.webp
  @override
  Widget build(BuildContext context) {
    List<Widget> items = [
      InfoPanel(
        title: '开源不易，请我喝咖啡 ~',
        info: 'Flutter Unit 是一个非盈利性的开源项目，'
            '旨在提供全面的 Flutter 学习指南及编程者的交流技术的接口。'
            '由【张风捷特烈】提供技术支持和全权维护。唯一开源网站网址:\n '
            'https://github.com/toly1994328/FlutterUnit',
      ),
      Divider(
        height: 20,
      ),
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
      Divider(
        height: 20,
      ),
      InfoPanel(
          title: 'Flutter Unit 2.0 ',
          info: '○  317 个 Flutter 组件收录和详情介绍。\n'
              '○  绘制集录用于收录绘制相关的优秀示例。\n'
              '○  要点集录用于收录 Flutter 相关的小知识。\n'
              '○  时光轴，查看 FlutterUnit 重要事件。\n'
              '○  实现应用内更新功能，方便使用者及时更新到最新版体验。')
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Circle(color: Theme.of(context).primaryColor),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15),
                  child: Text(
                    '开源不易，请我喝咖啡 ~',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/coffee_zfb.webp',
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Image.asset(
                    'assets/images/coffee_wx.webp',
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Image.asset(
                    'assets/images/coffee_wx_ac.webp',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
