import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/router.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/global/global_event.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/components/feedback_widget.dart';
import 'package:flutter_unit/components/panel/circle.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题设置'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('主题色设置'),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(Router.theme_color_setting),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.translate,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('字体设置'),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(Router.font_setting),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              TolyIcon.icon_item,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('item样式设置'),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(Router.item_style_setting),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              TolyIcon.icon_code,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('代码高亮样式'),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(Router.code_style_setting),
          ),
          Divider(),
          _buildShowBg(context),
        ],
      ),
    );
  }

  Widget _buildShowBg(BuildContext context) =>
      BlocBuilder<GlobalBloc, GlobalState>(
          builder: (_, state) => SwitchListTile(
                value: state.showBackGround,
                secondary: Icon(
                  TolyIcon.icon_background,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text('显示背景'),
                onChanged: (show) {
                  BlocProvider.of<GlobalBloc>(context)
                      .add(EventSwitchShowBg(show));
                },
              ));

  Widget _nextIcon(BuildContext context) =>
      Icon(Icons.chevron_right, color: Theme.of(context).primaryColor);
}
