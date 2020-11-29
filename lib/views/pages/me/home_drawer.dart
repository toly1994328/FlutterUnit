import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/views/components/permanent/circle_image.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

class HomeDrawer extends StatelessWidget {
  final Color color;

  HomeDrawer({this.color = Colors.white});

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
                    child: Image.asset(
                      'assets/images/sabar_bar.webp',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
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
          SizedBox(height: 10,),
          _buildItem(context, TolyIcon.icon_them, '应用设置', UnitRouter.setting),
          _buildItem(context, TolyIcon.icon_layout, '数据统计', null),
          _buildItem(context, TolyIcon.icon_collect, '我的收藏', UnitRouter.collect),
          Divider(
            height: 1,
          ),
          _buildItem(context, Icons.update, '版本信息', UnitRouter.version_info),
          _buildItem(context, Icons.info, '关于应用', UnitRouter.about_app),
          Divider(
            height: 1,
          ),
          _buildItem(context, TolyIcon.icon_kafei, '联系本王', UnitRouter.about_me),

        ],
      ),
    );
  }


  Widget _buildItem(
          BuildContext context, IconData icon, String title, String linkTo,
          {VoidCallback onTap}) =>
      ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title),
        trailing:
            Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
        onTap: () {
          if (linkTo != null && linkTo.isNotEmpty) {
            Navigator.of(context).pushNamed(linkTo);
            if (onTap != null) onTap();
          }
        },
      );
}
