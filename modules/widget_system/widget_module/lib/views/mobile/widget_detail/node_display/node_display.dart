import 'package:flutter/material.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:tolyui/tolyui.dart';
import 'package:widget_module/data/model/model.dart';
import 'package:widget_module/views/mobile/widget_detail/node_display/code_display.dart';
import 'package:widgets/widgets.dart';

import 'node_title.dart';

class NodeDisplay extends StatelessWidget {
  final NodeModel node;
  final int nodeIndex;
  final WidgetModel widget;
  final HighlighterStyle style;

  const NodeDisplay({
    super.key,
    required this.node,
    required this.nodeIndex,
    required this.style,
    required this.widget,
  });

  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          NodeTitle(
            text: node.name,
          ),
          const SizedBox(height: 10),
          CodeDisplay(display: mapNode(node), code: node.code, style: style),
          if(!widget.death)
            _buildNodeInfo(primaryColor),
        ],
      ),
    );
  }
  Widget _buildNodeInfo(Color primaryColor) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: SizedBox(
      width: double.infinity,
      child: Panel(
          color: primaryColor.withOpacity(0.04),
          child: Text(
            node.subtitle,
            style: const TextStyle(fontSize: 12),
          )),
    ),
  );
  Widget mapNode(NodeModel node){
    NodeType type = node.type(widget.name);
    Widget display = WidgetsMap.map(widget.name)[nodeIndex];
    return switch(type){
      NodeType.display => display,
      NodeType.newPage => newPageDisplay(display),
      NodeType.description => display,
      NodeType.deprecated => display,
    };
  }


  Widget newPageDisplay(Widget page){
   return Builder(
     builder:(ctx) => ElevatedButton(
        onPressed: () {
          Navigator.of(ctx).push(MaterialPageRoute(builder: (_)=>page));
        },
        child: Wrap(
          spacing: 6,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(Icons.open_in_new,size: 16,),
            Text('新界面打开'),
          ],),
        style: FillButtonPalette(
          foregroundPalette: Palette.all(Colors.white),
          borderRadius: BorderRadius.circular(6),
          backgroundPalette: const Palette(
            normal: Color(0xff1890ff),
            hover: Color(0xff40a9ff),
            pressed: Color(0xff096dd9),
          ),
        ).style,
      ),
   );
  }
}
