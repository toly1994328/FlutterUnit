import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/enums.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/global/global_event.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/components/permanent/code/code_panel.dart';
import 'package:flutter_unit/components/permanent/code/highlighter_style.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/items/coupon_widget_list_item.dart';
import 'package:flutter_unit/views/items/techno_widget_list_item.dart';

/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明:


class ItemStyleSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('item样式设置'),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(
          builder: (_, state) => _buildFontCell(context, state.itemStyleIndex)),
    );
  }

  final items = [
    TechnoWidgetListItem(data: getContainer()),
    CouponWidgetListItem(data: getContainer()),
    CouponWidgetListItem(hasTopHole:false,data: getContainer()),
    CouponWidgetListItem(hasTopHole:true,hasBottomHole:true,data: getContainer()),
  ];

 static WidgetModel getContainer()=> WidgetModel(
      name: 'Container',
      nameCN: Random().nextDouble().toString(),
      lever: 5,
      family: WidgetFamily.statelessWidget,
      info: '用于容纳单个子组件的容器组件。集成了若干个单子组件的功能，如内外边距、形变、装饰、约束等...');



  Widget _buildFontCell(BuildContext context, int index) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) => Padding(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            child: FeedbackWidget(
                a: 0.95,
                duration: Duration(milliseconds: 200),
                onPressed: () {
                  BlocProvider.of<GlobalBloc>(context)
                      .add(EventChangeItemStyle(i));
                },
                child: Stack(
                  children: <Widget>[
                    items[i],
                    if (index == i)
                      Positioned(
                        left: 15,
                        top: 15,
                        child: Circle(
                          color: Theme.of(context).primaryColor,
                          radius: 10,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 15,
                          ),
                        ),
                      )
                  ],
                ))));
  }
}
