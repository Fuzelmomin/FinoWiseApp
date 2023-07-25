import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/app_constants.dart';
import 'api_constans.dart';


class DioClient {
  late final Dio _dio;

  DioClient() {
    const _baseUrl = APIConstants.baseUrl;
    Duration duration = Duration(seconds: 30);

    /// paste your API's baseUrl here...
    final BaseOptions _options = BaseOptions(
      sendTimeout: duration,
      connectTimeout: duration,
      receiveTimeout: duration,
      baseUrl: _baseUrl,
      /*headers: {
          "Accept": "application/json",
          "content-type": "application/json"
        }*/
    );

    _dio = Dio(_options);
    _dio.interceptors.add(AuthorizationInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
  }

  Dio getDio() => _dio;
}

class AuthorizationInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // Send user token in headers if it is available
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString(AppConstants.token);
    if (token != null && token.isNotEmpty) {
      options.headers['vAuthorization'] = 'Bearer $token';
    }

    super.onRequest(options, handler);
  }
}

class LoggingInterceptor extends InterceptorsWrapper {
  // todo disable for release builds
  final _logger = Logger();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.d(options.path);
    _logger.d(options.queryParameters.toString());
    _logger.d(options.headers.toString());
    _logger.d(options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.d(response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final errorMessage = err.message;
    final errorData = err.response?.data;
    _logger.e(errorMessage);
    if (errorData != null) {
      _logger.e(errorData);
    }
    super.onError(err, handler);
  }
}
