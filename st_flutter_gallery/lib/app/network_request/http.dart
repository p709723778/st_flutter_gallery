import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:st/app/constants/sp_keys.dart';
import 'package:st/app/models/api_response/api_response_model.dart';
import 'package:st/app/network_request/cookie_jar_manager/cookie_jar_manager.dart';
import 'package:st/app/network_request/interceptors/forced_offline_interceptor.dart';
import 'package:st/app/network_request/interceptors/token_interceptor.dart';
import 'package:st/helpers/network/api_exception.dart';
import 'package:st/helpers/network/network_helper.dart';
import 'package:st/helpers/network/request_config.dart';
import 'package:st/services/sp_service/sp_service.dart';

class Http {
  static final NetworkHelper _networkHelper = NetworkHelper(
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
  static Interceptors get interceptors {
    final interceptors = Interceptors()
      ..add(TokenInterceptor())
      ..add(ForcedOfflineInterceptor())
      // ..add(CookieManager(CookieJar()))
      ..add(
        CookieManager(CookieJarManager.cookieJar!),
      );

    return interceptors;
  }

  static Future<ApiResponseModel?> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    // ignore: type_annotate_public_apis
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) async {
    return _networkHelper.get(
      url,
      queryParameters: queryParameters,
      headers: headers,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }

  static Future<ApiResponseModel?> post(
    String url, {
    Map<String, dynamic>? queryParameters,
    // ignore: type_annotate_public_apis
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool needOriginalData = false,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) async {
    return _networkHelper.post(
      url,
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      needOriginalData: needOriginalData,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }
}
