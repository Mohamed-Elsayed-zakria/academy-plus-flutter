import 'package:dio/dio.dart';
import 'auth_service.dart';

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
    
    print('🚀 Request: ${options.method} ${options.uri}');
    print('📤 Headers: ${options.headers}');
    if (options.data != null) {
      print('📦 Data: ${options.data}');
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ Error: ${err.message}');
    print('📊 Status Code: ${err.response?.statusCode}');
    print('📄 Response Data: ${err.response?.data}');
    
    // Handle 401 Unauthorized
    if (err.response?.statusCode == 401) {
      print('🔒 Unauthorized access - token may be expired');
      // You can add logic here to redirect to login screen
    }
    
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('✅ Response: ${response.statusCode} ${response.requestOptions.uri}');
    print('📥 Response Data: ${response.data}');
    
    handler.next(response);
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('🌐 API Request:');
    print('   Method: ${options.method}');
    print('   URL: ${options.uri}');
    print('   Headers: ${options.headers}');
    if (options.data != null) {
      print('   Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('📡 API Response:');
    print('   Status: ${response.statusCode}');
    print('   Data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('💥 API Error:');
    print('   Message: ${err.message}');
    print('   Status: ${err.response?.statusCode}');
    print('   Data: ${err.response?.data}');
    handler.next(err);
  }
}
