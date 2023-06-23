import 'package:app/app.dart';
import 'package:app_update/views/update_red_point.dart';
import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-26
/// contact me by email 1981462002@qq.com
/// 说明:

class MePageItem extends StatelessWidget {
  final Color color;

  const MePageItem({Key? key, this.color = Colors.white}) : super(key: key);

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
          const SizedBox(
            height: 10,
          ),
          Gap.sfl10,
          _buildItem(context, TolyIcon.icon_them, '应用设置', UnitRouter.setting),
          const Divider(),
          _buildItem(
              context, TolyIcon.icon_layout, '数据管理', UnitRouter.data_manage),
          const Divider(),
          _buildItem(
              context, TolyIcon.icon_collect, '我的收藏', UnitRouter.collect),
          Gap.sfl10,

          Stack(
            children: [
              _buildItem(
                context,
                Icons.update,
                '版本信息',
                UnitRouter.version_info,
              ),
              const Positioned(left: 40, top: 10, child: UpdateRedPoint())
            ],
          ),
          const Divider(),
          _buildItem(context, Icons.info, '关于应用', UnitRouter.about_app),

          Gap.sfl10,
          _buildItem(context, TolyIcon.icon_kafei, '联系本王', UnitRouter.about_me),
        ],
      ),
    );
  }

  Widget _buildItem(
          BuildContext context, IconData icon, String title, String linkTo,
          {VoidCallback? onTap}) =>
      ListTile(
        leading: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        title: Text(title, style:  const TextStyle(fontSize: 16)),
        trailing:
            Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
        onTap: () {
          if (linkTo.isNotEmpty) {
            Navigator.of(context).pushNamed(linkTo);
            if (onTap != null) onTap();
          }
        },
      );
}
