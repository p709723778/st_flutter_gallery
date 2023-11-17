import 'package:dio/dio.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/app/models/api_response/api_response_model.dart';
import 'package:st/app/network_request/interceptors/logger_interceptor.dart';
import 'package:st/app/network_request/interceptors/token_interceptor.dart';
import 'package:st/helpers/network/api_exception.dart';
import 'package:st/helpers/network/network_helper.dart';
import 'package:st/helpers/network/request_config.dart';
import 'package:st/services/sp_service/sp_service.dart';

class Http {
  static final NetworkHelper networkHelper = NetworkHelper(
    baseOptions: BaseOptions(
      baseUrl: RequestConfig.baseUrl,
      connectTimeout: RequestConfig.connectTimeout,
      sendTimeout: RequestConfig.sendTimeout,
      receiveTimeout: RequestConfig.receiveTimeout,
    ),
    networkProxy: networkProxy,
    interceptors: interceptors,
  );

  /// 获取代理地址
  static String? get networkProxy {
    final isUseProxy = SpService.getBool(SpKeys.isUseProxy) ?? false;
    if (!isUseProxy) return null;
    return SpService.getString(SpKeys.networkProxy);
  }

  /// 获取拦截器
  static Interceptors? get interceptors {
    final interceptors = Interceptors()
          ..add(TokenInterceptor())
          ..add(LoggerInterceptor())
        // ..add(CookieManager(CookieJar()))
        // ..add(
        //   CookieManager(PersistCookieJar(ignoreExpires: true)),
        // )
        ;

    return interceptors;
  }

  static Future<ApiResponseModel?> get(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) async {
    return networkHelper.get(
      url,
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }

  static Future<ApiResponseModel?> post(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) async {
    return networkHelper.post(
      url,
      queryParameters: queryParameters,
      data: data,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }
}
