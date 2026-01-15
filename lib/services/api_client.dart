import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class ApiClient {
  late Dio _dio;
  static const String _tokenKey = 'auth_token';
  static const String _csrfTokenKey = 'csrf_token';

  ApiClient({Dio? dio}) {
    if (dio != null) {
      // Use provided Dio instance (for testing)
      _dio = dio;
    } else {
      _dio = Dio(
        BaseOptions(
          baseUrl: ApiConfig.apiBaseUrl,
          connectTimeout: ApiConfig.connectTimeout,
          receiveTimeout: ApiConfig.receiveTimeout,
          headers: ApiConfig.defaultHeaders,
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
      );

      // Configure HTTP client adapter to prefer IPv4
      (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.autoUncompress = true;
        // Force IPv4 by preferring IPv4 addresses
        return client;
      };

      // Add interceptors
      _dio.interceptors.add(_AuthInterceptor());
      _dio.interceptors.add(_ErrorInterceptor());
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }
  }

  // Get the Dio instance
  Dio get dio => _dio;
  
  // Set Dio instance (for testing)
  set dio(Dio value) => _dio = value;

  // Set authentication token
  Future<void> setAuthToken(String? token) async {
    if (token != null) {
      await SharedPreferences.getInstance().then((prefs) {
        prefs.setString(_tokenKey, token);
      });
    } else {
      await SharedPreferences.getInstance().then((prefs) {
        prefs.remove(_tokenKey);
      });
    }
  }

  // Get authentication token
  Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  // Clear all tokens
  Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_csrfTokenKey);
  }
}

// Interceptor to add auth token to requests
class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    // Add client type header for mobile
    options.headers['X-Client-Type'] = 'mobile';
    
    handler.next(options);
  }
}

// Interceptor to handle errors
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle different error types
    if (err.response != null) {
      // Server responded with error
      final statusCode = err.response!.statusCode;
      final data = err.response!.data;
      
      String message = 'An error occurred';
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        message = data['message'] as String;
      } else if (data is Map<String, dynamic> && data.containsKey('error')) {
        message = data['error'] as String;
      }
      
      err = DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: message,
      );
    } else if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      err = DioException(
        requestOptions: err.requestOptions,
        type: err.type,
        error: 'Connection timeout. Please check your internet connection.',
      );
    } else if (err.type == DioExceptionType.connectionError) {
      err = DioException(
        requestOptions: err.requestOptions,
        type: err.type,
        error: 'Unable to connect to server. Please check your internet connection.',
      );
    }
    
    handler.next(err);
  }
}
