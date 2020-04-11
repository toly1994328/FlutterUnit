import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/components/code/code_panel.dart';
import 'package:flutter_unit/components/code/highlighter_style.dart';
import 'package:flutter_unit/components/feedback_widget.dart';
import 'package:toggle_rotate/toggle_rotate.dart';

import 'circle.dart';

class Panel extends StatelessWidget {
  final double radius;
  final Color color;
  final Widget child;

  Panel({this.radius = 5.0, this.color, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color ?? Color(0xffF6F8FA),
          borderRadius: BorderRadius.all(Radius.circular(radius))),
    );
  }
}

class NodePanel extends StatefulWidget {
  final String text;
  final String subText;
  final String code;
  final Widget show;
  final HighlighterStyle codeStyle;
  final String codeFamily;

  NodePanel({this.text, this.subText, this.code, this.show,this.codeStyle,this.codeFamily});

  @override
  _NodePanelState createState() => _NodePanelState();
}

class _NodePanelState extends State<NodePanel>
    with SingleTickerProviderStateMixin {
  bool _showCode = false;

  var _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Circle(
                  color: Theme.of(context).primaryColor,
                  radius: 5,
                ),
              ),
              Expanded(
                child: Text(
                  '${widget.text}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              FeedbackWidget(
                mode: FeedMode.fade,
                a: 0.4,
                onPressed: () async {
                  await Clipboard.setData(ClipboardData(text: widget.code));
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text('复制成功!'),
                    duration: Duration(milliseconds: 600),
                    backgroundColor: Theme.of(context).primaryColor,
                  ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Icon(
                    Icons.content_copy,
                    size: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: ToggleRotate(
                  durationMs: 300,
                  child: Icon(
                    TolyIcon.icon_code,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    setState(() {
                      _crossFadeState = _showCode
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond;
                      _showCode = !_showCode;
                    });
                  },
                ),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _buildCode(context),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 20),
            child: widget.show,
          ),
          Container(
            width: double.infinity,
            child: Panel(
                child: Text(
              '${widget.subText}',
              style: TextStyle(fontSize: 14),
            )),
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _buildCode(BuildContext context) => AnimatedCrossFade(
        firstCurve: Curves.easeInCirc,
        secondCurve: Curves.easeInToLinear,
        firstChild: Container(),
        secondChild: Container(
          width: MediaQuery.of(context).size.width,
          child: CodeWidget(
            fontFamily: widget.codeFamily,
            code: widget.code,
            style: widget.codeStyle??HighlighterStyle.fromColors(
                HighlighterStyle.lightColor),
          ),
        ),
        duration: Duration(milliseconds: 500),
        crossFadeState: _crossFadeState,
      );
}
