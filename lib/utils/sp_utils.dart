import 'dart:convert';

import 'package:flutter_bb/bean/login_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

//class SPUtils {
//  factory SPUtils() => _getInstance();
//  static SPUtils _instance;
//  SharedPreferences _prefs;
//
//  static SPUtils _getInstance() {
//    if (_instance == null) _instance = SPUtils._internal();
//    return _instance;
//  }
//
//  SPUtils._internal() {
////    init();
//  }
//
//  Future<SharedPreferences> init() async {
//    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
//    print(
//        '>>>sp>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${DateTime.now().millisecondsSinceEpoch}');
//    return _prefs;
//  }

//}
//
SharedPreferences _prefs;

get isLogin => get('is_login', false);

set isLogin(bool value) => save('is_login', value);

get isJoinGroup => get('is_group', false);

set isJoinGroup(bool value) => save('is_group', value);

get user async => LoginEntity.fromJson(json.decode(await get('user_id', '{}')));

set user(Map<String, dynamic> value) => save('user_id', json.encode(value));

get token => get('Authorization', '');

set token(String value) => save('Authorization', value);

save(String key, value) async {
  if (_prefs == null) _prefs = await SharedPreferences.getInstance();
  switch (value.runtimeType) {
    case String:
      _prefs.setString(key, value);
      break;
    case bool:
      _prefs.setBool(key, value);
      break;
    case int:
      _prefs.setInt(key, value);
      break;
    case double:
      _prefs.setDouble(key, value);
      break;
    case List:
      _prefs.setStringList(key, value);
      break;
    default:
      break;
  }
}

Future<T> get<T>(key, T defValue) async {
  var value = defValue;
  try {
    if (_prefs == null) _prefs = await SharedPreferences.getInstance();
    switch (value.runtimeType) {
      case String:
        value = _prefs.getString(key) ?? defValue;
        break;
      case bool:
        value = _prefs.getBool(key) ?? defValue;
        break;
      case int:
        value = _prefs.getInt(key) ?? defValue;
        break;
      case double:
        value = _prefs.getDouble(key) ?? defValue;
        break;
      case List:
        value = _prefs.getStringList(key) ?? defValue;
        break;
      default:
        break;
    }
  } catch (e) {}
  return value;
}
//}
