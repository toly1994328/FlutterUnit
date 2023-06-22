import 'package:app/app.dart';
import 'package:app/app/style/unit_color.dart';
import 'package:components/project_ui/unit_app_bar.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeModelSetting extends StatelessWidget {
  const ThemeModelSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    ThemeMode mode = context.select<AppBloc,ThemeMode>((bloc) => bloc.state.themeMode);
    Color iconColor  = Theme.of(context).primaryColor;
    return     Scaffold(
      appBar: AppBar(title: Text('深色模式')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container( height: 15,),
          TolySwitchListTile(
            title: const Text('跟随系统', style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
            subtitle: Text(
              '开启后，将跟随系统打开或关闭深色模式',style: TextStyle(fontSize: 12,color: Colors.grey),
            ), value: mode == ThemeMode.system, onChanged: (bool value) {
              print("========value:$value==========");
              ThemeMode newModel;
              if(value){
                newModel = ThemeMode.system;
              }else{
                newModel = ThemeMode.light;
              }
              context.read<AppBloc>().changeThemeMode(newModel);
             },
            // trailing: _nextIcon(context),
            // : () => Navigator.of(context).pushNamed(UnitRouter.font_setting),
          ),
          // AppStyle locale = Cons.kAppStyleStringMap.keys.toList()[index];
          // AppStyle style = BlocProvider.of<AppBloc>(context).state.appStyle;
          // bool checked = style == locale;
          // Color color = Theme.of(context).primaryColor;
        Padding(
          padding: const EdgeInsets.only(left: 10,top: 16,bottom: 6),
          child: Text("手动设置"),
        ),
        ListTile(
            title: Text('浅色模式'),
            onTap: (){
              context.read<AppBloc>().changeThemeMode(ThemeMode.light);
            },
            trailing: mode == ThemeMode.light ? Icon(Icons.check, size: 20, color: iconColor) : null,
          ),
          Divider(),
          ListTile(
            title: Text('深色模式'),
            onTap: (){
              context.read<AppBloc>().changeThemeMode(ThemeMode.dark);
            },
            trailing: mode == ThemeMode.dark ? Icon(Icons.check, size: 20, color: iconColor) : null,
          )
        ],
      ),
    );;
  }
}
