import 'package:dio/dio.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:let_log/let_log.dart';
import 'package:st/helpers/logger/logger_helper.dart';

class LoggerInterceptor extends Interceptor {
  final Map<String, DateTime> _map = {};

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    final String? nonce = options.headers['Nonce'];
    if (nonce != null) {
      _map[nonce] = DateTime.now();
    }
    Logger.net(options.path, data: options.data);
    logger.fine("[HTTP] ${options.path} start");
    super.onRequest(options, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    final t = _map[err.requestOptions.headers["Nonce"]] ?? DateTime.now();
    logger.fine(
      "[HTTP] ${err.requestOptions.path} error in ${DateTime.now().difference(t).inMilliseconds}ms",
    );
    Logger.endNet(err.requestOptions.path, status: 400);
    super.onError(err, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    final t = _map[response.requestOptions.headers["Nonce"]] ?? DateTime.now();
    logger.fine(
      "[HTTP] ${response.requestOptions.path} done in ${DateTime.now().difference(t).inMilliseconds}ms",
    );

    Logger.endNet(
      response.requestOptions.path,
      data: response.data,
      headers: response.headers,
      status: response.statusCode ?? 0,
    );
    super.onResponse(response, handler);
  }
}
