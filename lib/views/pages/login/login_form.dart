
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unit/app/res/toly_icon.dart';
import 'package:flutter_unit/components/permanent/feedback_widget.dart';



class LoginFrom extends StatefulWidget {
  @override
  _LoginFromState createState() => _LoginFromState();
}

class _LoginFromState extends State<LoginFrom> {
  final _usernameController = TextEditingController(text: 'toly1994328');
  final _passwordController = TextEditingController(text: '');

  bool _showPwd = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text("FlutterUnit 登录",style: TextStyle(fontSize: 25),),
        SizedBox(height: 5,),
        Text("请使用github用户名登录",style: TextStyle(color: Colors.grey),),
        SizedBox(height:20,),
        buildUsernameInput(),
        Stack(
          alignment: Alignment(.8,0),
          children: [
            buildPasswordInput(),
            FeedbackWidget(
                onPressed: ()=> setState(() => _showPwd=!_showPwd),
                child: Icon(_showPwd?TolyIcon.icon_show:TolyIcon.icon_hide)
            )
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
            Text(
              "如何注册?",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  decoration: TextDecoration.underline),
            )
          ],
        ),
        _buildBtn(),
        buildOtherLogin()
      ],
    );
  }

  void _doLogIn() {

    print('---用户名:${_usernameController.text}------密码：${_passwordController.text}---');

//    BlocProvider.of<LoginBloc>(context).add(
//      EventLogin(
//          username: _usernameController.text,
//          password: _passwordController.text),
//    );
  }

  Widget _buildBtn() => Container(
    margin: EdgeInsets.only(top: 10, left: 10, right: 10,bottom: 0),
    height: 40,
    width: MediaQuery.of(context).size.width,
    child:
    RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      color: Colors.blue,
      onPressed: _doLogIn,
      child: Text("登   录",
          style: TextStyle(color: Colors.white, fontSize: 18)),
    ),
  );

  Widget buildUsernameInput(){
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
          margin:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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

  Widget buildPasswordInput(){
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
          margin:
          const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
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
  Widget buildOtherLogin(){
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top:30.0),
          child: Row(
            children: [
              Expanded(child: Divider(height: 20,)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('第三方登录',style: TextStyle(color: Colors.grey),),
              ),
              Expanded(child: Divider(height: 20,)),
            ],
          ),
        ),
        Icon(TolyIcon.icon_github,color: Colors.black, size: 30,)
      ],
    );
  }
}
