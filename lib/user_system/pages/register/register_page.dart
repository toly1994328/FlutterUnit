import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/user_system/api/system_api.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/app/utils/http_utils/result_bean.dart';
import 'package:flutter_unit/user_system/bloc/authentic/bloc.dart';
import 'package:flutter_unit/user_system/bloc/authentic/state.dart';
import 'package:flutter_unit/user_system/bloc/login/bloc.dart';
import 'package:flutter_unit/user_system/bloc/login/event.dart';
import 'package:flutter_unit/user_system/bloc/register/bloc.dart';
import 'package:flutter_unit/user_system/bloc/register/event.dart';
import 'package:flutter_unit/user_system/bloc/register/state.dart';
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
  final _emailCtrl = TextEditingController(text: '1981462002@qq.com');
  final _codeCtrl = TextEditingController(text: '');

  ValueNotifier<bool> _enableRegister= ValueNotifier<bool>(false);

  bool get enable => _emailCtrl.text.isNotEmpty && _codeCtrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _emailCtrl.addListener(() {
      _enableRegister.value = enable;
    });

    _codeCtrl.addListener(() {
      _enableRegister.value = enable;
    });
  }


  @override
  Widget build(BuildContext context) {
    Size winSize = MediaQuery.of(context).size;

    return Scaffold(
        body: SingleChildScrollView(
      child: Wrap(children: [
        Stack(children:[
          UnitArcBackground(height: winSize.height * 0.32),
          Positioned(
              top: 20,
              child: BackButton(color: Colors.white)),
        ]),
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
                      controller: _emailCtrl,
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
            controller: _codeCtrl,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: '请输入验证码',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        CountDownWidget(
          onPress: _sendEmail,
        )
      ],
    );
  }

  _sendEmail(BuildContext context) async {
    if (!_checkEmail(_emailCtrl.text)) {
      Toast.toast(context, '邮箱格式校验错误，请重试!',
          color: Colors.orange, duration: Duration(seconds: 2));
      return;
    }

    ResultBean<String> result =
        await SystemApi.sendEmail(email: _emailCtrl.text);
    print(result);
    if (result.status) {
      Toast.toast(context, '验证码发送成功，请注意邮箱查收!', duration: Duration(seconds: 2));
    } else {
      Toast.toast(context, '验证码发送失败: ${result.msg}!',
          color: Colors.red, duration: Duration(seconds: 2));
    }
  }

  bool _checkEmail(String email) {
    if (email == null) return false;
    RegExp exp =
        RegExp(r'^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$');
    return exp.hasMatch(email);
  }

  Widget _buildBtn() => Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: BlocConsumer<RegisterBloc, RegisterState>(
          builder: _build,
          listener: _listener,
        ),
      );

  void _doRegister() {
    BlocProvider.of<RegisterBloc>(context)
        .add(DoRegister(_emailCtrl.text, _codeCtrl.text));
  }

  Widget _build(BuildContext context, state) {
    bool enable = state is RegisterLoading || state is RegisterSuccess;
    String info = enable ? '注册中...' : '开启 Unit 新世界';
    return BlocListener<AuthenticBloc, AuthenticState>(
        listener: _listenerLogin,
        child: ValueListenableBuilder(
          valueListenable: _enableRegister,
          builder: (ctx,value,child){
            return RaisedButton(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                color: Colors.blue,
                disabledColor: Colors.blue.withOpacity(0.6),
                onPressed: (enable||!value) ? null : _doRegister,
                child: Text(info,
                    style: TextStyle(color: Colors.white, fontSize: 18)));
          },
        ));
  }

  void _listener(BuildContext context, RegisterState state) {
    if (state is RegisterError) {
      Toast.toast(context, '注册失败 : ${state.message}!',
          color: Colors.red, duration: Duration(seconds: 2));
    }

    if (state is RegisterSuccess) {
      BlocProvider.of<LoginBloc>(context)
          .add(DoLogin(username:_emailCtrl.text, password:_codeCtrl.text));
    }
  }

  void _listenerLogin(BuildContext context, AuthenticState state) {
    if (state is AuthSuccess) {
      Navigator.pop(context);
    }
  }
}
