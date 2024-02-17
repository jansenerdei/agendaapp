import 'package:agendaapp/repository/agenda_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AgendaCustomDio {
  final _dio = Dio();

  Dio get dio => _dio;

  AgendaCustomDio() {
    _dio.options.headers["Content-Type"] = "application/json";
    _dio.options.baseUrl = dotenv.get("AGENDA_BASEURL");
    _dio.interceptors.add(AgendaInterceptor());
  }
}
