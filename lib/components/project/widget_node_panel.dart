import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_unit/app/style/TolyIcon.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/components/permanent/circle.dart';
import 'package:flutter_unit/components/permanent/code/code_panel.dart';
import 'package:flutter_unit/components/permanent/panel.dart';
import 'package:share/share.dart';
import 'package:toggle_rotate/toggle_rotate.dart';

import '../permanent/feedback_widget.dart';
import '../permanent/code/highlighter_style.dart';

/// create by 张风捷特烈 on 2020-04-13
/// contact me by email 1981462002@qq.com
/// 说明: 

class WidgetNodePanel extends StatefulWidget {
  final String text;
  final String subText;
  final String code;
  final Widget show;
  final HighlighterStyle codeStyle;
  final String codeFamily;

  WidgetNodePanel({this.text, this.subText, this.code, this.show,this.codeStyle,this.codeFamily});

  @override
  _WidgetNodePanelState createState() => _WidgetNodePanelState();
}

class _WidgetNodePanelState extends State<WidgetNodePanel>
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
//                  await Clipboard.setData(ClipboardData(text: widget.code));
//                  Toast.toast(context, '复制成功!');
                  Share.share(widget.code);
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Icon(
                    TolyIcon.icon_share,
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