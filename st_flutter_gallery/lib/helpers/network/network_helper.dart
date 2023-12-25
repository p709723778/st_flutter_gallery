import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:st/app/models/api_response/api_response_model.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/helpers/network/api_exception.dart';
import 'package:st/helpers/network/network_adapter.dart';
import 'package:st/helpers/network/request_config.dart';

class NetworkHelper {
  NetworkHelper({this.baseOptions, this.interceptors, this.networkProxy}) {
    dio = Dio()
      ..options = baseOptions ??
          BaseOptions(
            baseUrl: RequestConfig.baseUrl,
            connectTimeout: RequestConfig.connectTimeout,
            sendTimeout: RequestConfig.sendTimeout,
            receiveTimeout: RequestConfig.receiveTimeout,
          )
      ..interceptors.addAll(interceptors!);

    /// 调试模式输出日志
    if (kDebugMode || EnvConfig.isDebug) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    setProxy(networkProxy ?? '');
  }
  late Dio dio;
  late BaseOptions? baseOptions;
  late Interceptors? interceptors;
  late String? networkProxy;

  Future<ApiResponseModel?> request(
    String url, {
    String method = "GET",
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) async {
    try {
      final options = Options()
        ..method = method
        ..headers = headers;

      data = _convertRequestData(data);

      final response = await dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );

      return _handleResponse(response);
    } on Exception catch (e) {
      final exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        logger.severe(exception);
        throw exception;
      }
    }

    return null;
  }

  dynamic _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  Future<ApiResponseModel?> get(
    String url, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    bool showLoading = true,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) {
    return request(
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

  Future<ApiResponseModel?> post(
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
  }) {
    return request(
      url,
      method: "POST",
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }

  Future<ApiResponseModel?> delete(
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
  }) {
    return request(
      url,
      method: "DELETE",
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }

  Future<ApiResponseModel?> put(
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
  }) {
    return request(
      url,
      method: "PUT",
      data: data,
      queryParameters: queryParameters,
      cancelToken: cancelToken,
      options: options,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }

  ///请求响应内容处理
  ApiResponseModel _handleResponse(Response response) {
    if (response.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromJson(response.data);
      return _handleBusinessResponse(apiResponse);
    } else {
      final exception =
          ApiException(response.statusCode, ApiException.unknownException);
      throw exception;
    }
  }

  ///业务内容处理
  ApiResponseModel _handleBusinessResponse(ApiResponseModel response) {
    if (response.errorCode != null) {
      return response;
    } else {
      var exception = ApiException(response.errorCode, response.errorMessage);
      if (response.errorCode == null && response.errorMessage == null) {
        exception = ApiException(-1, '服务器数据异常');
      }
      throw exception;
    }
  }
}
