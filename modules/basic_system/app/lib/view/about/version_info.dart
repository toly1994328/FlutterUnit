
import 'package:app/app.dart';
import 'package:app_update/app_update.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/l10n.dart';

import 'package:toly_ui/toly_ui.dart';
import 'package:url_launcher/url_launcher.dart';


import 'version/version_shower.dart';

/// create by 张风捷特烈 on 2020/6/16
/// contact me by email 1981462002@qq.com
/// 说明: 

class VersionInfo extends StatelessWidget {
  const VersionInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Color? bgColor = Theme.of(context).listTileTheme.tileColor;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
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
                child: buildBottom(context),
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
              title:  Text(context.l10n.appDetails,style: labelStyle,),
              trailing: _nextIcon(context),
              onTap: () => context.push('/about_app'),
            ),
            const Divider(height: 1,indent: 10),
            const AppUpdatePanel(),
            const Divider(height: 1,indent: 10),
            ListTile(
              title:  Text(context.l10n.checkDatabaseNewVersion,style: labelStyle),
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

  Widget buildBottom(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: <Widget>[
        FeedbackWidget(
            onPressed: (){
              _launchURL("https://github.com/toly1994328/FlutterUnit");
            },
            child:  Text(context.l10n.viewThisProjectGithubRepository,style: TextStyle(fontSize: 12,color: Color(0xff616C84),),)),
        const Text('Power By 张风捷特烈',style: TextStyle(fontSize: 12,color: Colors.grey),),
        const Text('Copyright © 2018-2024 Toly1994',style: TextStyle(fontSize: 12,color: Colors.grey),),
      ],
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {

    }
  }
}
