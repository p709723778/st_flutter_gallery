import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // TODO(soto): get token from cache
    options.headers["Authorization"] = "Basic ZHhtaF93ZWI6ZHhtaF93ZWJfc2VjcmV0";
    options.headers["token"] = "Bearer ";
    super.onRequest(options, handler);
  }
}
