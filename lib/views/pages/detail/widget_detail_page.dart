import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_state.dart';
import 'package:flutter_unit/components/panel/panel.dart';
import 'package:flutter_unit/model/node_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/widgets/widgets_map.dart';

class WidgetDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
      if (state is DetailWithData) {
        return Scaffold(
          appBar: AppBar(title: Text(state.widgetModel.name)),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildLeft(state.widgetModel),
                      _buildRight(state.widgetModel),
                    ],
                  ),
                  Divider(),
                  _buildNodes(state.nodes, state.widgetModel.name)
                ],
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }

  // 构建上部左侧介绍
  Widget _buildLeft(WidgetModel model) => Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20),
              child: Text(
                model.name,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff1EBBFD),
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Panel(child: Text(model.info)),
            )
          ],
        ),
      );

  // 构建上部右侧图片
  Widget _buildRight(WidgetModel model) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                  tag: "hero_widget_image_${model.name}",
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Image(image: model.image))),
            ),
          ),
          StarScore(
            score: model.lever,
            star: Star(size: 15, fillColor: Colors.blue),
          )
        ],
      );

  //构建底部 元素
  Widget _buildNodes(List<NodeModel> nodes, String name) => Column(
      children: nodes
          .asMap()
          .keys
          .map((i) => NodePanel(
                text: nodes[i].name,
                subText: nodes[i].subtitle,
                code: nodes[i].code,
                show: WidgetsMap.map(name)[i],
              ))
          .toList());
}
