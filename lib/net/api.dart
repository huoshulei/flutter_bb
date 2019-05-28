import 'package:dio/dio.dart';
import 'package:flutter_bb/base/base_state.dart';
import 'package:flutter_bb/bean/message_entity.dart';

import 'http.dart';
import '../config.dart';
import '../bean/login_entity.dart';

class Api {
  BaseState _state;
  CancelToken _cancel;

  Api(this._state)
      : _cancel = CancelToken(),
        assert(_state != null,'state is null');

  ///登录
  Future<LoginEntity> login(Map<String, String> data) =>
      _postForm('proxyApi/auth/get/passWord/login', data)
          .then((json) => LoginEntity.fromJson(json ?? '{}'));

  ///发送验证码
  Future<String> sendCode(Map<String, String> data) =>
      _postForm('proxyApi/auth/get/verification-code', data)
          .then((json) => json);

  ///注册
  Future<void> register(Map<String, String> data) =>
      _postForm('proxyApi/auth/post/register', data);

  ///修改密码
  Future<void> forget(Map<String, String> data) =>
      _postForm('proxyApi/auth/put/password', data);

  ///检查是否加入团队
  Future<bool> checkJoinGroup(Map<String, String> data) =>
      _postForm('proxyApi/user-service/GET/check-user-team', data)
          .then((value) => value);

  ///消息列表
  Future<List<MessageEntity>> getMessages() => _postForm(
      'proxyApi/user-service/GET/push-info',
      {'currentPage': '0', 'pageSize': '20'}).then(messageListFormJson);

  ///设备评分
  Future<ScoreEntity> getScore() =>
      _postForm('proxyApi/backstage/GET/equipment-fraction', {})
          .then((v) => ScoreEntity.fromJson(v));

