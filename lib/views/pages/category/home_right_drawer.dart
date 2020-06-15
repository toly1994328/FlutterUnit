import 'package:flutter/material.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/views/common/unit_drawer_header.dart';

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
