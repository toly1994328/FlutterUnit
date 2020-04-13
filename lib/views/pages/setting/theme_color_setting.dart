import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/global/global_event.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/permanent/circle.dart';

/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明:

class ThemeColorSettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('主题色设置'),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (_, state) => _buildFontCell(
              context, Cons.themeColorSupport.keys.toList(), state.themeColor)),
    );
  }

  Widget _buildFontCell(
      BuildContext context, List<MaterialColor> themeColorSupport, MaterialColor color) {
    return GridView.count(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: themeColorSupport
          .map((e) => FeedbackWidget(
              a: 0.95,
              duration: Duration(milliseconds: 200),
              onPressed: () => BlocProvider.of<GlobalBloc>(context).add(EventSwitchThemeColor(e)),
              child: GridTile(
                  header: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10)),
                      color: color == e
                          ? Colors.blue.withAlpha(88):
                      Colors.grey.withAlpha(55),
                    ),
                    padding: EdgeInsets.only(left: 10, right: 5),
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(),
                        Text(colorString(e),
                            style: TextStyle(
                              color: Colors.white,
                            )),
                        Spacer(),
                        if (color == e) Padding(
                          padding: const EdgeInsets.only(right:8.0),
                          child: Circle(color: Colors.white,radius: 7,),
                        )
                      ],
                    ),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                          gradient: LinearGradient(colors: [
                        e[50],
                        e[100],
                        e[200],
                        e[300],
                        e[400],
                        e[500],
                        e[600],
                        e[700],
                        e[800],
                        e[900],
                      ])),
                      alignment: Alignment(0,0.35),
                      child: Text(
                        Cons.themeColorSupport [e],
                        style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),
                      )),
              )))
          .toList(),
    );
  }

  String colorString(Color color) =>
      "#${color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}";
}
