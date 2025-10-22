import 'package:dio/dio.dart';
import 'auth_service.dart';
import 'dart:developer';

class DioService {
  static Dio? _dio;
  static const Duration _timeout = Duration(seconds: 30);

  static Dio get instance {
    _dio ??= _createDio();
    return _dio!;
  }

  static Dio _createDio() {
    final dio = Dio();
    
    // Base options
    dio.options = BaseOptions(
      connectTimeout: _timeout,
      receiveTimeout: _timeout,
      sendTimeout: _timeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    // Add interceptors
    dio.interceptors.addAll([
      _AuthInterceptor(),
      _LoggingInterceptor(),
    ]);

    return dio;
  }

  // Method to update token after login
  static void updateToken(String token) {
    if (_dio != null) {
      _dio!.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  // Method to clear token after logout
  static void clearToken() {
    if (_dio != null) {
      _dio!.options.headers.remove('Authorization');
    }
  }
}

class _AuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Add token to headers if available
    final token = await AuthService.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    
    log('🚀 Request: ${options.method} ${options.uri}');
    log('📤 Headers: ${options.headers}');
    if (options.data != null) {
      log('📦 Data: ${options.data}');
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('❌ Error: ${err.message}');
    log('📊 Status Code: ${err.response?.statusCode}');
    log('📄 Response Data: ${err.response?.data}');
    
    // Handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      log('🔒 Unauthorized access - token may be expired');
      // You can add logic here to redirect to login screen
    }
    
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('✅ Response: ${response.statusCode} ${response.requestOptions.uri}');
    log('📥 Response Data: ${response.data}');
    
    handler.next(response);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('🌐 API Request:');
    log('   Method: ${options.method}');
    log('   URL: ${options.uri}');
    log('   Headers: ${options.headers}');
    if (options.data != null) {
      log('   Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('📡 API Response:');
    log('   Status: ${response.statusCode}');
    log('   Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('💥 API Error:');
    log('   Message: ${err.message}');
    log('   Status: ${err.response?.statusCode}');
    log('   Data: ${err.response?.data}');
    handler.next(err);
  }
}
