import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'windows_font_status_card.dart';

/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明:

class FontSettingPage extends StatelessWidget {
  const FontSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigBloc, AppConfig>(
      builder: _buildPage,
    );
  }

  Widget _buildPage(BuildContext context, AppConfig state) => Scaffold(
      appBar: AppBar(
          title: Text(
        '字体设置 - font setting',
        style: TextStyle(fontFamily: state.fontFamily),
      )),
      body: Column(children: <Widget>[
        if (WindowsFontController.instance.supported)
          const WindowsFontStatusCard(),
        Expanded(
            child: _buildFontCell(
                context,
                Cons.kFontFamilySupport.where(_isSupported).toList(),
                state.fontFamily)),
      ]));

  bool _isSupported(String family) =>
      family != wenKaiLitePackage.family ||
      WindowsFontController.instance.supported;

  Widget _buildFontCell(
      BuildContext context, List<String> fontFamilySupport, String fontFamily) {
    Widget buildCell(String family) => FontCell(
        active: fontFamily == family,
        fontFamily: family,
        onSelect: (String selected) =>
            context.read<AppConfigBloc>().switchFontFamily(selected));
    return GridView.count(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      crossAxisCount: kIsDesk ? 4 : 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      childAspectRatio: 1.5,
      children: fontFamilySupport.map(buildCell).toList(),
    );
  }
}

class FontCell extends StatelessWidget {
  /// 当前字体是否被选中。
  final bool active;

  /// 用户选择字体后的回调。
  final ValueChanged<String> onSelect;

  /// 此卡片预览的字体族。
  final String fontFamily;

  const FontCell(
      {super.key,
      required this.active,
      required this.onSelect,
      required this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return FeedbackWidget(
        a: 0.95,
        duration: const Duration(milliseconds: 200),
        onPressed: () => onSelect(fontFamily),
        child: GridTile(
          header: Container(
            padding: const EdgeInsets.only(left: 10, right: 5),
            height: 30,
            color:
                active ? Colors.blue.withAlpha(88) : Colors.grey.withAlpha(88),
            child: Row(
              children: <Widget>[
                Text(
                    fontFamily == wenKaiLitePackage.family
                        ? '霞鹜文楷'
                        : fontFamily,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontFamily,
                    )),
                const Spacer(),
                if (active) Circle(color: Theme.of(context).primaryColor)
              ],
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                  gradient: LinearGradient(colors: [
                    Colors.blueAccent.withAlpha(22),
                    Colors.blueAccent.withAlpha(22),
                    Theme.of(context).primaryColor.withAlpha(88)
                  ])),
              alignment: const Alignment(0, 0.4),
              child: Text(
                '张风捷特烈\n@toly1994',
                style: TextStyle(fontFamily: fontFamily, fontSize: 16),
              )),
        ));
  }
}
