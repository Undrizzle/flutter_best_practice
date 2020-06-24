import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_best_practice/constant/constant.dart';
import 'package:flutter_best_practice/utils/dio_util.dart';
import 'package:flutter_best_practice/utils/toast_util.dart';
import 'package:flutter_best_practice/utils/user_util.dart';
import 'package:flutter_best_practice/widgets/text_field_widget.dart';
import 'package:flutter_best_practice/routers/routers.dart';

class LoginPage extends StatefulWidget {
  @override 
  _LoginPageState createState() => _LoginPageState();
}

String _inputAccount = '';
String _inputPassword = '';

class _LoginPageState extends State<LoginPage> {
  TextEditingController _accountController = TextEditingController.fromValue(
    TextEditingValue(
      text: _inputAccount,
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: _inputAccount.length
      ))
    )
  );

  TextEditingController _passwordController = TextEditingController.fromValue(
    TextEditingValue(
      text: _inputPassword,
      selection: TextSelection.fromPosition(TextPosition(
        affinity: TextAffinity.downstream,
        offset: _inputPassword.length
      ))
    )
  );

  @override 
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DropdownButtonHideUnderline(
          child: ListView(
            children: <Widget>[
              buildTile(),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 30.0, bottom: 20.0),
                child: Text(
                  '请输入账号密码',
                  style: TextStyle(fontSize: 24.0, color: Colors.black),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: TextFieldWidget(
                  controller: _accountController,
                  isInputPwd: false,
                  contentStrCallback: (content) {
                    _inputAccount = content;
                    setState(() {});
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                child: TextFieldWidget(
                  controller: _passwordController,
                  isInputPwd: true,
                  contentStrCallback: (content) {
                    _inputPassword = content;
                    setState(() {});
                  },
                ),
              ),
              buildLoginBtn(),
              buildRegisterForget(),
              buildOtherLoginWay(),
            ]
          )
        )
      )
    );
  }

  Widget buildTile() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Image.asset(
              Constant.ASSETS_IMG + 'icon_close.png',
              width: 20.0,
              height: 20.0
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              '随便看看',
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }

  Widget buildLoginBtn() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
      child: RaisedButton(
        color: Color(0xffff8200),
        textColor: Colors.white,
        disabledTextColor: Colors.white,
        disabledColor: Color(0xffffd8af),
        elevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: (_inputAccount.isEmpty || _inputPassword.isEmpty)
          ? null
          : () {
            FormData params = FormData.fromMap({'username': _inputAccount, 'password': _inputPassword});
            DioUtil.getInstance().requestHttp(Constant.Login, 'post', params, (data) {
              UserUtil.saveUserInfo(data['data']);
              Navigator.pop(context);
              Routes.navigateTo(context, Routes.homePage);
            }, (error) {
              ToastUtil.show(error);
            });
          },
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
          child: Text(
            '登 录',
            style: TextStyle(fontSize: 16.0),
          ),
        ),  
      ),
    );
  }

  Widget buildRegisterForget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(left: 20.0, top: 5.0),
            child: Text(
              '忘记密码',
              style: TextStyle(fontSize: 13.0, color: Color(0xff6b91bb)),
            )
          ),
          onTap: () {},
        ),
        InkWell(
          child: Padding(
            padding: EdgeInsets.only(right: 20.0, top: 3.0),
            child: Text(
              '登录遇到问题？',
              style: TextStyle(fontSize: 13.0, color: Color(0xff6b91bb)),
            ),
          ),
          onTap: () {
            
          },
        ),
      ],
    );
  }

  Widget buildOtherLoginWay() {
    return Container(
      margin: EdgeInsets.only(top: 150.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20.0),
                  color: Color(0xffeaeaea),
                  height: 1,
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      '其他登录方式',
                      style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                    ),
                  ),
                ),
                flex: 1,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 20.0),
                  color: Color(0xffeaeaea),
                  height: 1,
                ),
                flex: 1,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      Constant.ASSETS_IMG + 'login_weixin.png',
                      width: 40.0,
                      height: 40.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        '微信',
                        style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20.0, top: 10.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      Constant.ASSETS_IMG + 'login_qq.png',
                      width: 40.0,
                      height: 40.0,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        'QQ',
                        style: TextStyle(fontSize: 12, color: Color(0xff999999)),
                      ),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )
    );
  }
}