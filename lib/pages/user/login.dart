import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:xianliao/env.dart';
import 'package:xianliao/services/cache/sql_util.dart';
import 'package:xianliao/models/user/login_entity.dart';
import 'package:xianliao/models/user/user_info_entity.dart';
import 'package:xianliao/services/cli.dart';
import 'package:xianliao/services/cache/local_storage.dart';


class LoginScreen extends StatelessWidget {
  Future<String> loginEvent(loginData) async {
    print(loginData);
    UserInfoData userInfo = UserInfoData();

    var loginInfo =
        await Env.apiClient.login(loginData.name, loginData.password);
    if (loginInfo.data != null) {
      dio.options.headers['Authorization'] = loginInfo.data.assessKey;
      Env.apiClient.getUserInfo().then((user) {
        if (user != null) {
          AuthInfo().saveInfo(loginInfo.data.assessKey);
          userInfo = user.data;
          userInfo.assessKey = loginInfo.data.assessKey;
          userInfo.rule = loginInfo.data.roles;
          DbUtil.insertUser(userInfo);
          return null;
        }
        return null;
      });
      return null;
    } else {
      print('login failed');
      return '用户名和密码不匹配';
    }
    return '登录失败';
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder = BorderRadius.vertical(
      bottom: Radius.circular(10.0),
      top: Radius.circular(20.0),
    );

    return FlutterLogin(
      title: '闲聊',
      onLogin: (loginData) {
        return Future.value(loginEvent(loginData));
        // return Future.value("xxxxx");
      },
      onSignup: (_) => Future(null),
      onSubmitAnimationCompleted: () {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, '/', arguments: {'id': 1});
      },
      onRecoverPassword: (_) => Future(null),
      theme: LoginTheme(
        primaryColor: Color(0xFFAACC99),
        accentColor: Colors.yellow,
        errorColor: Colors.deepOrange,
        titleStyle: TextStyle(
          color: Colors.greenAccent,
          fontFamily: 'Quicksand',
          letterSpacing: 4,
        ),
        bodyStyle: TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.underline,
        ),
        textFieldStyle: TextStyle(
          color: Colors.orange,
          shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
        ),
        buttonStyle: TextStyle(
          fontWeight: FontWeight.w800,
          color: Colors.yellow,
        ),
        cardTheme: CardTheme(
          color: Colors.yellow.shade100,
          elevation: 5,
          margin: EdgeInsets.only(top: 15),
          shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(100.0)),
        ),
        inputTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.purple.withOpacity(.1),
          contentPadding: EdgeInsets.zero,
          errorStyle: TextStyle(
            backgroundColor: Colors.orange,
            color: Colors.white,
          ),
          labelStyle: TextStyle(fontSize: 12),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
            borderRadius: inputBorder,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
            borderRadius: inputBorder,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade700, width: 7),
            borderRadius: inputBorder,
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade400, width: 8),
            borderRadius: inputBorder,
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey, width: 5),
            borderRadius: inputBorder,
          ),
        ),
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.purple,
          backgroundColor: Colors.pinkAccent,
          highlightColor: Colors.lightGreen,
          elevation: 9.0,
          highlightElevation: 6.0,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
        ),
      ),
      messages: LoginMessages(
          usernameHint: "用户名",
          passwordHint: '密码',
          forgotPasswordButton: "忘记密码?",
          loginButton: '登录',
          signupButton: '注册',
          confirmPasswordHint: '重复密码'),
      emailValidator: (val) {
        if (val.isEmpty) {
          return "请输入用户名";
        }
        return null;
      },
      passwordValidator: (val) {
        if (val.isEmpty) {
          return "请输入密码";
        }
        return null;
      },
    );
  }
}
