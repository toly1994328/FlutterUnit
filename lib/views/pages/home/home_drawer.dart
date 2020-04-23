import 'package:flutter/material.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/components/flutter/no_div_expansion_tile.dart';
import 'package:flutter_unit/views/common/unit_drawer_header.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

class HomeDrawer extends StatelessWidget {
  final Color color;

  HomeDrawer({this.color});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: _buildChild(context),
    );
  }
  Widget _buildChild(BuildContext context) => Container(
        color: color.withAlpha(33),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UnitDrawerHeader(color:color),
            ListTile(
              leading: Icon(
                TolyIcon.icon_them,
                color: Theme.of(context).primaryColor,
              ),
              trailing: _nextIcon(context),
              title: Text('我的主题'),
              onTap: () {
                Navigator.of(context).pushNamed(Router.setting);
              },
            ),

            ListTile(
              leading: Icon(
                TolyIcon.icon_layout,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('数据统计'),
              trailing: _nextIcon(context),
              onTap: () {},
            ),
            Divider(
              height: 1,
            ),
            _buildFlutterUnit(context),
            ListTile(
              leading: Icon(
                TolyIcon.icon_code,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('Dart 手册'),
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
              onTap: () => Navigator.of(context).pushNamed(Router.about_app),
            ),
            ListTile(
              leading: Icon(
                TolyIcon.icon_kafei,
                color: Theme.of(context).primaryColor,
              ),
              title: Text('联系本王'),
              trailing: _nextIcon(context),
              onTap: () => Navigator.of(context).pushNamed(Router.about_me),
            ),
          ],
        ),
      );

  Widget _buildFlutterUnit(BuildContext context) => NoBorderExpansionTile(
        backgroundColor: Colors.white70,
        leading: Icon(
          Icons.extension,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Flutter 集录'),
        children: <Widget>[
          ListTile(
            leading: Icon(
              TolyIcon.icon_tag,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('属性集录'),
            trailing: _nextIcon(context),
            onTap: () {
              Navigator.of(context).pushNamed(Router.attr);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('绘画集录'),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(Router.paint),
          ),
          ListTile(
            leading: Icon(
              Icons.widgets,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('布局集录'),
            trailing: _nextIcon(context),
            onTap: () {
              Navigator.of(context).pushNamed(Router.layout);
            },
          ),
          ListTile(
            leading: Icon(
              TolyIcon.icon_bug,
              color: Theme.of(context).primaryColor,
            ),
            trailing: _nextIcon(context),
            title: Text('bug/feature 集录'),
            onTap: () {
              Navigator.of(context).pushNamed(Router.bug);
            },
          ),
        ],
      );


  Widget _nextIcon(BuildContext context) =>
      Icon(Icons.chevron_right, color: Theme.of(context).primaryColor);
}
