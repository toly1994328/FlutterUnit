import 'package:app/app.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/navigation/overlay_tool_wrapper.dart';


import 'app_style_setting.dart';
import 'theme_model_setting.dart';

class SettingPage extends StatelessWidget {

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Widget divider =  Divider(height: 1);

    return Scaffold(
      appBar: AppBar(title:Text('应用设置')),
      body: ListView(
        children: <Widget>[
          Container( height: 15),
          ListTile(
            leading: Icon(
              Icons.style,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('深色模式', style:  TextStyle(fontSize: 16)),
            subtitle: BlocBuilder<AppBloc,AppState>(
              builder: (_,state)=>Text(
                  themeMode2Str[state.themeMode]!
                  , style:  const TextStyle(fontSize: 12,color: Colors.grey)
              ),
            ),
            trailing: _nextIcon(context),
            onTap: (){
              Navigator.of(context).push(SlidePageRoute(child: ThemeModelSetting()));
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
                style: TextStyle(color: state.themeColor,fontSize: 12),
              ),
            ),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(UnitRouter.theme_color_setting),
          ),
          // divider,
          Container( height: 10),
          ListTile(
            leading: Icon(
              Icons.translate,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('字体设置', style:  TextStyle(fontSize: 16)),
            subtitle: BlocBuilder<AppBloc,AppState>(
              builder: (_,state)=>Text(
                  state.fontFamily,style: TextStyle(fontSize: 12),
              ),
            ),
            trailing: _nextIcon(context),
            onTap: () => Navigator.of(context).pushNamed(UnitRouter.font_setting),
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
          // divider,
          Container( height: 10,),
          _buildShowBg(context),
          divider,
          _buildShowOver(context),
          // divider,
          // _buildShowTool(context),
          // divider,
          Container( height: 10),
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

//SwitchListTile(
//             inactiveTrackColor: Colors.grey.withOpacity(0.3),
//             // inactiveThumbColor: Colors.white,
//             activeColor: Theme.of(context).primaryColor,
//                 value: state.showBackGround,
//                 secondary: Icon(
//                   TolyIcon.icon_background,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 title: const Text('显示背景', style:  TextStyle(fontSize: 16)),
//                 onChanged: (show) {
//                   BlocProvider.of<AppBloc>(context).switchShowBg(show);
//                 },
//               )

  Widget _buildShowBg(BuildContext context) =>
      BlocBuilder<AppBloc, AppState>(
          builder: (_, state) =>           TolySwitchListTile(
            secondary:Icon(
            TolyIcon.icon_background,
            color: Theme.of(context).primaryColor,
          ),
            title: const Text('显示背景', style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
            , value: state.showBackGround, onChanged: (bool value) {
      BlocProvider.of<AppBloc>(context).switchShowBg(value);
          },
          ),);

  Widget _buildShowOver(BuildContext context) =>
      BlocBuilder<AppBloc, AppState>(
          builder: (_, state) => TolySwitchListTile(
            secondary:Icon(
              TolyIcon.icon_background,
              color: Theme.of(context).primaryColor,
            ),
            title: const Text('显示性能浮层', style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
            , value: state.showPerformanceOverlay, onChanged: (bool value) {
            BlocProvider.of<AppBloc>(context).switchShowOver(value);
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
              BlocProvider.of<AppBloc>(context).switchShowTool(show);
            },
          ));


  Widget _nextIcon(BuildContext context) => Icon(Icons.chevron_right, color: Theme.of(context).primaryColor);
}