  ///    iIYVVVVXVVVVVVVVVYVYVYYVYYYYIIIIYYYIYVVVYYYYYYYYYVVYVVVVXVVVVVYI+.
  ///    tYVXXXXXXVXXXXVVVYVVVVVVVVVVVVYVVVVVVVVVVVVVVVVVXXXXXVXXXXXXXVVYi.
  ///    iYXRXRRRXXXXXXXXXXXVVXVXVVVVVVVVXXXVXVVXXXXXXXXXXXXXXRRRRRRRRRXVi.
  ///    tVRRRRRRRRRRRRRRRXRXXXXXXXXXXXXXXRRXXXXRRRRXXXXXXXRRRRRRRRRRRRXV+.
  ///    tVRRBBBRMBRRRRRRRRRXXRRRRRXt=+;;;;;==iVXRRRRXXXXRRRRRRRRMMBRRRRXi,
  ///    tVRRBMBBMMBBBBBMBBRBBBRBX++=++;;;;;;:;;;IRRRRXXRRRBBBBBBMMBBBRRXi,
  ///    iVRMMMMMMMMMMMMMMBRBBMMV==iIVYIi=;;;;:::;;XRRRRRRBBMMMMMMMMBBRRXi.
  ///    iVRMMMMMMMMMMMMMMMMMMMY;IBWWWWMMXYi=;:::::;RBBBMMMMMMMMMMMMMMBBXi,
  ///    +VRMMRBMMMMMMMMMMMMMMY+;VMMMMMMMRXIi=;:::::=VVXXXRRRMMMMMMMMBBMXi;
  ///    =tYYVVVXRRRXXRBMMMMMV+;=RBBMMMXVXXVYt;::::::ttYYVYVVRMMMMMMBXXVI+=
  ///    ;=tIYYVYYYYYYVVVMMMBt=;;+i=IBi+t==;;i;::::::+iitIIttYRMMMMMRXVVI=;
  ///    ;=IIIIYYYIIIIttIYItIt;;=VVYXBIVRXVVXI;::::::;+iitttttVMMBRRRVVVI+,
  ///    ;+++tttIttttiiii+i++==;;RMMMBXXMMMXI+;::::::;+ittttitYVXVYYIYVIi;;
  ///    ;===iiittiiIitiii++;;;;:IVRVi=iBXVIi;::::::::;==+++++iiittii+++=;;
  ///    ;;==+iiiiiiiiii+++=;;;;;;VYVIiiiVVt+;::::::::;++++++++++iti++++=;;
  ///    ;;=++iiii+i+++++iii==;;;::tXYIIYIi+=;:::::,::;+++++++++++++++++=;;
  ///    ;;;+==+ii+++++iiiiit=;;:::::=====;;;::::::::::+++i+++++++++i+++;;;
  ///    ;;;==+=+iiiiitttIIII+;;;:,::,;;;;:;=;;;::,::::=++++++++==++++++;;;
  ///    :;====+tittiiittttti+;;::::,:=Ytiiiiti=;:::::,:;;==ii+ittItii+==;;
  ///    ;;+iiittIti+ii;;===;;:;::::;+IVXVVVVVVt;;;;;::::;;===;+IIiiti=;;;;
  ///    ;=++++iIti+ii+=;;;=;:::;;+VXBMMBBBBBBXY=;=;;:::::;=iYVIIttii++;;;;
  ///    ;;++iiiItttIi+++=;;:::;=iBMMMMMMMMMMMXI==;;,::;;:;;=+itIttIIti+;;;
  ///    ;=+++++i+tYIIiii;:,::;itXMMMMMMMMMMMBXti==;:;++=;:::::;=+iittti+;;
  ///    ;;+ii+ii+iitiIi;::::;iXBMMMMMWWWWWMMBXti+ii=;::::,,,,:::=;==+tI+;;
  ///    ;;iiiitItttti;:::;::=+itYXXMWWWWWWMBYt+;;::,,,,,,,,,,,,,:==;==;;;;
  ///    :;=iIIIttIt+:;:::;;;==;+=+iiittttti+;;:,:,,,,::,,,,,,,,:::;=;==::;
  ///    ;::=+ittiii=;:::::;;;:;:;=++==;;==;:,,,,,,:;::::,,,,,,,,::;==;;::;
  ///    :::;+iiiii=;::::,:;:::::;;:;;::;:::,,,,,,,:::;=;;;:,,,,,:::;;::::;
  ///    :;;iIIIIII=;:::,:::::::,::::,:::,,,,,,,,,,,:;;=;:,,,,,,::::;=;:::;
  ///    :;==++ii+;;;:::::::::::,,,,,,::,,,,,,,,,,,::::,,,,,,,,,,:,:::::::;
  ///    ::;;=+=;;;:::;;::,,,,,,,,,,,,,,,,,,,,,,,,,:,,,,,,,,,,,,,,,,,:::::;
  ///    ::;=;;;:;:::;;;;::,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,::,,::::;
  ///    :;;:;::::::,::,,:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,:::;
  ///    :::::::::::;;;:,,,,,,,,,,,,,...,...,,,.,,,,,,,,,,,,.,,,,,,,,,,,,:;
  ///    ::::::::;=;;;;;::,,,,,,,,,,,.......,...,,,,,,,,,,,,.,,,,,,,,,,,,,;
  ///    :::::,,:;=;;;;;;;iVXXXVt+:,,....,,,,....,.,,,,,,,.,.....,,,,,,,,:;
  ///    :,,::,,:::;;;;;;=IVVVXXXXVXVt:,,,,,..,..,,,,.,,,,,..,.,,,,,,,,,,,;
  ///    ::,::,,,:,:::::,::;=iIYVXVVVVIYIi;,,.,.,,,::,,,,,,,,,,,,,,,,,,,,,.
  ///    :,,,,,,,,,,,,,,,,::;+itIIIIIIi:;;i++=;;;;;;;;;::,,,...,,..,,,,,,,.
  ///    :,,,,,,,,,,,,,,=iitVYi++iitt==it;;:;;;;::;;::::,,,......,,,,,,,::.
  ///    ::,,,,,,,,,,,,,++iiIVIi=;;=;+i;:;+:::,,,,,,,,,,,,,.....,,,,,,,,::,
  ///    ,,,,,,,,,,,,,,,;=+it=:::,,,,,,,,,,.,......,,.,..........,,,,,,,,::
  ///    :,,,,,,,,,,,,,,,,:=:,,,,,,,,,,,,,,......................,.,,.,.,,:
  ///    :,,,,,,,,,,,,,,,,,:,,,,,,,,,,..,........................,..,...,,:
  ///    ,,,,,,,,,,,,,,,,,,,.....................................,.......,,
  ///    ,,,,,,,,,.,,,,,,,...............................................,,
  ///    itittiiiii+=++=;;=iiiiiiittiiiiii+iii===;++iiitiiiiiii+=====+ii=+i
  ///

  ///get
  Future<dynamic> _getJson(String url, Map<String, dynamic> data) =>
      httpJson('get', url, data: data, cancel: _cancel)
          .then((json) => json, onError: _error);

  ///get form
  Future<dynamic> _getForm(String url, Map<String, dynamic> data) =>
      httpJson('get', url, data: data, isJson: false, cancel: _cancel)
          .then((json) => json, onError: _error);

  ///post json
  Future<dynamic> _postJson(String url, Map<String, dynamic> data) =>
      httpJson('post', url, data: data, cancel: _cancel)
          .then((json) => json, onError: _error);

  ///post form
  Future<dynamic> _postForm(String url, Map<String, dynamic> data) =>
      httpJson('post', url, data: data, isJson: false, cancel: _cancel)
          .then((json) => json, onError: _error);

  ///异常统一处理
  _error(e) {
    _state.toast(e.message);
    if (e.message.contains('您还没有加入任何团队')) {
      isJoinGroup = false;
      _state.refreshGroup(false);
    }
    if (e.message.contains('token异常')) {
      isLogin = false;
      _state.refreshLogin();
    }
    throw e;
  }

  cancel() {
    _cancel.cancel('请求取消');
//    _cancel=null;
//    _state=null;
  }
}
