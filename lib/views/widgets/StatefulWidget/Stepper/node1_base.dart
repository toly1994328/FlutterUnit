import 'package:flutter/material.dart';

/// create by 张风捷特烈 on 2020-04-01
/// contact me by email 1981462002@qq.com
/// 说明:
//    {
//      "widgetId": 200,
//      "name": 'Stepper基本使用',
//      "priority": 1,
//      "subtitle":
//          "【steps】 : 步骤列表   【List<Step>】\n"
//          "【currentStep】 : 当前步骤   【double】\n"
//          "【onStepTapped】 : 点击回调   【ValueChanged<int>】\n"
//          "【onStepCancel】 : 上一步回调  【VoidCallback】\n"
//          "【controlsBuilder】 : 控制器构造  【ControlsWidgetBuilder】",
//    }
class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _position = 0;

  final stepsData = {
    "填写表单":'请按表单填写个人信息。',
    "邮箱校验":'已将邮件发送至您的邮箱，请按照相关指示对您的账号进行邮箱校验。',
    "注册完成":'恭喜您，注册完成！',
  };

  final steps = [
    Step(
      title: Text("填写表单"),
      content: Container(height: 60, child: Text("请按表单填写个人信息")),
    ),
    Step(title: Text("邮箱校验"), content: Text("请对您的账号进行邮箱校验")),
    Step(title: Text("注册完成"), content: Text("恭喜您，注册完成")),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Stepper(
          type:StepperType.horizontal,
          currentStep: _position,
          onStepTapped: (index) {
            setState(() {
              _position = index;
            });
          },
          onStepContinue: () {
            setState(() {
              if (_position < 2) {
                _position++;
              }
            });
          },
          onStepCancel: () {
            if (_position > 0) {
              setState(() {
                _position--;
              });
            }
          },
          controlsBuilder: (_,
              {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  color: Colors.blue,
                  shape: CircleBorder(
                    side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                  ),
                  onPressed: onStepContinue,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: CircleBorder(
                    side: BorderSide(width: 2.0, color: Color(0xFFFFDFDFDF)),
                  ),
                  onPressed: onStepCancel,
                  child: Icon(
                    Icons.keyboard_backspace,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
          steps: stepsData.keys.map((e){
            bool isActive = stepsData.keys.toList().indexOf(e) ==_position;
            return Step(
            title: Text(e,style: TextStyle(color: isActive?Colors.blue:Colors.black),),
            isActive: isActive,
            state: _getState(stepsData.keys.toList().indexOf(e)),
            content: Container(height: 60, child: Text(stepsData[e])),
          );
          }).toList()),
    );
  }
  _getState(index){
    if(_position==index) return StepState.editing;
    if(_position>index) return StepState.complete;
    return StepState.indexed;
  }
}
