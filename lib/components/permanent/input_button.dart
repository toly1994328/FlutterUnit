import 'package:flutter/material.dart';

typedef SubmitCallback = void Function(String str);

class InputButtonConfig {
  final double height; //高度
  final IconData iconData; //图标
  final String hint; //提示文字
  final double fontSize; //文字大小
  final Widget? front; //前面图标
  final bool submitClear; //是否提交清空

  const InputButtonConfig({
    this.height = 36,
    this.iconData = Icons.add,
    this.fontSize = 14,
    this.submitClear = true,
    this.front,
    this.hint = "I want to say...",
  });
}

class InputButton extends StatefulWidget {
  final SubmitCallback? onSubmit;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final InputButtonConfig config;
  final String defaultText;

  InputButton(
      {Key? key,
      this.onSubmit,
      this.onChanged,
      this.defaultText = '请输入',
      this.onTap,
      this.config = const InputButtonConfig()})
      : super(key: key);

  @override
  _InputButtonState createState() => _InputButtonState();
}

class _InputButtonState extends State<InputButton> {
  double _height = 0;
  double _fontSize = 0;
  Radius _radius = Radius.zero;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _height = widget.config.height;
    _fontSize = widget.config.fontSize;
    _radius = Radius.circular(_height / 3.6);
    _controller = TextEditingController(text: widget.defaultText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget textField = TextField(
      controller: _controller,
      maxLines: 1,
      style: TextStyle(
          fontSize: _fontSize,
          color: Colors.lightBlue,
          backgroundColor: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: widget.config.hint,
        hintStyle: TextStyle(color: Colors.black26, fontSize: _fontSize),
        contentPadding: EdgeInsets.only(left: 14.0, top: -_fontSize),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius:
              BorderRadius.only(topLeft: _radius, bottomLeft: _radius),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius:
              BorderRadius.only(topLeft: _radius, bottomLeft: _radius),
        ),
      ),
      onChanged: (str) {
        widget.onChanged?.call(str);
      },
      onTap: widget.onTap,
    );
    Widget btn = RaisedButton(

      elevation: 0,
      child: Icon(widget.config.iconData,color: Theme.of(context).primaryColor,),
      color: Color(0x99E0E0E0),
      padding: EdgeInsets.zero,
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode()); //收起键盘
        widget.onSubmit?.call(_controller.text);
        if (widget.config.submitClear) {
          setState(() {
            _controller.clear();
          });
        }
      },
    );
    Widget inputBtn = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Container(
            child: textField,
            height: _height,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              bottomLeft: Radius.zero,
              topRight: _radius,
              bottomRight: _radius),
          child: Container(
            child: btn,
            width: _height,
            height: _height,
          ),
        ),
      ],
    );
    return inputBtn;
  }
}
