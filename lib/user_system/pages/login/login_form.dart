import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/app/router/unit_router.dart';
import 'package:flutter_unit/app/utils/Toast.dart';
import 'package:flutter_unit/user_system/bloc/login/bloc.dart';
import 'package:flutter_unit/user_system/bloc/login/event.dart';
import 'package:flutter_unit/user_system/bloc/login/state.dart';
import 'package:flutter_unit/views/components/permanent/feedback_widget.dart';

class LoginFrom extends StatefulWidget {
  @override
  _LoginFromState createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final _usernameController = TextEditingController(text: '张风捷特烈');
  final _passwordController = TextEditingController(text: '111111');

  bool _showPwd = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          "FlutterUnit 登录",
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "更多精彩，更多体验 ~",
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(
          height: 20,
        ),
        buildUsernameInput(),
        Stack(
          alignment: Alignment(.8, 0),
          children: [
            buildPasswordInput(),
            FeedbackWidget(
                onPressed: () => setState(() => _showPwd = !_showPwd),
                child: Icon(_showPwd ? TolyIcon.icon_show : TolyIcon.icon_hide))
          ],
        ),
        Row(
          children: <Widget>[
            Checkbox(value: true, onChanged: (e) => {}),
            Text(
              "自动登录",
              style: TextStyle(color: Color(0xff444444), fontSize: 14),
            ),
            Spacer(),
            FeedbackWidget(
              onEnd: () {
                Navigator.of(context).pushReplacementNamed(UnitRouter.register);
              },
              child: Text(
                "用户注册",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    decoration: TextDecoration.underline),
              ),
            )
          ],
        ),
        BlocConsumer<LoginBloc, LoginState>(
          listener: _listenLoginState,
          builder: _buildBtnByState,
        ),
        buildOtherLogin(),
        const Spacer(flex: 4),
      ],
    );
  }

  void _doLogIn() {
    print(
        '---用户名:${_usernameController.text}------密码：${_passwordController.text}---');
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (!_preValidate(username, password)) return;

    BlocProvider.of<LoginBloc>(context).add(DoLogin(username:username, password: password));
  }

  Widget buildUsernameInput() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  Icons.person_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 20.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              Expanded(
                child: TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入用户名...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildPasswordInput() {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                child: Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
              ),
              Container(
                height: 30.0,
                width: 1.0,
                color: Colors.grey.withOpacity(0.5),
                margin: const EdgeInsets.only(left: 00.0, right: 10.0),
              ),
              Expanded(
                child: TextField(
                  obscureText: !_showPwd,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: '请输入密码...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget buildOtherLogin() {
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Row(
            children: [
              Expanded(
                  child: Divider(
                height: 20,
              )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '第三方登录',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
              Expanded(
                  child: Divider(
                height: 20,
              )),
            ],
          ),
        ),
        Icon(
          TolyIcon.icon_github,
          color: Colors.black,
          size: 30,
        )
      ],
    );
  }

  Widget _buildBtnByState(BuildContext context, LoginState state) {
    if(state is LoginLoading){
      return Container(
          margin: EdgeInsets.only(top: 10, bottom: 0),
          height: 40,
          width: 40,
          child: RaisedButton(
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: Colors.blue.withOpacity(0.4),
            onPressed: _doLogIn,
            child: CupertinoActivityIndicator(),
          ));
    }
    return Container(
        margin: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          color: Colors.blue,
          onPressed: _doLogIn,
          child: Text("进入 Unit 世界",
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ));
  }

  void _listenLoginState(BuildContext context, LoginState state) {
    if (state is LoginSuccess) {
      Navigator.of(context).pop();
    }
    if (state is LoginError) {
      Toast.toast(context, '登录失败 : ${state.message}!',
          color: Colors.red, duration: Duration(seconds: 2));
    }
  }

  bool _preValidate(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      Toast.toast(context, '登录失败 : 用户名和密码不能为空!',
          color: Colors.orange, duration: Duration(seconds: 2));
      return false;
    }
    return true;
  }
}
