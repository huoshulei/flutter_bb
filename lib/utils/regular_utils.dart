import 'const_utils.dart';

/// 验证手机号（简单）

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isMobileSimple(String string) {
  return isMatch(REGEX_MOBILE_SIMPLE, string);
//            return isMatch(REGEX_MOBILE_EXACT, string)
}

/// 验证手机号（精确）

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isMobileExact(String string) {
  return isMatch(REGEX_MOBILE_EXACT, string);
}

///
///验证电话号码

///@param string 待验证文本
//////
///@return `true`: 匹配<br></br>`false`: 不匹配
///
bool isTel
    (String string) {
  return isMatch(REGEX_TEL, string);
}

/// 验证身份证号码15位

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isIDCard15(String string) {
  return isMatch(REGEX_IDCARD15, string);
}

///验证身份证号码18位

///@param string 待验证文本
///@return `true`: 匹配<br></br>`false`: 不匹配
bool isIDCard18
    (String string) {
  return isMatch(REGEX_IDCARD18, string);
}

/// 验证邮箱

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isEmail
    (String string) {
  return isMatch(REGEX_EMAIL, string);
}

/// 验证URL

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isURL
    (String string) {
  return isMatch(REGEX_URL, string);
}

/// 验证汉字

/// @param string 待验证文本
/// ///
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isChz
    (String string) {
  return isMatch(REGEX_CHZ, string);
}

/// 验证用户名
///
/// 取值范围为a-z,A-Z,0-9,"_",汉字，不能以"_"结尾,用户名必须是6-20位

/// @param string 待验证文本
/// ///
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isUsername
    (String string) {
  return isMatch(REGEX_USERNAME, string);
}

/// 验证yyyy-MM-dd格式的日期校验，已考虑平闰年

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isDate
    (String string) {
  return isMatch(REGEX_DATE, string);
}

/// 验证IP地址

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isIP
    (String string) {
  return isMatch(REGEX_IP, string);
}

/// 验证密码

/// @param string 待验证文本
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isPWD
    (String string) {
  return isMatch(PASSWORD, string);
}

/// string是否匹配regex

/// @param regex  正则表达式字符串
/// @param string 要匹配的字符串
/// @return `true`: 匹配<br></br>`false`: 不匹配
bool isMatch(String regex, String string) {
  return string != null && string.isNotEmpty && RegExp(regex).hasMatch(string);
}