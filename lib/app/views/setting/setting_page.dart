import 'package:app/app.dart';
import 'package:go_router/go_router.dart';
import 'package:l10n/l10n.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/navigation/views/overlay_tool_wrapper.dart';


import 'app_style_setting.dart';
import 'language_setting.dart';
import 'theme_model_setting.dart';

class SettingPage extends StatelessWidget {

  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Widget divider =  Divider(height: 1);


    return DragToMoveAreaNoDouble(
      child: Scaffold(
        appBar: AppBar(title:Text(context.l10n.appSettings)),
        body: ListView(
          children: <Widget>[
            Container( height: 15),
            ListTile(
              leading: Icon(
                Icons.style,
                color: Theme.of(context).primaryColor,
              ),
              title:  Text(context.l10n.darkMode, style:  TextStyle(fontSize: 16)),
              subtitle: BlocBuilder<AppConfigBloc,AppConfigState>(
                builder: (_,state) {
                  String info = switch(state.themeMode){
                    ThemeMode.system => context.l10n.followSystem,
                    ThemeMode.light => context.l10n.lightMode,
                    ThemeMode.dark => context.l10n.darkMode,
                  };
                  return Text(info, style:  const TextStyle(fontSize: 12,color: Colors.grey)
                );
                },
              ),
              trailing: _nextIcon(context),
              onTap: ()=> context.push('/settings/dark_mode'),
            ),
            divider,
            ListTile(
              leading: Icon(
                Icons.palette,
                color: Theme.of(context).primaryColor,
              ),
              title:  Text(context.l10n.themeColorSetting, style:  TextStyle(fontSize: 16)),
              subtitle: BlocBuilder<AppConfigBloc,AppConfigState>(
                builder: (_,state)=>Text(
                  state.themeColor.label(context),
                  style: TextStyle(color: state.themeColor.color,fontSize: 12),
                ),
              ),
              trailing: _nextIcon(context),
              onTap: () => context.push('/settings/theme_color'),
            ),
            // divider,
            Container( height: 10),
            ListTile(
              leading: Icon(
                Icons.translate,
                color: Theme.of(context).primaryColor,
              ),
              title:  Text(context.l10n.fontSetting, style:  TextStyle(fontSize: 16)),
              subtitle: BlocBuilder<AppConfigBloc,AppConfigState>(
                builder: (_,state)=>Text(
                    state.fontFamily,style: TextStyle(fontSize: 12),
                ),
              ),
              trailing: _nextIcon(context),
              onTap: () => context.push('/settings/font_setting'),
            ),
            divider,
            const LanguageSwitchTile(),
            divider,
            ListTile(
              leading: Icon(
                TolyIcon.icon_code,
                color: Theme.of(context).primaryColor,
              ),
              title:  Text(context.l10n.codeHighlightStyle, style:  TextStyle(fontSize: 16)),
              trailing: _nextIcon(context),
              onTap: () => context.push('/settings/code_style'),
            ),
            // divider,
            Container( height: 10,),
            // _buildShowBg(context),
            divider,
            _buildShowOver(context),
            // divider,
            // _buildShowTool(context),
            divider,
            // Container( height: 10),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Theme.of(context).primaryColor,
              ),
              title:  Text(context.l10n.versionInformation, style:  TextStyle(fontSize: 16)),
              trailing: _nextIcon(context),
              onTap: () => context.push('/settings/version'),
            ),
          ],
        ),
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
      BlocBuilder<AppConfigBloc, AppConfigState>(
          builder: (_, state) =>           TolySwitchListTile(
            secondary:Icon(
            TolyIcon.icon_background,
            color: Theme.of(context).primaryColor,
          ),
            title: const Text('显示背景', style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold))
            , value: state.showBackGround, onChanged: (bool value) {
      BlocProvider.of<AppConfigBloc>(context).switchShowBg(value);
          },
          ),);

  Widget _buildShowOver(BuildContext context) =>
      BlocBuilder<AppConfigBloc, AppConfigState>(
          builder: (_, state) => TolySwitchListTile(
            secondary:Icon(
              TolyIcon.icon_background,
              color: Theme.of(context).primaryColor,
            ),
            title:  Text(context.l10n.displayPerformanceFloatingLayer, style:  TextStyle(fontSize: 16))
            , value: state.showPerformanceOverlay, onChanged: (bool value) {
            BlocProvider.of<AppConfigBloc>(context).switchShowOver(value);
          },
          ));

  Widget _buildShowTool(BuildContext context) =>
      BlocBuilder<AppConfigBloc, AppConfigState>(
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
              BlocProvider.of<AppConfigBloc>(context).switchShowTool(show);
            },
          ));


  Widget _nextIcon(BuildContext context) => Icon(Icons.chevron_right, color: Theme.of(context).primaryColor);
}
