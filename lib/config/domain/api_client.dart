import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import '../interceptor/logging_interceptor.dart';

class ApiClient {
  ApiClient._();

  static final ApiClient _client = ApiClient._();

  static ApiClient get client => _client;

  final String _baseUrl = 'https://api.github.com/users';

  String get baseUrl => _baseUrl;

  final _dio = Dio()..interceptors.add(LoggingInterceptor());

  void init() {
    _dio.options = BaseOptions(
      baseUrl: _baseUrl,
      contentType: 'application/json',
      sendTimeout: const Duration(seconds: 30),
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
    );
  }

  Future<dynamic> get(String endpoint, {Map<String, dynamic> query = const {}}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: query);
      return response.data;
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<dynamic> _handleError(dynamic e) {
    if (e is SocketException) {
      return Future.error("Please connect to a stable internet connection !");
    } else if (e is TimeoutException) {
      return Future.error("The request has timed out !");
    } else if (e is DioException) {
      switch (e.response?.statusCode) {
        case 400:
          return Future.error(e.response?.data['error'] ?? e.response?.data["message"]);
        case 500:
          return Future.error(e.response?.data["message"] ?? "Internal Server Error");
        case 404:
          return Future.error(e.response?.data['message'] ?? e.response?.data['error'] ?? '404 - Not Found');
        case 401:
          return Future.error(e.response?.data['message'] ?? '401 - Unauthorised');
      }

      switch (e.type) {
        case DioExceptionType.sendTimeout:
          return Future.error("Request timeout occurred while sending data. Please try again.");
        case DioExceptionType.receiveTimeout:
          return Future.error("Request timeout occurred while waiting for a response. Please try again.");
        case DioExceptionType.connectionTimeout:
          return Future.error("Connection timeout. Please check your internet connection and try again.");
        case DioExceptionType.connectionError:
          return Future.error("Network connection error. Please ensure you have a stable internet connection.");
        case DioExceptionType.badResponse:
          return Future.error("The server responded with an invalid or unexpected response. Please try again later.");
        case DioExceptionType.badCertificate:
          return Future.error("SSL certificate error. Please check your connection or contact support.");
        case DioExceptionType.cancel:
          return Future.error("Request was canceled. Please try again.");
        case DioExceptionType.unknown:
          return Future.error("An unknown error occurred. Please try again later.");
      }
    }
    return Future.error(e.toString());
  }
}
