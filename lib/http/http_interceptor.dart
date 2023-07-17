import 'package:dio/dio.dart';
import 'package:flutter_kit/http/config.dart';

import '../log/log.dart';
import '../widgets/toast/toast.dart';

class HttpInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["Authorization"] = "Bearer $httpAuthorizationToken";
    log("Request", "Response Start", level: LogLevel.success);
    log("Request", "RequestUrl: ${options.baseUrl}${options.path}", level: LogLevel.info);
    log("Request", "RequestHeaders: ${options.headers}", level: LogLevel.info);
    log("Request", "RequestMethod: ${options.method}", level: LogLevel.info);
    log("Request", "RequestData: ${options.data}", level: LogLevel.info);
    log("Request", "RequestQueryParameters: ${options.queryParameters}", level: LogLevel.info);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log("Response", "ResponseCode: ${response.statusCode}", level: LogLevel.success);
    if (response.statusCode == 200) {
      log("Response", "ResponseData: ${response.data}", level: LogLevel.info);
      log("Response", "Response End", level: LogLevel.success);
      super.onResponse(response, handler);
    } else {
      log("Response", "Response End", level: LogLevel.success);
      handler.reject(DioException(requestOptions: response.requestOptions));
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log("onError", "ErrorMessage: ${err.message}", level: LogLevel.error);
    log("onError", "ErrorType: ${err.type}", level: LogLevel.error);
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        Toast.show("链接超时");
        break;
      case DioExceptionType.sendTimeout:
        Toast.show("发送超时");
        break;
      case DioExceptionType.receiveTimeout:
        Toast.show("接收超时");
        break;
      case DioExceptionType.badCertificate:
        Toast.show("验证错误");
        break;
      case DioExceptionType.badResponse:
        Toast.show("响应错误");
        break;
      case DioExceptionType.cancel:
        break;
      case DioExceptionType.connectionError:
        Toast.show("连接错误");
        break;
      case DioExceptionType.unknown:
        Toast.show("服务器错误");
        break;
    }
    log("Response", "Response End", level: LogLevel.success);
    super.onError(err, handler);
  }
}
