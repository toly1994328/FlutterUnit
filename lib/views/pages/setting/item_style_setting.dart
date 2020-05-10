import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/global/global_event.dart';
import 'package:flutter_unit/blocs/global/global_state.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/views/items/home_item_support.dart';


/// create by 张风捷特烈 on 2020-04-10
/// contact me by email 1981462002@qq.com
/// 说明: item样式切换支持

class ItemStyleSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('item样式设置'),
      ),
      body: BlocBuilder<GlobalBloc, GlobalState>(builder: (_, state) {
        return _buildFontCell(context, state.itemStyleIndex);
      }),
    );
  }

  get items=> HomeItemSupport.itemSimples();

  Widget _buildFontCell(BuildContext context, int index) {
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (_, i) => FeedbackWidget(
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
                        left: 25,
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
                )));
  }
}
