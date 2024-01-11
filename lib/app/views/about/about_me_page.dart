/// create by 张风捷特烈 on 2020-04-13
/// contact me by email 1981462002@qq.com
/// 说明: ...
import 'package:app/app.dart';
import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
        brightness: Brightness.light
    ),
    child:Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                margin:const EdgeInsets.only(bottom: 50),
                child: Image.asset(
                  'assets/images/sabar.webp',
                  fit: BoxFit.cover,
                ),
              ),
              _buildBar(context),
              Positioned(
                  bottom: 0,
                  left: 50,
                  child: CircleImage(
                    size: 100,
                    shadowColor: Theme.of(context).primaryColor,
                    image: const AssetImage('assets/images/icon_head.webp'),
                  )),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Stack(children: <Widget>[
                Positioned(
                  right: 10,
                  top: 0,
                  child: _buildLinkIcon(),
                ),
                _buildInfo()
              ]),
            ),
          ),
        ],
      ),
    ));
  }

  Widget _buildBar(BuildContext context) {
    return Container(
      height: kToolbarHeight,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Padding(
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
          const SizedBox(width: 20)
        ],
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint('Could not launch $url');
    }
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('张风捷特烈',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        const Divider(height: 18),
        const Text('The King Of Coder. 「编程之王」', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        const Text('海的彼岸有我未曾见证的风采。', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 10),
        const Text(
            '微信群: 编程技术交流圣地 -【Flutter群】\n'
            '愿青梅煮酒，与君天涯共话。',
            style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 10),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: AspectRatio(
              aspectRatio: 1,
              child: Image.asset(
                'assets/images/wechat.webp',
                fit: BoxFit.fitWidth,
              )),
        )),
        const Center(
          child: Text(
            '我的微信',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Wrap _buildLinkIcon() {
    return Wrap(
      spacing: 20,
      children: <Widget>[
        FeedbackWidget(
            onPressed: () =>
                _launchURL("https://juejin.im/user/5b42c0656fb9a04fe727eb37"),
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children:const [
                Icon(
                  TolyIcon.icon_juejin,
                  size: 35,
                  color: Colors.blue,
                ),
                Text('掘金')
              ],
            )),
        FeedbackWidget(
            onPressed: () =>
                _launchURL("https://github.com/toly1994328"),
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: const[
                Icon(
                  TolyIcon.icon_github,
                  size: 35,
                ),
                SizedBox(height: 4,),
                Text('Github')
              ],
            )),
      ],
    );
  }
}
