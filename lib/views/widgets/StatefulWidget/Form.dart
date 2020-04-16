import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-03-31
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 198,
//      "name": 'Form基本使用',
//      "priority": 1,
//      "subtitle":
//          "【child】 : 子组件   【Widget】\n"
//          "【onChanged】 : 表单变化回调   【VoidCallback】\n"
//          "【onWillPop】 : 返回回调  【WillPopCallback】",
//    }
class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        onWillPop: () => _willPop(context),
        key: _formKey,
        onChanged: () {
          print('Form---onChanged');
        },
        child:
            Stack(
              alignment: Alignment.centerRight,
              children: <Widget>[
                Container(
                  width: 350,
                  child: UnconstrainedBox(
                    child: Container(
                      width: 200,
                      height: 70,
                      child: TextFormField(
                        style: TextStyle(textBaseline: TextBaseline.alphabetic),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'username',
                        ),
                        validator: _validateUsername,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 0, right: 0, child: _buildSubmitButton(context)),
              ],
        ),
      ),
    );
  }

  String _validateUsername(value) {
    if (value.isEmpty) {
      return '用户名不能为空';
    }
    return null;
  }

  RaisedButton _buildSubmitButton(BuildContext context) {
    return RaisedButton(
      color: Colors.blue,
      shape: CircleBorder(
        side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
      ),
      onPressed: _onSubmit,
      child: Icon(
        Icons.check,
        color: Colors.white,
      ),
    );
  }

  _onSubmit(){
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
      Navigator.of(context).pop();
    }
  }

  Future<bool> _willPop(context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            title: Text('提示'),
            content: Text('你确定要离开此页吗?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('确定'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('取消'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
