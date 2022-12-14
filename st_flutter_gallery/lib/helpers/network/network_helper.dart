import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:st/app/models/api_response/api_response_model.dart';
import 'package:st/config/env_config.dart';
import 'package:st/helpers/logger/logger_helper.dart';
import 'package:st/helpers/network/api_exception.dart';
import 'package:st/helpers/network/network_adapter.dart';
import 'package:st/helpers/network/request_config.dart';

class NetworkHelper {
  NetworkHelper({this.baseOptions, this.interceptors, this.networkProxy}) {
    _dio = Dio()
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
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
        ),
      );
    }

    NetworkAdapter.setProxy(_dio, networkProxy ?? '');
  }
  late Dio _dio;
  late BaseOptions? baseOptions;
  late Interceptors? interceptors;
  late String? networkProxy;

  Future<ApiResponseModel?> request(
    String url, {
    String method = "Get",
    Map<String, dynamic>? queryParameters,
    // ignore: type_annotate_public_apis
    data,
    Map<String, dynamic>? headers,
    bool needOriginalData = false,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) async {
    try {
      final options = Options()
        ..method = method
        ..headers = headers;

      data = _convertRequestData(data);

      final response = await _dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
        options: options,
      );

      return _handleResponse(response, needOriginalData: needOriginalData);
    } on Exception catch (e) {
      final exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        logger.severe(exception);
        if (!needOriginalData) {
          if (exception.code != 302) {
            showToast(exception.message ?? '服务器异常');
          }
        }
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
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool needOriginalData = false,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      queryParameters: queryParameters,
      headers: headers,
      needOriginalData: needOriginalData,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
      onError: onError,
    );
  }

  Future<ApiResponseModel?> post(
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
  }) {
    return request(
      url,
      method: "POST",
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

  ///请求响应内容处理
  ApiResponseModel _handleResponse(
    Response response, {
    bool needOriginalData = false,
  }) {
    if (needOriginalData) {
      return ApiResponseModel(response: response);
    }

    if (response.statusCode == 200) {
      final apiResponse = ApiResponseModel.fromJson(response.data);
      return _handleBusinessResponse(apiResponse);
    } else {
      final exception =
          ApiException(response.statusCode, ApiException.unknownException);
      showToast(exception.message!);
      throw exception;
    }
  }

  ///业务内容处理
  ApiResponseModel _handleBusinessResponse(ApiResponseModel response) {
    if (response.isSuccess!) {
      if (kDebugMode) {
        print(jsonEncode(response.data));
      }
      return response;
    } else {
      var exception = ApiException(response.status, response.stackMessage);
      if (response.status == null && response.stackMessage == null) {
        exception = ApiException(-1, '服务器数据异常');
      }
      throw exception;
    }
  }
}
