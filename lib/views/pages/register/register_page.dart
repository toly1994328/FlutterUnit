import 'package:flutter/material.dart';
import 'package:flutter_unit/views/components/permanent/icon_input.dart';

import 'arc_clipper.dart';
import 'send_code.dart';

/// create by 张风捷特烈 on 2020/4/24
/// contact me by email 1981462002@qq.com
/// 说明:

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController(text: '1981462002@qq.com');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Size winSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Wrap(children: [
        UnitArcBackground(height: winSize.height * 0.32),
        Container(
            width: winSize.width,
            height: winSize.height * 0.68,
            padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
            child: Container(
              // color: Colors.green,
              child: Column(
                children: <Widget>[
                 const Text(
                    "FlutterUnit 注册",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    "更多精彩，更多体验 ~",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  IconInput(
                    icon: Icons.person_outline,
                    textFiled: TextField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '请输入邮箱',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

                 const SizedBox(height: 10),

                  buildInputWithSend(),

                 const Spacer(flex: 1),
                  _buildBtn(),
                 const Spacer(flex: 4),
                ],
              ),
            ))
      ]),
    ));
  }

  Stack buildInputWithSend() {
    return Stack(
      alignment: Alignment(.8, 0),
      children: [
        IconInput(
          icon: Icons.code_outlined,
          textFiled: TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请输入验证码',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        CountDownWidget(
          onPress: () {

          },
        )
      ],
    );
  }

  Widget _buildBtn() => Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Colors.blue,
          onPressed: _doRegister,
          child: Text("开启 Unit 新世界",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
      );

  void _doRegister() {}
}
