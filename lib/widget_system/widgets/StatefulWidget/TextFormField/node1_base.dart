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
  const CustomTextFormField({Key? key}) : super(key: key);

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 40),
        Expanded(
          child: TextFormField(
            style: const TextStyle(textBaseline: TextBaseline.alphabetic),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'username',
            ),
            validator: _validateUsername,
            onFieldSubmitted: _onFieldSubmitted,
            onSaved: _onSaved,
          ),
        ),
        _buildSubmitButton(context),
      ],
    );
  }

  String? _validateUsername(value) {
    if (value.isEmpty) {
      return '用户名不能为空';
    }
    return null;
  }

  void _onSaved(value) {
    print('onSaved:' + value);
  }

  void _onFieldSubmitted(value) {
    print('onFieldSubmitted:' + value);
  }

  Widget _buildSubmitButton(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            shape: const CircleBorder(
              side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
            )),
        onPressed: _onSubmit,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      );

  void _onSubmit() {
    if (_formKey.currentState == null) return;
    _formKey.currentState!.save();
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).requestFocus(FocusNode());
    }
  }
}