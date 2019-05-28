import 'package:flutter/services.dart';

//import 'package:flutter_bb/utils/flutter_screenutil.dart';
import 'package:flutter_bb/utils/regular_utils.dart';

import '../../config.dart';
import 'forget_page.dart';
import 'register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends BaseState<LoginPage> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  var _isEnable = true;
  var _isLogin = false;

  @override
  Widget build(BuildContext context) {
//    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return WillPopScope(
        child: Scaffold(
            body: Container(
                child: ListView(
                  padding: EdgeInsets.only(top: m150),
                  children: <Widget>[
                    _buildLogo(),
                    _buildEditText(
                        _name,
                        TextInputType.phone,
                        [LengthLimitingTextInputFormatter(11)],
                        '请输入手机号',
                        Icons.phone_iphone),
                    _buildEditText(
                        _pwd,
                        TextInputType.text,
                        [LengthLimitingTextInputFormatter(18)],
                        '请输入密码',
                        Icons.lock_outline,
                        obscureText: true,
                        focusNode: _focusNode),
                    Padding(
                      padding: EdgeInsets.only(left: m60, top: m50, right: m60),
                      child: MaterialButton(
                          height: m100,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(m80))),
                          splashColor: c_afff,
                          child: Text('登录',
                              style:
                                  _isEnable && _isLogin ? s_fff_30 : s_5fff_30),
                          disabledColor: c_5fff,
                          color: c_31b968,
                          onPressed: _isEnable && _isLogin ? _login : null),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: m60, top: m30, right: m60),
                      child: MaterialButton(
                          height: m100,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(m80)),
                              side: _isEnable
                                  ? BorderSide(width: m2, color: c_eee)
                                  : BorderSide.none),
                          child: Text('注册',
                              style: _isEnable ? s_fff_30 : s_5fff_30),
                          disabledColor: c_5fff,
                          onPressed: _isEnable ? _register : null),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: m60, top: m30, right: m60),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoButton(
                            child: Text('忘记密码？',
                                style: TextStyle(
                                    fontSize: s26,
                                    color: _isEnable ? c_fff : c_5fff,
                                    decoration: TextDecoration.underline)),
                            minSize: 0,
                            padding: EdgeInsets.all(0),
                            disabledColor: c_5fff,
                            onPressed: _isEnable ? _forget : null),
                      ),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('bg/login.jpg'),
                        fit: BoxFit.cover)))),
        onWillPop: _onWillPop);
  }

  ///登录
  void _login() {
    setState(() {
      _isEnable = false;
    });
    api.login({'mobile': _name.text, 'passWord': _pwd.text}).then((login) {
      isLogin = true;
      token = login.headerValue;

      // : 2019/5/18 0018 查询是否加入团队 之后在返回
      api.checkJoinGroup({}).then((v) {
        isJoinGroup = isGroup = v == true;
        Navigator.pop(context, isGroup);
      }, onError: (e) {
        setState(() {
          _isEnable = true;
        });
      });
    }, onError: (e) {
      setState(() {
        _isEnable = true;
      });
    });
  }

  ///注册
  void _register() {
    Navigator.push(
            context, CupertinoPageRoute(builder: (context) => RegisterPage()))
        .then((v) {
      if (v != null) {
        _name.text = v;
      }
    });
  }

  ///忘记密码
  _forget() {
    Navigator.push(
            context, CupertinoPageRoute(builder: (context) => ForgetPage()))
        .then((v) {
      if (v != null) {
        _name.text = v;
      }
    });
  }

  ///输入框
  Padding _buildEditText(TextEditingController controller, TextInputType type,
      List<TextInputFormatter> formatter, String hint, IconData icon,
      {bool obscureText = false, FocusNode focusNode}) {
    return Padding(
      padding: EdgeInsets.only(left: m60, top: m30, right: m60),
      child: TextField(
        controller: controller,
        enabled: _isEnable,
        focusNode: focusNode,
        style: s_fff_30,
        cursorColor: c_0482e6,
        onEditingComplete: () {
          if (focusNode == null) {
            FocusScope.of(context).requestFocus(_focusNode);
          } else {
            _login();
            FocusScope.of(context).detach();
          }
        },
        keyboardType: type,
        obscureText: obscureText,
        inputFormatters: formatter,
        onChanged: (text) {
          setState(() {
            _isLogin = isMobileExact(_name.text) && isPWD(_pwd.text);
          });
        },
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(m80)),
                borderSide: BorderSide(style: BorderStyle.none)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(m80)),
                borderSide: BorderSide(style: BorderStyle.none)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(m80)),
                borderSide: BorderSide(style: BorderStyle.none)),
            filled: true,
            hintText: hint,
            isDense: true,
            prefixIcon: SizedBox(
              width: m150,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(icon, color: c_eee, size: m50),
                  Container(color: c_eee, width: m2, height: m50)
                ],
              ),
            ),
            suffixIcon: controller.text.isEmpty
                ? null
                : IconButton(
                    icon: Icon(CupertinoIcons.clear_circled, color: c_eee),
                    onPressed: () {
                      setState(() {
                        controller.clear();
                        _isLogin =
                            isMobileExact(_name.text) && isPWD(_pwd.text);
                      });
                    }),
            hintStyle: s_fff_30,
            fillColor: c_5fff),
      ),
    );
  }

  ///logo
  Center _buildLogo() {
    return Center(
      heightFactor: 1.2,
      child: PhysicalModel(
        color: c_fff,
        shape: BoxShape.circle,
        elevation: m30,
        child: ClipOval(
          child: Image.asset('icons/logo.png',
              width: m330, height: m330, fit: BoxFit.cover),
        ),
      ),
    );
  }

  ///退出APP
  Future<bool> _onWillPop() async {
    showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
                title: Text('温馨提示'),
                content: Text('确定退出APP?'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () async {
                        Navigator.pop(context);
//                        exit(0);
                        await SystemChannels.platform
                            .invokeMethod('SystemNavigator.pop');
                      },
                      child: Text('确定')),
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('取消'))
                ]));
    return false;
  }
}
