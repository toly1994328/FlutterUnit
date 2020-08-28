
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

class FontSettingPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('字体设置 - font setting'),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (_, state) => _buildFontCell(
              context, Cons.fontFamilySupport, state.fontFamily)),
    );
  }

  Widget _buildFontCell(
      BuildContext context, List<String> fontFamilySupport, String fontFamily) {
    return GridView.count(
      padding: EdgeInsets.only(top: 20, left: 10, right: 10),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: fontFamilySupport
          .map((e) => FeedbackWidget(
              a: 0.95,
              duration: Duration(milliseconds: 200),
              onPressed: () {
                BlocProvider.of<GlobalBloc>(context)
                    .add(EventSwitchFontFamily(e));
              },
              child: Card(
                child: GridTile(
                  header: Container(
                    padding: EdgeInsets.only(left: 10, right: 5),
                    height: 30,
                    color: fontFamily == e
                        ? Colors.blue.withAlpha(88)
                        : Colors.grey.withAlpha(88),
                    child: Row(
                      children: <Widget>[
                        Text(e,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: e,
                            )),
                        Spacer(),
                        if (fontFamily == e) Circle(color: Theme.of(context).primaryColor,)
                      ],
                    ),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(colors: [
                        Colors.blueAccent.withAlpha(22),
                        Colors.blueAccent.withAlpha(22),
                        Theme.of(context).primaryColor.withAlpha(88)
                      ])),
                      alignment: Alignment(0, 0.4),
                      child: Text(
                        '张风捷特烈\n@toly1994',
                        style: TextStyle(fontFamily: e, fontSize: 16),
                      )),
                ),
              )))
          .toList(),
    );
  }
}
