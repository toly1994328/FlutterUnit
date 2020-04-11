import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_star/flutter_star.dart';
import 'package:flutter_unit/app/res/cons.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/blocs/collect/collect_bloc.dart';
import 'package:flutter_unit/blocs/collect/collect_event.dart';
import 'package:flutter_unit/blocs/collect/collect_state.dart';
import 'package:flutter_unit/blocs/detail/detail_bloc.dart';
import 'package:flutter_unit/blocs/detail/detail_event.dart';
import 'package:flutter_unit/blocs/detail/detail_state.dart';
import 'package:flutter_unit/blocs/global/global_bloc.dart';
import 'package:flutter_unit/blocs/widgets/widget_bloc.dart';
import 'package:flutter_unit/blocs/widgets/widget_event.dart';
import 'package:flutter_unit/components/feedback_widget.dart';
import 'package:flutter_unit/components/panel/panel.dart';
import 'package:flutter_unit/model/node_model.dart';
import 'package:flutter_unit/model/widget_model.dart';
import 'package:flutter_unit/views/widgets/widgets_map.dart';

class WidgetDetailPage extends StatefulWidget {
  @override
  _WidgetDetailPageState createState() => _WidgetDetailPageState();
}

class _WidgetDetailPageState extends State<WidgetDetailPage> {
  List<WidgetModel> stack;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailState>(builder: (context, state) {
      if (state is DetailWithData) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(colors[state.widgetModel.family.index]),
            title: Text(state.widgetModel.name),
            actions: <Widget>[
              FeedbackWidget(
                onPressed: () async {
                  BlocProvider.of<CollectBloc>(context).add(ToggleCollectEvent(
                      id: state.widgetModel.id,
                      isCollect: !state.widgetModel.collected));
//                    BlocProvider.of<WidgetBloc>(context)
//                        .add(LoadWidget(state.widgetModel.family));
                },
                child: BlocBuilder<CollectBloc, CollectState>(builder: (_, s) {
//                  print(s.widgets.contains(state.widgetModel));
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      s.widgets.contains(state.widgetModel)
                          ? TolyIcon.icon_star_ok
                          : TolyIcon.icon_star_add,
                      size: 25,
                    ),
                  );
                }),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildLeft(state.widgetModel),
                      _buildRight(state.widgetModel),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 5),
                        child: Icon(
                          Icons.link,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        '相关组件',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  _buildLinkTo(
                    context,
                    state.links,
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

  final List<int> colors = Cons.tabColors;

  Widget _buildLeft(WidgetModel model) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20),
              child: Text(
                model.nameCN,
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
                      child: model.image == null
                          ? Image.asset('assets/images/caver.jpeg')
                          : Image(image: model.image))),
            ),
          ),
          StarScore(
            score: model.lever,
            star: Star(size: 15, fillColor: Colors.blue),
          )
        ],
      );

  Widget _buildNodes(List<NodeModel> nodes, String name) {
    var globalState = BlocProvider.of<GlobalBloc>(context).state;

    return Column(
      children: nodes
          .asMap()
          .keys
          .map((i) => NodePanel(
                codeStyle: Cons.codeThemeSupport.keys.toList()[globalState.codeStyleIndex],
                codeFamily: 'Inconsolata',
                text: nodes[i].name,
                subText: nodes[i].subtitle,
                code: nodes[i].code,
                show: WidgetsMap.map(name)[i],
              ))
          .toList());
  }

  _buildLinkTo(BuildContext context, List<WidgetModel> links) {
    if (links == null || links.isEmpty) {
      return Padding(
          padding: EdgeInsets.only(left: 10),
          child: Chip(
            backgroundColor: Colors.grey.withAlpha(120),
            labelStyle: TextStyle(fontSize: 12, color: Colors.white),
            label: Text('暂无链接组件'),
          ));
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 10),
        child: Wrap(
          spacing: 5,
          children: links
              .map((e) => ActionChip(
                    onPressed: () {
                      BlocProvider.of<DetailBloc>(context)
                          .add(FetchWidgetDetail(e));
                    },
                    elevation: 3,
                    shadowColor: Color(colors[e.family.index]),
                    backgroundColor: Colors.blue,
                    labelStyle: TextStyle(fontSize: 12, color: Colors.white),
                    label: Text('${e.name}'),
                  ))
              .toList(),
        ),
      );
    }
  }
}
