import 'package:flutter/material.dart';
import 'package:flutter_unit/components/panel/panel.dart';

class PlaceholderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      NodePanel(
          code: """class CustomPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100*0.618,
      child:  Placeholder(
          color: Colors.blue,
          strokeWidth: 2,
        ),
    );
  }
}""",
          show: CustomPlaceholder(),
          text: "Placeholder基础属性",
          subText:
          "【color】: 颜色   【Color】\n"
              "【strokeWidth】: 线粗   【double】"
      ),
      NodePanel(
          code: """class FallbackPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child:  Placeholder(
        color: Colors.blue,
        strokeWidth: 2,
          fallbackHeight: 100,
          fallbackWidth: 150,
      ),
    );
  }
}""",
          show: FallbackPlaceholder(),
          text: "Placeholder的fallback属性",
          subText:
          "当所在区域无宽高约束时，占位组件的宽高。"
          "【fallbackHeight】: 高   【double】\n"
              "【fallbackWidth】: 宽   【double】"
      ),
    ]);
  }
}

class CustomPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100*0.618,
      child:  Placeholder(
          color: Colors.orangeAccent,
          strokeWidth: 2,
        ),
    );
  }
}
class FallbackPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child:  Placeholder(
        color: Colors.blue,
        strokeWidth: 2,
          fallbackHeight: 100,
          fallbackWidth: 150,
      ),
    );
  }
}
