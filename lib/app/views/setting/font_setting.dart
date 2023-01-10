import 'package:app_config/app_config.dart';
import 'package:components/components.dart';
import 'package:components/toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_unit/components/permanent/circle.dart';

/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明:

class FontSettingPage extends StatelessWidget {
  const FontSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UnitColor.scaffoldBgLight,
      appBar: const UnitAppbar(title: '字体设置 - font setting'),
      body: BlocBuilder<AppBloc, AppState>(
          builder: (_, state) => _buildFontCell(
              context, Cons.kFontFamilySupport, state.fontFamily)),
    );
  }

  Widget _buildFontCell(
      BuildContext context, List<String> fontFamilySupport, String fontFamily) {
    return GridView.count(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: fontFamilySupport
          .map((e) => FeedbackWidget(
              a: 0.95,
              duration: const Duration(milliseconds: 200),
              onPressed: () {
                BlocProvider.of<AppBloc>(context).switchFontFamily(e);
              },
              child: Card(
                child: GridTile(
                  header: Container(
                    padding: const EdgeInsets.only(left: 10, right: 5),
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
                        const Spacer(),
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
                      alignment: const Alignment(0, 0.4),
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
