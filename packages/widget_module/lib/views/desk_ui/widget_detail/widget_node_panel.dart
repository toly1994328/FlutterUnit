import 'package:app/app.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import 'package:toggle_rotate/toggle_rotate.dart';
import 'package:utils/utils.dart';


/// create by 张风捷特烈 on 2020-04-13
/// contact me by email 1981462002@qq.com
/// 说明: 一个Widget的知识点对应的界面

class DeskWidgetNodePanel extends StatefulWidget {
  final String text;
  final String subText;
  final String code;
  final Widget? show;
  final HighlighterStyle? codeStyle;
  final String? codeFamily;
  final bool death;

  const DeskWidgetNodePanel(
      {Key? key, this.text='',
      this.subText='',
      this.code='',
      this.death=false,
      this.show,
     required this.codeStyle,
      this.codeFamily}) : super(key: key);

  @override
  _DeskWidgetNodePanelState createState() => _DeskWidgetNodePanelState();
}

class _DeskWidgetNodePanelState extends State<DeskWidgetNodePanel> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  Color get themeColor => Theme.of(context).primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildNodeTitle(),

          const SizedBox(
            height: 20,
          ),
          _buildCode(context),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: widget.show,
                  ),
                ),
              ),
              if(!widget.death)
                Expanded(child: _buildNodeInfo()),
            ],
          ),

          const SizedBox(height: 16,),

          const Divider(),
        ],
      ),
    );
  }

  Widget buildNodeTitle() => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Circle(
              color: themeColor,
              radius: 5,
            ),
          ),
          Expanded(
            child: Text(
              widget.text,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          _buildShareButton(),
          _buildCodeButton(),
        ],
      );

  Widget _buildNodeInfo() => SizedBox(
        width: double.infinity,
        child: Panel(
          color: Color(0x33E5EAE1),
            child: Text(
          widget.subText,
          style: const TextStyle(fontSize: 12),
        )),
      );

  Widget _buildCodeButton() => Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: ToggleRotate(
          durationMs: 300,
          child: Icon(
            TolyIcon.icon_code,
            color: themeColor,
          ),
          onTap: _toggleCodePanel,
        ),
      );

  Widget _buildShareButton() => FeedbackWidget(
        mode: FeedMode.fade,
        a: 0.4,
        onPressed: _doShare,
        child: Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Icon(
            Icons.copy,
            size: 20,
            color: themeColor,
          ),
        ),
      );

  Widget _buildCode(BuildContext context) => AnimatedCrossFade(
        firstCurve: Curves.easeInCirc,
        secondCurve: Curves.easeInToLinear,
        firstChild: const SizedBox(),
        secondChild: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: CodeWidget(
            fontFamily: widget.codeFamily,
            code: isFirst?'':widget.code,
            style: widget.codeStyle ??
                HighlighterStyle.fromColors(HighlighterStyle.lightColor),
          ),
        ),
        duration: const Duration(milliseconds: 200),
        crossFadeState: _crossFadeState,
      );

  //执行分享
  _doShare() async{
    // Share.share(widget.code);
   await Clipboard.setData(ClipboardData(text: widget.code));
   Toast.success(context, '代码复制成功!');
  }

  // 折叠代码面板
  _toggleCodePanel() {
    setState(() {
      _crossFadeState =
          !isFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }
}
