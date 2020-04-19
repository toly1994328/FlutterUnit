import 'package:flutter/material.dart';
import 'package:flutter_unit/app/style/unit_color.dart';
import 'package:flutter_unit/app/style/unit_text_style.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/components/project/color_chooser.dart';
import 'package:flutter_unit/views/pages/collect/InputButton.dart';
import 'package:flutter_unit/views/pages/collect/edit_panel.dart';

class HoneRightDrawer extends StatelessWidget {
  final Color color;

  HoneRightDrawer({this.color});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) => Container(
        color: color.withAlpha(33),
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          _buildDrawerHeader(color),
          _buildTitle(context),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: InputButton(
              config: InputButtonConfig(hint: '收藏集名称', iconData: Icons.check),
              onSubmit: (str){
                Navigator.of(context).pop();
                Toast.toast(context, '收藏集功能正在开发中...',duration: Duration(seconds: 1));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: EditPanel(
              hint: '收藏集简介...',

            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: ColorChooser(
              defaultIndex: 0,
              colors: UnitColor.collectColorSupport,
              onChecked: (v) {},
            ),
          ),
        ]),
      );

  Widget _buildDrawerHeader(Color color) => DrawerHeader(
        padding: EdgeInsets.only(top: 10, left: 15),
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/wy_300x200_filter.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Wrap(
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                FlutterLogo(
                  colors: Colors.orange,
                  size: 35,
                ),
                Text(
                  'Flutter Unit',
                  style: TextStyle(fontSize: 24, color: Colors.white, shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(1, 1),
                        blurRadius: 3)
                  ]),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              'The Unity Of Flutter, The Unity Of Coder.',
              style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
                Shadow(color: color, offset: Offset(.5, .5), blurRadius: 1)
              ]),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'Flutter的联合，编程者的联合。',
              style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
                Shadow(color: color, offset: Offset(.5, .5), blurRadius: 1)
              ]),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                Spacer(
                  flex: 5,
                ),
                Text(
                  '—— 张风捷特烈',
                  style: TextStyle(fontSize: 15, color: Colors.white, shadows: [
                    Shadow(
                        color: Colors.orangeAccent,
                        offset: Offset(.5, .5),
                        blurRadius: 1)
                  ]),
                ),
                Spacer(
                  flex: 1,
                ),
              ],
            ),
          ],
        ),
      );

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Circle(
            color: Theme.of(context).primaryColor,
            radius: 5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '添加收藏集',
              style: TextStyle(fontSize: 16, shadows: [
                Shadow(
                    color: Colors.white, offset: Offset(.5, .5), blurRadius: 1)
              ]),
            ),
          ),
          Circle(
            color: Theme.of(context).primaryColor,
            radius: 5,
          ),
        ],
      ),
    );
  }
}
