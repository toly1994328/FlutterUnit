import 'package:flutter/material.dart';

typedef ChangeCallback = void Function(String str);

///输入面板
class EditPanel extends StatefulWidget {
  const EditPanel(
      {Key? key,
      this.backgroundColor = Colors.white,
      this.color = Colors.lightBlue,
      this.minLines = 4,
      this.maxLines = 15,
      this.fontSize = 14,
      this.submitClear = true,
      this.defaultText = "",
      this.onChange,
      this.hint = "写点什么..."})
      : super(key: key);

  final Color color; //字颜色
  final Color backgroundColor; //背景色颜色
  final int minLines; //最小行数
  final int maxLines; //最大行数
  final double fontSize; //字号
  final String hint; //提示字
  final bool submitClear; //提交是否清空文字
  final ChangeCallback? onChange; //提交监听
  final String defaultText; //提交监听

  @override
  _EditPanelState createState() => _EditPanelState();
}

class _EditPanelState extends State<EditPanel> {
  Radius _radius=Radius.zero; //边角半径

  late TextEditingController _controller;

  @override
  void initState() {
    _radius = Radius.circular(widget.fontSize * 0.618);
    _controller = TextEditingController(text: widget.defaultText);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget panel = TextField(
      controller: _controller,
      //输入控制器
      keyboardType: TextInputType.text,
      //键盘类型
      textAlign: TextAlign.start,
      //文字居左
      cursorColor: Colors.black,
      //游标颜色
      minLines: widget.minLines,
      //最小行数
      maxLines: widget.maxLines,
      //最大行数
      style: TextStyle(
          //文字样式
          fontSize: widget.fontSize,
          color: widget.color,
          backgroundColor: Colors.white),
      decoration: InputDecoration(
        //装饰线
        filled: true,
        //是否填充
        fillColor: widget.backgroundColor,
        //填充色
        hintText: widget.hint,
        //提示文字
        hintStyle: TextStyle(color: Colors.black26, fontSize: widget.fontSize),
        //提示文字样式
        focusedBorder: UnderlineInputBorder(
          //聚焦时边线
          borderSide: BorderSide(color: widget.backgroundColor),
          borderRadius: BorderRadius.all(_radius),
        ),
        enabledBorder: UnderlineInputBorder(
          //非聚焦时边线
          borderSide: BorderSide(color: widget.backgroundColor),
          borderRadius: BorderRadius.all(_radius),
        ),
      ),
      onChanged: (str) {
        //文字变化监听
        widget.onChange?.call(str);
      },
      onSubmitted: (str) {
        //提交监听
        FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
        if (widget.submitClear) {
          setState(() {
            _controller.clear();
          });
        }
      },
    );
    return panel;
  }
}
