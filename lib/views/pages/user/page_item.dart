import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/style/behavior/no_scroll_behavior.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/router/unit_router.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

class MePageItem extends StatelessWidget {
  final Color color;

  MePageItem({this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return _buildChild(context);
  }

  Widget _buildChild(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          _buildItem(context, TolyIcon.icon_them, '应用设置', UnitRouter.setting),
          _buildItem(context, TolyIcon.icon_layout, '数据管理', UnitRouter.data_manage),
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

