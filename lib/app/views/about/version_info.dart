
import 'package:flutter/material.dart';

import 'package:flutter_unit/app/res/style/behavior/no_scroll_behavior.dart';
import 'package:flutter_unit/app/router/unit_router.dart';

import 'package:flutter_unit/components/permanent/circle_image.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/update_part/views/app_update_panel.dart';
import 'package:url_launcher/url_launcher.dart';


import 'version/version_shower.dart';

/// create by 张风捷特烈 on 2020/6/16
/// contact me by email 1981462002@qq.com
/// 说明: 

class VersionInfo extends StatelessWidget {
  const VersionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.grey
        ),
      ),
      body:ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top:28.0),
                child: _buildTop(),
              ),

              _buildCenter(context),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom:8.0),
                child: buildBottom(),
              )

            ],
          ),
      ),
    );
  }

  Widget _buildTop() {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      children: const [
        CircleImage(image: AssetImage("assets/images/icon_head.webp"),size: 80,),
        Text('Flutter Unit',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
        VersionShower(),
      ],
    );
  }

  Widget _buildCenter(BuildContext context) {
    const TextStyle labelStyle= TextStyle(fontSize: 13);
    return Padding(
      padding: const EdgeInsets.only(left:20.0,right: 20,top: 20),
      child: ScrollConfiguration(
        behavior: NoScrollBehavior(),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            const Divider(height: 1,),
            ListTile(
              title: const Text('应用详情',style: labelStyle,),
              trailing: _nextIcon(context),
              onTap: () => Navigator.of(context).pushNamed(UnitRouter.about_app),
            ),
            const Divider(height: 1,indent: 10),
            const AppUpdatePanel(),
            const Divider(height: 1,indent: 10),
            ListTile(
              title: const Text('检查数据库新版本',style: labelStyle),
              trailing: _nextIcon(context),
              onTap: () async{

              },
            ),
            const Divider(height: 1,),
          ],
        ),
      ),
    );
  }

  Widget _nextIcon(BuildContext context) =>
      const Icon(Icons.chevron_right, color: Colors.grey);

  Widget buildBottom() {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: <Widget>[
        FeedbackWidget(
            onPressed: (){
              _launchURL("https://github_model.com/toly1994328/FlutterUnit");
            },
            child: const Text('《查看本项目Github仓库》',style: TextStyle(fontSize: 12,color: Color(0xff616C84),),)),
        const Text('Power By 张风捷特烈',style: TextStyle(fontSize: 12,color: Colors.grey),),
        const Text('Copyright © 2008-2020 Toly1994',style: TextStyle(fontSize: 12,color: Colors.grey),),
      ],
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {

    }
  }
}
