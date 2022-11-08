import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_unit/app/res/cons/cons.dart';
import 'package:flutter_unit/app/res/style/unit_color.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/blocs/global/global_bloc.dart';
import 'package:flutter_unit/app/blocs/global/global_event.dart';
import 'package:flutter_unit/app/blocs/global/global_state.dart';
import 'package:flutter_unit/app/views/navigation/unit_app_bar.dart';
import 'package:flutter_unit/components/project/overlay_tool_wrapper.dart';

import 'app_style_setting.dart';

class SettingPage extends StatelessWidget {

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Widget divider =  Divider(height: 1);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const UnitAppbar(title:'应用设置'),
      body: ListView(
        children: <Widget>[
          Container( height: 15,color: UnitColor.scaffoldBgLight),

          ListTile(
            leading: Icon(
              Icons.style,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('应用整体风格', style:  TextStyle(fontSize: 16)),
            subtitle: BlocBuilder<AppBloc,AppState>(
              builder: (_,state)=>Text(
                Cons.kAppStyleStringMap[state.appStyle]!
                  , style:  const TextStyle(fontSize: 14)
              ),
            ),
            onTap: (){
              showAppStyleSelectDialog(context);
            },
          ),
          divider,
          ListTile(
            leading: Icon(
              Icons.palette,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('主题色设置', style:  TextStyle(fontSize: 16)),
            subtitle: BlocBuilder<AppBloc,AppState>(
              builder: (_,state)=>Text(
                  Cons.kThemeColorSupport[state.themeColor]!,
                style: TextStyle(color: state.themeColor,fontSize: 14),
              ),
            ),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(UnitRouter.theme_color_setting),
          ),
          divider,
          ListTile(
            leading: Icon(
              Icons.translate,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('字体设置', style:  TextStyle(fontSize: 16)),
            subtitle: BlocBuilder<AppBloc,AppState>(
              builder: (_,state)=>Text(
                  state.fontFamily
              ),
            ),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(UnitRouter.font_setting),
          ),
          divider,
          Container( height: 10,color: UnitColor.scaffoldBgLight),
          ListTile(
            leading: Icon(
              TolyIcon.icon_item,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('条目样式设置', style:  TextStyle(fontSize: 16),),
            subtitle: const Text('仅华丽样式下可用',style:TextStyle(fontSize: 14),),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(UnitRouter.item_style_setting),
          ),
          divider,
          ListTile(
            leading: Icon(
              TolyIcon.icon_code,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('代码高亮样式', style:  TextStyle(fontSize: 16)),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(UnitRouter.code_style_setting),
          ),
          divider,
          Container( height: 10,color: UnitColor.scaffoldBgLight),
          _buildShowBg(context),
          divider,
          _buildShowOver(context),
          divider,
          // _buildShowTool(context),
          // divider,
          Container( height: 10,color: UnitColor.scaffoldBgLight),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('版本信息', style:  TextStyle(fontSize: 16)),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(UnitRouter.version_info),
          ),
        ],
      ),
    );
  }



  Widget _buildShowBg(BuildContext context) =>
      BlocBuilder<AppBloc, AppState>(
          builder: (_, state) => SwitchListTile(
                value: state.showBackGround,
                secondary: Icon(
                  TolyIcon.icon_background,
                  color: Theme.of(context).primaryColor,
                ),
                title: const Text('显示背景', style:  TextStyle(fontSize: 16)),
                onChanged: (show) {
                  BlocProvider.of<AppBloc>(context)
                      .add(EventSwitchShowBg(show));
                },
              ));

  Widget _buildShowOver(BuildContext context) =>
      BlocBuilder<AppBloc, AppState>(
          builder: (_, state) => SwitchListTile(
            value: state.showPerformanceOverlay,
            secondary: Icon(
              TolyIcon.icon_show,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('显示性能浮层', style:  TextStyle(fontSize: 16)),
            onChanged: (show) {
              BlocProvider.of<AppBloc>(context)
                  .add(EventSwitchShowOver(show));
            },
          ));

  Widget _buildShowTool(BuildContext context) =>
      BlocBuilder<AppBloc, AppState>(
          builder: (_, state) => SwitchListTile(
            value: state.showOverlayTool,
            secondary: Icon(
              TolyIcon.icon_layout,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('显示浮动工具', style:  TextStyle(fontSize: 16)),
            onChanged: (show) {
              if(show){
                  OverlayToolWrapper.of(context).showFloating();
              }else{
                OverlayToolWrapper.of(context).hideFloating();
              }
              BlocProvider.of<AppBloc>(context)
                  .add(EventSwitchShowTool(show));
            },
          ));


  Widget _nextIcon(BuildContext context) =>
      Icon(Icons.chevron_right, color: Theme.of(context).primaryColor);
}
