import 'dart:developer';

import 'package:dio/dio.dart';

import '../constants/end_points.dart';
import 'cache_helper.dart';

class WebService {
  String get token{
    return SharedPref.get(key: "accessToken") ?? "null";
  }
  Dio publicDio = Dio();

  static WebService? _this;

  factory WebService() {
    _this ??= WebService._();
    return _this!;
  }

  WebService._() {
    publicDio.options.baseUrl = EndPoints.baseUrl;
    publicDio.options.connectTimeout = const Duration(milliseconds: 30000);
    publicDio.options.sendTimeout = const Duration(milliseconds: 30000);
    publicDio.options.receiveTimeout = const Duration(milliseconds: 30000);
    publicDio.options.connectTimeout = const Duration(milliseconds: 30000);

    interceptors();
  }

  void interceptors() {
    publicDio.interceptors.clear();
    publicDio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (!options.path.contains(EndPoints.loginToken)) {
          if (token.isNotEmpty) {
            options.headers['Authorization'] = "Token $token";
          }
        }
        log("send request ${options.uri}");
        log("header ${options.headers}");
        log("data ${options.data}");
        log("query Parameters ${options.queryParameters}");
        return handler.next(options);
      },
      onError: (e, handler) {
        log("path ${e.requestOptions.path}");
        log("response ${e.response}");
        log("status Code ${e.response?.statusCode}");
        log("data ${e.response?.data}");
        return handler.next(e);
      },
      onResponse: (e, handler) {
        log("response data ${e.data}");
        return handler.next(e);
      },
    ));
  }

}
