import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明:


void showAppStyleSelectDialog(BuildContext context) {
  // List<String> data = Cons.kAppStyleStringMap.values.toList();
  showCupertinoModalPopup(
      context: context,
      builder: (context) => AppThemeSettingDialog(
        data: [],
      ));
}

class AppThemeSettingDialog extends StatelessWidget {
  final List<String> data;


  const AppThemeSettingDialog({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: 350,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                '选择应用风格样式',
                style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Divider(height: 1,),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: _buildItem,
                itemCount: data.length,
              ),
            )
          ],
        ),
        // color: Colors.orange,
      ),
    );
  }

  Widget? _buildItem(BuildContext context, int index) {
    // AppStyle locale = Cons.kAppStyleStringMap.keys.toList()[index];
    // AppStyle style = BlocProvider.of<AppBloc>(context).state.appStyle;
    // bool checked = style == locale;
    // Color color = Theme.of(context).primaryColor;
    // return ListTile(
    //   title: Text(data[index]),
    //   onTap: () => _onSelect(context, index),
    //   trailing: checked ? Icon(Icons.check, size: 20, color: color) : null,
    // );
  }
  void _onSelect(BuildContext context, int index) {
    // AppStyle appStyle = Cons.kAppStyleStringMap.keys.toList()[index];
    // BlocProvider.of<AppBloc>(context).changeThemeMode(appStyle);
    // Navigator.of(context).pop();
  }
}
