import 'package:app/app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:toly_ui/toly_ui.dart';
import 'package:utils/utils.dart';

import '../../../authentication.dart';


class LoginFrom extends StatefulWidget {
  const LoginFrom({Key? key}) : super(key: key);

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
        const Text(
          "Flutter Unit 登录",
          style: TextStyle(fontSize: 25),
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          "登录账号，更多精彩，更多体验 ~",
          style: TextStyle(color: Colors.grey),
        ),
        const SizedBox(
          height: 20,
        ),
        buildUsernameInput(),
        Stack(
          alignment: const Alignment(.8, 0),
          children: [
            buildPasswordInput(),
            FeedbackWidget(
                onPressed: () => setState(() => _showPwd = !_showPwd),
                child: Icon(_showPwd ? TolyIcon.icon_show : TolyIcon.icon_hide))
          ],
        ),
        // Row(
        //   children: <Widget>[
        //     Checkbox(value: true, onChanged: (e) => {}),
        //     const Text(
        //       "自动登录",
        //       style: TextStyle(color: Color(0xff444444), fontSize: 14),
        //     ),
        //     const Spacer(),
        //
        //   ],
        // ),
        BlocConsumer<AuthBloc, AuthState>(
          listener: _listenLoginState,
          builder: _buildBtnByState,
        ),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).pushReplacementNamed(UnitRouter.register);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: const Text(
              "没有账号，立即注册",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  decoration: TextDecoration.underline,decorationColor: Colors.blue),
            ),
          ),
        ),
        // buildOtherLogin(),
        const Spacer(flex: 4),
      ],
    );
  }

  void _doLogIn() {
    print('---用户名:${_usernameController.text}------密码：${_passwordController.text}---');
    String username = _usernameController.text;
    String password = _passwordController.text;
    if (!_preValidate(username, password)) return;
    BlocProvider.of<AuthBloc>(context).add(
      AuthByPassword(username: username, password: password),
    );
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
              const Padding(
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
                  decoration: const InputDecoration(
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
              const Padding(
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
                  decoration: const InputDecoration(
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
            children: const [
              Expanded(
                  child: Divider(
                height: 20,
              )),
              Padding(
                padding: EdgeInsets.all(8.0),
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
        const Icon(
          TolyIcon.icon_github,
          color: Colors.black,
          size: 30,
        )
      ],
    );
  }

  Widget _buildBtnByState(BuildContext context, AuthState state) {
    if (state is AuthLoading) {
      return Container(
          margin: const EdgeInsets.only(top: 10, bottom: 0),
          height: 40,
          width: 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              backgroundColor: Colors.blue.withOpacity(0.4),
            ),
            onPressed: _doLogIn,
            child: const CupertinoActivityIndicator(),
          ));
    }
    return Container(
        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 0),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: Colors.blue,
          ),
          onPressed: _doLogIn,
          child: const Text("进入 Unit 世界",
              style: TextStyle(color: Colors.white, fontSize: 14,fontWeight: FontWeight.bold)),
        ));
  }

  void _listenLoginState(BuildContext context, AuthState state) {
    if (state is AuthSuccess) {
      Navigator.of(context).pop();
    }
    if (state is AuthFailure) {
      Toast.toast(context, '登录失败 : ${state.error}!',
          color: Colors.red, duration: const Duration(seconds: 2));
    }
  }

  bool _preValidate(String username, String password) {
    if (username.isEmpty || password.isEmpty) {
      Toast.toast(context, '登录失败 : 用户名和密码不能为空!',
          color: Colors.orange, duration: const Duration(seconds: 2));
      return false;
    }
    return true;
  }
}
