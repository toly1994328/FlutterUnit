import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com
/// 说明: 
//    {
//      "widgetId": 199,
//      "name": 'TextFormField基本使用',
//      "priority": 1,
//      "subtitle":
//          "    基本属性和TextField一致，详见之\n"
//          "【validator】 : 验证函数   【FormFieldValidator<String> 】\n"
//          "【onFieldSubmitted】 : 提交回调   【ValueChanged<String>】\n"
//          "【onSaved】 : 表单save时回调  【FormFieldSetter<String>】",
//    }
class CustomTextFormField extends StatefulWidget {
  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _formKey,
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
                    onFieldSubmitted: _onFieldSubmitted,
                    onSaved: _onSaved,
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
  _onSaved(value){
    print('onSaved:'+value);
  }

  void _onFieldSubmitted(value) {
    print('onFieldSubmitted:'+value);
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
    _formKey.currentState.save();
    if (_formKey.currentState.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}