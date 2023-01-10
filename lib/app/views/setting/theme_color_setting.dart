import 'package:app_config/app_config.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:components/toly_ui/toly_ui.dart';

import 'package:flutter_unit/components/permanent/circle.dart';

/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明:

class ThemeColorSettingPage extends StatelessWidget {
  const ThemeColorSettingPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UnitColor.scaffoldBgLight,
      appBar: const UnitAppbar(title:'主题色设置'),
      body: BlocBuilder<AppBloc, AppState>(
          builder: (_, state) => _buildCell(
              context, Cons.kThemeColorSupport.keys.toList(), state.themeColor)),
    );
  }

  Widget _buildCell(
      BuildContext context, List<MaterialColor> themeColorSupport, MaterialColor color) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: themeColorSupport
          .map((MaterialColor c) => FeedbackWidget(
              a: 0.95,
              duration: const Duration(milliseconds: 200),
              onPressed: () => BlocProvider.of<AppBloc>(context).switchThemeColor(c),
              child: GridTile(
                  header: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: color == c
                          ? Colors.blue.withAlpha(88):
                      Colors.grey.withAlpha(55),
                    ),
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Spacer(),
                        Text(colorString(c),
                            style: const TextStyle(
                              color: Colors.white,
                            )),
                        const Spacer(),
                        if (color == c) const Padding(
                          padding: EdgeInsets.only(right:8.0),
                          child: Circle(color: Colors.white,radius: 7,),
                        )
                      ],
                    ),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(colors: [
                        c.shade50,
                        c.shade100,
                        c.shade200,
                        c.shade300,
                        c.shade400,
                        c.shade500,
                        c.shade600,
                        c.shade700,
                        c.shade800,
                        c.shade900,
                      ])),
                      alignment: const Alignment(0,0.35),
                      child: Text(
                        '${Cons.kThemeColorSupport[c]}',
                        style: const TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
                      )),
              )))
          .toList(),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
