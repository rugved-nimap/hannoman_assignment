import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('REQUEST =>  ${response.requestOptions.data.toString()}');
    log("URL => ${response.requestOptions.uri}");
    log("DATA => ${jsonEncode(response.data)}");
    super.onResponse(response, handler);
  }
}
