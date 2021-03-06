import 'dart:async';
import 'package:flutter/services.dart';

import '../../config.dart';
import '../../utils/regular_utils.dart';

///忘记密码
class ForgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgetState();
  }
}

class _ForgetState extends BaseState<ForgetPage> {
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _code = TextEditingController();
  final TextEditingController _pwd = TextEditingController();
  final FocusNode _focusPhone = FocusNode();
  final FocusNode _focusCode = FocusNode();
  final FocusNode _focusPwd = FocusNode();
  var _isEnable = true;
  var _isCodeEnable = true;
  var _isForget = false;
  var _isObscureText = true;

  String _verified = '获取验证码';

  String _requestId;

  Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          backgroundColor: c_0000,
          appBar: CupertinoNavigationBar(
            backgroundColor: c_0000,
            border: Border(),
          ),
          body: ListView(
            padding: EdgeInsets.only(top: m120),
            children: <Widget>[
              _buildEditText(
                  _phone,
                  TextInputType.phone,
                  [LengthLimitingTextInputFormatter(11)],
                  '请输入手机号',
                  Icons.phone_iphone,
                  focusNode: _focusPhone),
              _buildEditText(
                  _code,
                  TextInputType.number,
                  [LengthLimitingTextInputFormatter(6)],
                  '请输入验证码',
                  Icons.verified_user,
                  focusNode: _focusCode,
                  suffix: Padding(
                    padding: EdgeInsets.only(top: m26, right: m30, bottom: m26),
                    child: CupertinoButton(
                        padding: EdgeInsets.only(left: m15, right: m15),
                        borderRadius: BorderRadius.all(Radius.circular(m26)),
                        minSize: 0,
                        child: Text(_verified,
                            style: _isCodeEnable &&
                                    _isCodeEnable &&
                                    isMobileExact(_phone.text)
                                ? s_fff_30
                                : s_afff_30),
                        disabledColor: c_3fff,
                        color: c_999,
                        onPressed: _isEnable &&
                                _isCodeEnable &&
                                isMobileExact(_phone.text)
                            ? _sendCode
                            : null),
                  )),
              _buildEditText(
                _pwd,
                TextInputType.text,
                [LengthLimitingTextInputFormatter(18)],
                '设置密码',
                Icons.lock_outline,
                obscureText: _isObscureText,
                focusNode: _focusPwd,
                suffix: Container(
                    padding: EdgeInsets.only(right: m25),
                    width: m150,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _pwd.text.isEmpty
                            ? Text('')
                            : GestureDetector(
                                child: Icon(CupertinoIcons.clear_circled,
                                    size: m54, color: c_eee),
                                onTap: () {
                                  setState(() {
                                    _pwd.clear();
                                    _isForget = isMobileExact(_phone.text) &&
                                        isPWD(_pwd.text) &&
                                        _code.text.isNotEmpty;
                                  });
                                }),
                        GestureDetector(
                            child: Icon(CupertinoIcons.eye,
                                size: m60, color: c_eee),
                            onTap: () {
                              setState(() {
                                _isObscureText = !_isObscureText;
                              });
                            })
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(left: m60, top: m50, right: m60),
                child: MaterialButton(
                    height: m100,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(m80))),
                    splashColor: c_afff,
                    child: Text('完成',
                        style: _isEnable && _isForget ? s_fff_30 : s_5fff_30),
                    disabledColor: c_5fff,
                    color: c_31b968,
                    onPressed: _isEnable && _isForget ? _forget : null),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('bg/login.jpg'), fit: BoxFit.cover)));
  }

  ///输入框
  Padding _buildEditText(TextEditingController controller, TextInputType type,
      List<TextInputFormatter> formatter, String hint, IconData icon,
      {bool obscureText = false, FocusNode focusNode, Widget suffix}) {
    return Padding(
      padding: EdgeInsets.only(left: m60, top: m30, right: m60),
      child: TextField(
        controller: controller,
        enabled: _isEnable,
        focusNode: focusNode,
        style: s_fff_30,
        cursorColor: c_0482e6,
        onEditingComplete: () {
          if (focusNode == _focusPhone) {
            if (isMobileExact(_phone.text)) {
              // : 2019/5/20 0020 发送短信验证码
              _sendCode();
              FocusScope.of(context).requestFocus(_focusCode);
            } else {
              toast('手机号码格式不正确！');
            }
          } else if (focusNode == _focusCode) {
            FocusScope.of(context).requestFocus(_focusPwd);
          } else if (focusNode == _focusPwd) {
            _forget();
            FocusScope.of(context).detach();
          }
        },
        keyboardType: type,
        obscureText: obscureText,
        inputFormatters: formatter,
        onChanged: (text) {
          setState(() {
            _isForget = isMobileExact(_phone.text) &&
                isPWD(_pwd.text) &&
                _code.text.isNotEmpty;
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
            suffixIcon: suffix == null
                ? controller.text.isEmpty
                    ? null
                    : IconButton(
                        icon: Icon(CupertinoIcons.clear_circled, color: c_eee),
                        onPressed: () {
                          setState(() {
                            controller.clear();
                            _isForget = isMobileExact(_phone.text) &&
                                isPWD(_pwd.text) &&
                                _code.text.isNotEmpty;
                          });
                        })
                : suffix,
            hintStyle: s_fff_30,
            fillColor: c_5fff),
      ),
    );
  }

  ///发送验证码
  _sendCode() {
    if (_isCodeEnable) {
      setState(() {
        _verified = '60s重新获取';
        _isCodeEnable = false;
      });
      api.sendCode({'mobile': _phone.text.trim()}).then((value) {
        toast('验证码已发送');
        _requestId = value;
      },onError: (e){
        _timer.cancel();
        _verified = '获取验证码';
        _isCodeEnable = true;
      });
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          var i = 60 - timer.tick;
          if (i > 0) {
            _verified = '${i}s重新获取';
          } else {
            _verified = '获取验证码';
            _isCodeEnable = true;
            timer.cancel();
          }
        });
      });
    }
  }

  ///重置密码
  _forget() {
    setState(() {
      _isEnable = false;
    });
    api.forget({
      "mobile": _phone.text,
      "requestId": _requestId,
      "verificationCode": _code.text,
      "passWord": _pwd.text
    }).then((v) {
      toast('密码修改成功');
      Navigator.pop(context, _phone.text);
    }, onError: (e) {
      setState(() {
        _isEnable = true;
      });
    });
  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
