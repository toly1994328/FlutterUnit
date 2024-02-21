/// create by 张风捷特烈 on 2020-04-13
/// contact me by email 1981462002@qq.com
/// 说明: ...
import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/views/time_line/flutter_unit_time_line.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        brightness: Brightness.light
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Image.asset(
                    'assets/images/sabar.webp',
                    fit: BoxFit.cover,
                  ),
                ),
                _buildBar(context),
                Positioned(
                    bottom: 0,
                    left: 50,
                    child: FeedbackWidget(
                      onEnd : (){
                        Navigator.push(context, SlidePageRoute(child: const FlutterUnitTimeLine()));
                      },
                      child: CircleImage(
                        size: 100,
                        shadowColor: Theme.of(context).primaryColor,
                        image: const AssetImage('assets/images/icon_head.webp'),
                      ),
                    )),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.all(24),
                  child: _buildInfo(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBar(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const Spacer(),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("mailto:1981462002@qq.com?subject=来自Flutter Unit"),
            child: Icon(
              TolyIcon.icon_email,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {

    }
  }

  Widget _buildInfo() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 10,
          top: 0,
          child: Wrap(
            spacing: 20,
            children: <Widget>[
              FeedbackWidget(
                  onPressed: () =>
                      _launchURL("https://github.com/toly1994328/FlutterUnit"),
                  child: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: const [
                      Icon(
                        TolyIcon.icon_github,
                        size: 35,
                      ),
                      Text('Github')
                    ],
                  )),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Flutter Unit',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'The Unity Of Flutter, The Unity Of Coder.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Flutter的联合，编程者的联合。',
              style: TextStyle(fontSize: 16),
            ),
            Divider(
              height: 20,
            ),
            InfoPanel(
              title: '项目简介',
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
              info:
                  '○  317 个 Flutter 组件收录和详情介绍。\n'
                  '○  绘制集录用于收录绘制相关的优秀示例。\n'
                  '○  要点集录用于收录 Flutter 相关的小知识。\n'
                  '○  时光轴，查看 FlutterUnit 重要事件。\n'
                  '○  实现应用内更新功能，方便使用者及时更新到最新版体验。'
            )
          ],
        ),
      ],
    );
  }
}

class InfoPanel extends StatelessWidget {
  final String title;
  final String info;


  const InfoPanel({Key? key, required this.title,required this.info}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Circle(color: Theme.of(context).primaryColor),
            Padding(
              padding: const EdgeInsets.only(left: 15,top: 15,bottom: 15),
              child: Text(title,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            )
          ],
        ),
        Panel(
        color: Theme.of(context).primaryColor.withAlpha(33),
          child: Text(
            info,
            style: const TextStyle(color: Colors.grey,
                fontSize: 13,
                shadows: [
                  Shadow(
                      color: Colors.white,
                      offset: Offset(1,1)
                  )
                ]),
          ),
        ),
      ],
    );
  }
}
