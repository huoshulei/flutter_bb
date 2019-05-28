import 'dart:convert';
import 'dart:io';
import 'dart:async';

//import '../config.dart';

//import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_bb/utils/sp_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config.dart';

final _debug = !bool.fromEnvironment("dart.vm.product");
final _baseUrl = 'https://124.133.55.202:7090/';
//final _baseUrl = 'https://192.168.1.120:8504/';
const PEM = '''
-----BEGIN CERTIFICATE-----
MIICajCCAdMCFHcOwwj7OEKCJajsZ/YdrH1NHScfMA0GCSqGSIb3DQEBCwUAMHQx
CzAJBgNVBAYTAmpuMQswCQYDVQQIDAJzZDELMAkGA1UEBwwCam4xDTALBgNVBAoM
BHloYmIxDTALBgNVBAsMBHloYmIxEjAQBgNVBAMMCWxvY2FsaG9zdDEZMBcGCSqG
SIb3DQEJARYKMTExQHFxLmNvbTAeFw0xOTA0MjkwNjE3MTdaFw0yMDA0MjgwNjE3
MTdaMHQxCzAJBgNVBAYTAmpuMQswCQYDVQQIDAJzZDELMAkGA1UEBwwCam4xDTAL
BgNVBAoMBHloYmIxDTALBgNVBAsMBHloYmIxEjAQBgNVBAMMCWxvY2FsaG9zdDEZ
MBcGCSqGSIb3DQEJARYKMTExQHFxLmNvbTCBnzANBgkqhkiG9w0BAQEFAAOBjQAw
gYkCgYEAuoaVbpCF4tzTFUFs6M2gLSV5xEC0FAis57aNLD8my7ojVcmw9pPQluQn
sZxglefnyv0NNrhyjWclALl1oSETcpPQj/my0a/7v7wpSTJ1MP7RAtOXXFyNy2Zt
HQc2fq1XZn6hnny1cSZOjrJ3RKDNtL9MiEpujy9KZT3O1titJu8CAwEAATANBgkq
hkiG9w0BAQsFAAOBgQBuWy5ZI5NtJyebWo0NPbSFObGHY7tXuIXKWM/gsafOrCHt
gBdcEYUgV1duGsk6wz8UuEfzWXTEI3zLNHNnPDDjuTQzkh1Z3ahiQSKZoQ4ucmsd
asqfoIlnxiwCCckr00p7/WmNcWzE4SEtvcOCBw+kkxtRlhV+pnQ7aYgqezc1Gg==
-----END CERTIFICATE-----
''';
final Dio _dio = Dio(
  BaseOptions(
    method: "get",
    baseUrl: _baseUrl,
    connectTimeout: 5000,
    receiveTimeout: 5000,
    followRedirects: true,
  ),
);

Future<Map<String, dynamic>> header() async {
  var authorization = await token;
  return {'Authorization': authorization};
}

var _token;

/// 设置错误统一处理
void _setInterceptor() {
  _dio.interceptors.add(InterceptorsWrapper(
    onRequest: (request) async {
      var headers = request.headers;
      if (headers['Authorization'] == null) {
        if (_token == null) {
          _dio.lock();
          _token ??= await token;
          _dio.unlock();
        }
        headers["Authorization"] = _token;
      }
      return request;
    },
    onResponse: (response) {
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw DioError(
              response: response, message: 'null', error: response.statusCode);
        }
        if (response.data['status'] == 'success') {
          return response;
        } else {
          throw DioError(
              response: response,
              message: response.data['message'],
              error: response.statusCode);
        }
      }
      throw DioError(
          response: response,
          message: response.statusMessage,
          error: response.statusCode);
    },
    onError: (error) async {
      try {
        if (error?.response?.statusCode == 401) _token = null;
        var connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          error.message = '网络连接异常，请检查手机网络设置';
        } else if (error.type == DioErrorType.CONNECT_TIMEOUT) {
          error.message = '链解超时，请检查网络设置';
        } else if (error?.response?.statusCode == 500) {
          error.message = '服务器繁忙';
        }
        return error;
      } catch (e) {
        print('>>>>>><<<<<<><><><><><><><><>>>>$e');
//        return e;
      }
    },
  ));
//  _dio.interceptors.add(CookieManager(PersistCookieJar()));
  _dio.interceptors.add(LogInterceptor(
    request: _debug,
    requestHeader: _debug,
    requestBody: _debug,
    responseBody: _debug,
    responseHeader: _debug,
    error: true,
  ));
}

///设置请求头
void setHeader(Map<String, dynamic> header) {
  _dio.options.headers = header;
}

initDio() {
  (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (client) {
    client.badCertificateCallback = (cert, host, port) {
      if (cert.pem == PEM) return true;
      return false;
    };
//    SecurityContext sc = SecurityContext();
////    sc.setTrustedCertificates('../../assets/myssl.crt');
//    sc.setTrustedCertificatesBytes(utf8.encode(pem));
//    return HttpClient(context: sc);
  };
  _setInterceptor();
//  setHeader(await headers());
}

Future<dynamic> httpJson(String method, String url,
    {Map<String, dynamic> data, bool isJson = true, CancelToken cancel}) async {
  if (method == 'get') {
    isJson = false;
    if (data == null) {
      data = {};
    }
  }

  ///根据请求类型设置 请求体用json 表单直接拼接
  Options op;
  if (isJson) {
    op = Options(contentType: ContentType.parse('application/json'));
  } else {
    op = Options(
        contentType: ContentType.parse('application/x-www-form-urlencoded'));
  }
  op.method = method;
  return _dio
      .request<Map<String, dynamic>>(url,
          data: data, options: op, cancelToken: cancel)
      .then(_logicalSuccessTransform);
}

/// 返回结果统一处理
dynamic _logicalSuccessTransform(Response<Map<String, dynamic>> resp) {
  if (resp.statusCode == 200) {
    return resp.data['rows'];
  }
  return null;
}
