import 'package:app/app.dart';
import 'package:app_update/views/update_red_point.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/l10n.dart';

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

  Widget get divider {
    return const Divider();
  }

  Widget _buildChild(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoScrollBehavior(),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const SizedBox(height: 10),
          Gap.sfl10,
          _buildItem(context, TolyIcon.icon_them, context.l10n.appSettings,
              AppRoute.settings.url),
          divider,
          _buildItem(context, TolyIcon.icon_layout, context.l10n.dataManagement,
              AppRoute.dataManage.url),
          divider,
          _buildItem(
            context,
            TolyIcon.icon_collect,
            context.l10n.userCollection,
            AppRoute.collection.url,
          ),
          divider,
          _buildItem(
            context,
            TolyIcon.icon_collect,
            '留言板',
            AppRoute.note.url,
          ),
          Gap.sfl10,
          Stack(
            children: [
              _buildItem(
                context,
                Icons.update,
                context.l10n.versionInformation,
                AppRoute.version.url,
              ),
              const Positioned(left: 40, top: 10, child: UpdateRedPoint())
            ],
          ),
          divider,
          _buildItem(context, Icons.info, context.l10n.aboutApplications,
              AppRoute.aboutApp.url),
          Gap.sfl10,
          _buildItem(context, TolyIcon.icon_kafei, context.l10n.contactThisKing,
              AppRoute.aboutMe.url),
          divider,
          _buildItem(context, Icons.sanitizer, context.l10n.homeAccountSupport,
              AppRoute.supportMe.url),
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
        title: Text(title, style: const TextStyle(fontSize: 16)),
        trailing:
            Icon(Icons.chevron_right, color: Theme.of(context).primaryColor),
        onTap: () {
          if (linkTo.isNotEmpty) {
            context.push(linkTo);
            if (onTap != null) onTap();
          }
        },
      );
}
