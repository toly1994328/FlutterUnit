import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/style/unit_color.dart';
import 'package:flutter_unit/app/utils/color_utils.dart';
import 'package:flutter_unit/blocs/category/category_bloc.dart';
import 'package:flutter_unit/blocs/category/category_event.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/components/project/color_chooser.dart';
import 'package:flutter_unit/views/common/unit_drawer_header.dart';
import 'package:flutter_unit/components/permanent/input_button.dart';
import 'package:flutter_unit/components/permanent/edit_panel.dart';

import 'edit_category_panel.dart';

class HomeRightDrawer extends StatefulWidget {
  final Color color;

  HomeRightDrawer({this.color});

  @override
  _HomeRightDrawerState createState() => _HomeRightDrawerState();
}

class _HomeRightDrawerState extends State<HomeRightDrawer> {
  String name;
  String color;
  String info;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 3,
      child: _buildChild(context),
    );
  }

  Widget _buildChild(BuildContext context) => Container(
        color: widget.color.withAlpha(33),
        child: ListView(padding: EdgeInsets.zero, children: <Widget>[
          UnitDrawerHeader(color:widget.color),
          _buildTitle(context),
          EditCategoryPanel()
        ]),
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

//class EditCategoryPanel extends StatefulWidget {
//  @override
//  _EditCategoryPanelState createState() => _EditCategoryPanelState();
//}
//
//class _EditCategoryPanelState extends State<EditCategoryPanel> {
//  String name;
//  String color;
//  String info;
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//          child: InputButton(
//            config: InputButtonConfig(hint: '收藏集名称', iconData: Icons.check),
//            onSubmit: (str) {
//              name = str;
//              if(name.isNotEmpty){
//                BlocProvider.of<CategoryBloc>(context)
//                    .add(EventAddCategory(name: name, info: info, color: color));
//              }
//              Navigator.of(context).pop();
//            },
//          ),
//        ),
//        Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//          child: EditPanel(
//            submitClear: false,
//            hint: '收藏集简介...',
//            onChange: (v) => info = v,
//          ),
//        ),
//        Container(
//          alignment: Alignment.center,
//          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//          child: ColorChooser(
//            defaultIndex: 0,
//            colors: UnitColor.collectColorSupport,
//            onChecked: (v) => color = ColorUtils.colorString(v),
//          ),
//        ),
//      ],
//    );
//  }
//}

