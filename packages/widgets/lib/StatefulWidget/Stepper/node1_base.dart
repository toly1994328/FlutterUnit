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
  const StepperDemo({Key? key}) : super(key: key);

  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _position = 0;

  final Map<String, String> stepsData = {
    "填写表单": '请按表单填写个人信息。',
    "邮箱校验": '已将邮件发送至您的邮箱，请按照相关指示对您的账号进行邮箱校验。',
    "注册完成": '恭喜您，注册完成！',
  };

  final List<Step> steps = const [
    Step(
      title: Text("填写表单"),
      content: SizedBox(height: 60, child: Text("请按表单填写个人信息")),
    ),
    Step(title: Text("邮箱校验"), content: Text("请对您的账号进行邮箱校验")),
    Step(title: Text("注册完成"), content: Text("恭喜您，注册完成")),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stepper(
          type: StepperType.horizontal,
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
          controlsBuilder: (_, ControlsDetails details) {
            return Row(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: const CircleBorder(
                        side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
                      )),
                  onPressed: details.onStepContinue,
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: const CircleBorder(
                        side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
                      )),
                  onPressed: details.onStepCancel,
                  child: const Icon(
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
            content: SizedBox(height: 60, child: Text(stepsData[e]!)),
          );
          }).toList()),
    );
  }

  StepState _getState(index){
    if(_position==index) return StepState.editing;
    if(_position>index) return StepState.complete;
    return StepState.indexed;
  }
}
