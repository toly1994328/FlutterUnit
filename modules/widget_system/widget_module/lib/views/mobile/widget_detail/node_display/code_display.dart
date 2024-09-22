import 'dart:math';

import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:toly_ui/code/code.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:tolyui/tolyui.dart';

// import 'package:flutter_highlight/flutter_highlight.dart';
import 'collapse.dart';

class CodeDisplay extends StatefulWidget {
  final Widget display;
  final HighlighterStyle style;
  final String code;

  const CodeDisplay({
    super.key,
    required this.display,
    required this.code,
    required this.style,
  });

  @override
  State<CodeDisplay> createState() => _CodeDisplayState();
}

class _CodeDisplayState extends State<CodeDisplay> {
  String? codeRes;

  void _loadAssets() async {
    codeRes = await codeData();
    setState(() {});
  }

  Future<String> codeData() async {
    if (widget.code.startsWith('assets')) {
      return await rootBundle.loadString(widget.code);
    } else {
      return widget.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Theme.of(context).listTileTheme.tileColor,
          border: Border.all(
            color: Theme.of(context).dividerTheme.color ?? Colors.grey,
            width: Theme.of(context).dividerTheme.space ?? 1,
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.05),spreadRadius: 1,blurRadius: 4)
          ],
          borderRadius: BorderRadius.circular(4)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
            child: widget.display,
          ),
          const Divider(),
          TolyCollapse(
            titleBuilder: _buildTitle,
            sizeCurve: Curves.ease,
            content: CodeWidget(
              code: widget.code,
              style: widget.style,
            ),
            duration: const Duration(milliseconds: 500),
          )
        ],
      ),
    );
  }
  _doShare() {
    Share.share(widget.code);
  }
  Widget _buildTitle(BuildContext context, Animation<double> anima, CollapseController ctrl) {
    Color color = Theme.of(context).primaryColor;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
        child: Row(
          children: [
            const Spacer(),
            FeedbackWidget(
              mode: FeedMode.fade,
              a: 0.4,
              onPressed: _doShare,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  TolyIcon.icon_share,
                  size: 20,
                  color: color,
                ),
              ),
            ),
            FeedbackWidget(
              mode: FeedMode.fade,
              a: 0.4,
              onPressed: _copyCode,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10,
                ),
                child: Icon(
                  Icons.copy_rounded,
                  size: 20,
                  color: color,
                ),
              ),
            ),
            GestureDetector(
                onTap: () => _toggleCode(ctrl),
                child: AnimatedBuilder(
                  animation: anima,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: pi / 2 * Curves.ease.transform(anima.value),
                      child: Icon(
                        TolyIcon.icon_code,
                        color: color,
                      ),
                    );
                  },
                )),
          ],
        ));
  }


  void _toggleCode(CollapseController ctrl) {
    if (!ctrl.isOpen) {
      _loadAssets();
    } else {
      codeRes = null;
    }
    ctrl.toggle();
  }

  void _copyCode() async {
    String code = await codeData();
    await Clipboard.setData(ClipboardData(text: code));
    $message.success(message: '代码复制成功!');
  }
}

const githubTheme = {
  'root': TextStyle(color: Color(0xff333333), backgroundColor: Colors.transparent),
  'comment': TextStyle(color: Color(0xff999988), fontStyle: FontStyle.italic),
  'quote': TextStyle(color: Color(0xff999988), fontStyle: FontStyle.italic),
  'keyword': TextStyle(color: Color(0xff333333), fontWeight: FontWeight.bold),
  'selector-tag': TextStyle(color: Color(0xff333333), fontWeight: FontWeight.bold),
  'subst': TextStyle(color: Color(0xff333333), fontWeight: FontWeight.normal),
  'number': TextStyle(color: Color(0xff008080)),
  'literal': TextStyle(color: Color(0xff008080)),
  'variable': TextStyle(color: Color(0xff008080)),
  'template-variable': TextStyle(color: Color(0xff008080)),
  'string': TextStyle(color: Color(0xffdd1144)),
  'doctag': TextStyle(color: Color(0xffdd1144)),
  'title': TextStyle(color: Color(0xff990000), fontWeight: FontWeight.bold),
  'section': TextStyle(color: Color(0xff990000), fontWeight: FontWeight.bold),
  'selector-id': TextStyle(color: Color(0xff990000), fontWeight: FontWeight.bold),
  'type': TextStyle(color: Color(0xff445588), fontWeight: FontWeight.bold),
  'tag': TextStyle(color: Color(0xff000080), fontWeight: FontWeight.normal),
  'name': TextStyle(color: Color(0xff000080), fontWeight: FontWeight.normal),
  'attribute': TextStyle(color: Color(0xff000080), fontWeight: FontWeight.normal),
  'regexp': TextStyle(color: Color(0xff009926)),
  'link': TextStyle(color: Color(0xff009926)),
  'symbol': TextStyle(color: Color(0xff990073)),
  'bullet': TextStyle(color: Color(0xff990073)),
  'built_in': TextStyle(color: Color(0xff0086b3)),
  'builtin-name': TextStyle(color: Color(0xff0086b3)),
  'meta': TextStyle(color: Color(0xff999999), fontWeight: FontWeight.bold),
  'deletion': TextStyle(backgroundColor: Color(0xffffdddd)),
  'addition': TextStyle(backgroundColor: Color(0xffddffdd)),
  'emphasis': TextStyle(fontStyle: FontStyle.italic),
  'strong': TextStyle(fontWeight: FontWeight.bold),
};
