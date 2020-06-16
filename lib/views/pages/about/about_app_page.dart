import 'package:flutter/cupertino.dart';
/// create by 张风捷特烈 on 2020-04-13
/// contact me by email 1981462002@qq.com
/// 说明:

import 'package:flutter/material.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/permanent/panel.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 50),
                      child: Image.asset(
                        'assets/images/sabar.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                _buildBar(context),
                Positioned(
                    bottom: 0,
                    left: 50,
                    child: CircleImage(
                      size: 100,
                      shadowColor: Theme.of(context).primaryColor,
                      image: AssetImage('assets/images/icon_head.png'),
                    )),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(24),
                child: _buildInfo(),
              ),
            ),
          ),
        ],
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
              padding: EdgeInsets.only(left: 10),
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Spacer(),
          FeedbackWidget(
            onPressed: () =>
                _launchURL("mailto:1981462002@qq.com?subject=来自Flutter Unit"),
            child: Icon(
              TolyIcon.icon_email,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
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
                    children: <Widget>[
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
          children: <Widget>[
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
              info:          '      Flutter Unit 是一个非盈利性的开源项目，'
                  '旨在提供全面的Flutter学习指南及编程者的交流技术的接口。'
                  '由【张风捷特烈】提供技术支持和全权维护。唯一开源网站网址: '
                  'https://github.com/toly1994328/FlutterUnit',
            ),
            Divider(
              height: 20,
            ),
            InfoPanel(
                title: 'Flutter Unit 1.0',
                info:    'Flutter Unit 1.0 核心计划是收录widget，即widget集录。'
                    '目前收录组件204个，均可在app中进行查看。'
                    '项目中提供widget图鉴文件可供下载参考。功能主要如下:\n'
                    '○  200+的Flutter 组件收录和详情介绍。\n'
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
              title: 'Flutter Unit 2.0 计划',
              info:    'Flutter Unit 2.0 尚在计划之中，如果说1.0是本王单枪匹马，'
                  '那2.0将是Flutter爱好者的共同努力。后面陆续会发布一些征集方案，'
                  '包括属性、布局、绘制、bug、要点集录等。吾想让Unit 成为一个Flutter的圣地，纯粹而强大,期待与你的共同携手。',
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


  InfoPanel({this.title, this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Circle(color: Theme.of(context).primaryColor,), Padding(
              padding: const EdgeInsets.only(left: 15,top: 15,bottom: 15),
              child: Text('$title',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
            )
          ],
        ),
        Panel(
        color: Theme.of(context).primaryColor.withAlpha(33),
          child: Text(
            '$info',
            style: TextStyle(color: Colors.grey,
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
