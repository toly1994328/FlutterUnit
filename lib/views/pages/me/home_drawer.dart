import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/components/permanent/circle_image.dart';


/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

class HomeDrawer extends StatelessWidget {
  final Color color;

  HomeDrawer({this.color=Colors.white});

  @override
  Widget build(BuildContext context) {
    return _buildChild(context);
  }
  Widget _buildChild(BuildContext context) {

    return Container(
        color: color.withAlpha(33),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 50),
                      child:

                      Image.asset(
                        'assets/images/sabar_bar.webp',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
//                _buildBar(context),
                Positioned(
                    bottom: 0,
                    left: 50,
                    child: CircleImage(
                      size: 80,
                      shadowColor: Theme.of(context).primaryColor.withAlpha(33),
                      image: AssetImage("assets/images/icon_head.webp"),
                    )),
              ],
            ),
//            UnitDrawerHeader(color:color),
            ListTile(
              leading: Icon(
                Icons.style,
                color: Theme.of(context).primaryColor,
              ),
              trailing: _nextIcon(context),
              title: Text('我的收藏'),
              onTap: () {
//                Navigator.of(context).pushNamed(Router.setting);
              },
            ),

            ListTile(
              leading: Icon(
                Icons.insert_drive_file,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('重置数据库'),
              trailing: _nextIcon(context),
              onTap: () {},
            ),
            Divider(
              height: 1,
            ),


            ListTile(
              leading: Icon(
                Icons.info,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('关于应用'),
              trailing: _nextIcon(context),
//              onTap: () => Navigator.of(context).pushNamed(Router.about_app),
            ),
            ListTile(
              leading: Icon(
                Icons.star_border,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('我的收藏'),
              trailing: _nextIcon(context),
//              onTap: () => Navigator.of(context).pushNamed(Router.about_me),
            ),
            ListTile(
              leading: Icon(
                TolyIcon.icon_show,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('系统设置'),
              trailing: _nextIcon(context),
              onTap: () {},
            ),
          ],
        ),
      );
  }


  Widget _nextIcon(BuildContext context) =>
      Icon(Icons.chevron_right, color: Theme.of(context).primaryColor);
}
