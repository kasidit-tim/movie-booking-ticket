import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

void _dioLog(Object obj) {
  debugPrint('[Dio] $obj');
}

class DioClient {
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;

  late final Dio dio;
  String? _token;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      _AuthInterceptor(this),
      LogInterceptor(requestBody: true, responseBody: true, logPrint: _dioLog),
    ]);
  }

  void setBaseUrl(String url) {
    dio.options.baseUrl = url;
  }

  void setToken(String token) {
    _token = token;
  }

  /// Get current token
  String? get token => _token;

  /// GET request with error handling
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      debugPrint('[DioClient] GET $path failed: ${e.message}');
      rethrow;
    }
  }
}

class _AuthInterceptor extends Interceptor {
  final DioClient _client;

  _AuthInterceptor(this._client);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_client.token != null && _client.token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${_client.token}';
    }
    handler.next(options);
  }
}
