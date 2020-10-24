import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/blocs/bloc_exp.dart';
import 'package:flutter_unit/blocs/point/point_bloc.dart';
import 'package:flutter_unit/blocs/point/point_event.dart';
import 'package:flutter_unit/components/flutter/no_div_expansion_tile.dart';
import 'package:flutter_unit/views/common/unit_drawer_header.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

class HomeDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) {

    final Color color = BlocProvider.of<HomeBloc>(context).activeHomeColor;

    return Container(
        color: color.withAlpha(33),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UnitDrawerHeader(color: color),
            _buildItem(context, TolyIcon.icon_them, '应用设置', UnitRouter.setting),
            _buildItem(context, TolyIcon.icon_layout, '数据统计', null),
            Divider(height: 1),
            _buildFlutterUnit(context),
            _buildItem(context, TolyIcon.icon_code, 'Dart 手册', null),
            Divider(height: 1),
            _buildItem(context, Icons.info, '关于应用', UnitRouter.about_app),
            _buildItem(context, TolyIcon.icon_kafei, '联系本王', UnitRouter.about_me),
          ],
        ),
      );
  }

  Widget _buildFlutterUnit(BuildContext context) => NoBorderExpansionTile(
        backgroundColor: Colors.white70,
        leading: Icon(
          Icons.extension,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Flutter 集录'),
        children: <Widget>[
          _buildItem(context, TolyIcon.icon_tag, '属性集录', UnitRouter.attr),
          _buildItem(context, Icons.palette, '绘画集录', UnitRouter.galley),
          _buildItem(context, Icons.widgets, '布局集录', UnitRouter.layout),
          _buildItem(context, TolyIcon.icon_bug, '要点集录', UnitRouter.issues_point,onTap: (){
            BlocProvider.of<PointBloc>(context).add(EventLoadPoint());
          }),
        ],
      );

  Widget _buildItem(
          BuildContext context, IconData icon, String title, String linkTo,{VoidCallback onTap}) =>
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
            if(onTap!=null) onTap();
          }
        },
      );
}
