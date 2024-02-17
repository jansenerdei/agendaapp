// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgendaInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers["X-Parse-Application-Id"] =
        dotenv.get("X-PARSE-APPLICATION-ID");
    options.headers["X-Parse-REST-API-Key"] =
        dotenv.get("X-PARSE-REST-API-KEY");
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
